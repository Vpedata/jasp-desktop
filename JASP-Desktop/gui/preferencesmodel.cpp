#include "preferencesmodel.h"
#include "utils.h"

#include "utilities/settings.h"
#include "gui/messageforwarder.h"

using namespace std;

PreferencesModel::PreferencesModel(QObject *parent) :
	QObject(parent)
{
	connect(this, &PreferencesModel::missingValuesChanged,		this, &PreferencesModel::updateUtilsMissingValues	);
	connect(this, &PreferencesModel::useDefaultPPIChanged,		this, &PreferencesModel::onUseDefaultPPIChanged		);
	connect(this, &PreferencesModel::defaultPPIChanged,			this, &PreferencesModel::onDefaultPPIChanged		);
	connect(this, &PreferencesModel::customPPIChanged,			this, &PreferencesModel::onCustomPPIChanged			);

	connect(this, &PreferencesModel::useDefaultPPIChanged,		this, &PreferencesModel::plotPPIPropChanged			);
	connect(this, &PreferencesModel::defaultPPIChanged,			this, &PreferencesModel::plotPPIPropChanged			);
	connect(this, &PreferencesModel::customPPIChanged,			this, &PreferencesModel::plotPPIPropChanged			);
}

PreferencesModel::~PreferencesModel()
{

}

void PreferencesModel::browseSpreadsheetEditor()
{
	
	QString filter = "File Description (*.*)";
	QString applicationfolder;

#ifdef _WIN32
	applicationfolder = "c:\\Program Files";
#elif __APPLE__
	applicationfolder = "/Applications";
#else
	applicationfolder = "/usr/bin";
#endif

	QString filename = MessageForwarder::browseOpenFile("Select a file...", applicationfolder, filter);

	if (filename != "")
		setCustomEditor(filename);
	
}

void PreferencesModel::browseDeveloperFolder()
{
	QString defaultfolder = developerFolder();
	if (defaultfolder.isEmpty())
	{
#ifdef _WIN32
		defaultfolder = "c:\\";
#else
		defaultfolder = "~";
#endif
	}

	QString folder = MessageForwarder::browseOpenFolder("Select a folder...", defaultfolder);

	if (!folder.isEmpty())
		setDeveloperFolder(folder);
		
}

#define GET_PREF_FUNC(TYPE, NAME, SETTING, TO_FUNC)	TYPE PreferencesModel::NAME() const { return Settings::value(SETTING).TO_FUNC; }
#define GET_PREF_FUNC_BOOL(NAME, SETTING)					GET_PREF_FUNC(bool,		NAME, SETTING, toBool())
#define GET_PREF_FUNC_INT(NAME, SETTING)					GET_PREF_FUNC(int,		NAME, SETTING, toInt())
#define GET_PREF_FUNC_STR(NAME, SETTING)					GET_PREF_FUNC(QString,	NAME, SETTING, toString())
#define GET_PREF_FUNC_DBL(NAME, SETTING)					GET_PREF_FUNC(double,	NAME, SETTING, toDouble())
#define GET_PREF_FUNC_WHT(NAME, SETTING)					GET_PREF_FUNC(bool,		NAME, SETTING, toString() == "white")

GET_PREF_FUNC_BOOL(	fixedDecimals,				Settings::FIXED_DECIMALS							)
GET_PREF_FUNC_INT(	numDecimals,				Settings::NUM_DECIMALS								)
GET_PREF_FUNC_BOOL(	exactPValues,				Settings::EXACT_PVALUES								)
GET_PREF_FUNC_BOOL(	dataAutoSynchronization,	Settings::DATA_AUTO_SYNCHRONIZATION					)
GET_PREF_FUNC_BOOL(	useDefaultEditor,			Settings::USE_DEFAULT_SPREADSHEET_EDITOR			)
GET_PREF_FUNC_STR(	customEditor,				Settings::SPREADSHEET_EDITOR_NAME					)
GET_PREF_FUNC_STR(	developerFolder,			Settings::DEVELOPER_FOLDER							)
GET_PREF_FUNC_BOOL(	useDefaultPPI,				Settings::PPI_USE_DEFAULT							)
GET_PREF_FUNC_INT(	customPPI,					Settings::PPI_CUSTOM_VALUE							)
GET_PREF_FUNC_WHT(	whiteBackground,			Settings::IMAGE_BACKGROUND							)
GET_PREF_FUNC_BOOL(	developerMode,				Settings::DEVELOPER_MODE							)
GET_PREF_FUNC_DBL(	uiScale,					Settings::UI_SCALE									)
GET_PREF_FUNC_BOOL(	customThresholdScale,		Settings::USE_CUSTOM_THRESHOLD_SCALE				)
GET_PREF_FUNC_INT(	thresholdScale,				Settings::THRESHOLD_SCALE							)
GET_PREF_FUNC_BOOL(	devModRegenDESC,			Settings::DEVELOPER_MODE_REGENERATE_DESCRIPTION_ETC	)
GET_PREF_FUNC_BOOL(	logToFile,					Settings::LOG_TO_FILE								)
GET_PREF_FUNC_INT(	logFilesMax,				Settings::LOG_FILES_MAX								)
GET_PREF_FUNC_INT(	maxFlickVelocity,			Settings::QML_MAX_FLICK_VELOCITY					)
GET_PREF_FUNC_BOOL(	modulesRemember,			Settings::MODULES_REMEMBER							)
GET_PREF_FUNC_BOOL(	safeGraphics,				Settings::SAFE_GRAPHICS_MODE						)
GET_PREF_FUNC_STR(	cranRepoURL,				Settings::CRAN_REPO_URL								)

QStringList PreferencesModel::missingValues()		const
{
	QStringList items = Settings::value(Settings::MISSING_VALUES_LIST).toString().split("|");

	return items;
}

QStringList PreferencesModel::modulesRemembered()	const
{
	QStringList items = Settings::value(Settings::MODULES_REMEMBERED).toString().split("|");

	return items;
}

void PreferencesModel::moduleEnabledChanged(QString moduleName, bool enabled)
{
	QStringList list = modulesRemembered();

	if(list.contains(moduleName) != enabled)
	{
		if(enabled)	list.append(moduleName);
		else		list.removeAll(moduleName);
	}

	setModulesRemembered(list);
}

QString PreferencesModel::fixedDecimalsForJS() const
{
	if(!fixedDecimals())
		return "\"\"";

	return QString::fromStdString(std::to_string(numDecimals()));
}

void PreferencesModel::setFixedDecimals(bool newFixedDecimals)
{
	if (fixedDecimals() == newFixedDecimals)
		return;

	Settings::setValue(Settings::FIXED_DECIMALS, newFixedDecimals);

	emit fixedDecimalsChanged(newFixedDecimals);
	emit fixedDecimalsChangedString(fixedDecimalsForJS());
}

void PreferencesModel::setNumDecimals(int newNumDecimals)
{
	if (numDecimals() == newNumDecimals)
		return;

	Settings::setValue(Settings::NUM_DECIMALS, newNumDecimals);

	emit numDecimalsChanged(newNumDecimals);

	if(fixedDecimals())
		emit fixedDecimalsChangedString(fixedDecimalsForJS());
}

void PreferencesModel::onUseDefaultPPIChanged(bool )
{
	if(customPPI() != defaultPPI())
		emit plotPPIChanged(plotPPI(), true);
}

void PreferencesModel::onCustomPPIChanged(int)
{
	if(!useDefaultPPI())
		emit plotPPIChanged(plotPPI(), true);
}

void PreferencesModel::onDefaultPPIChanged(int)
{

	if(useDefaultPPI())
		emit plotPPIChanged(plotPPI(), false);
}

#define SET_PREF_FUNCTION(TYPE, FUNC_NAME, GET_FUNC, NOTIFY, SETTING)	\
void PreferencesModel::FUNC_NAME(TYPE newVal)							\
{																		\
	if(GET_FUNC() == newVal) return;									\
	Settings::setValue(SETTING, newVal);								\
	emit NOTIFY(newVal);												\
}


SET_PREF_FUNCTION(bool,		setExactPValues,			exactPValues,				exactPValuesChanged,			Settings::EXACT_PVALUES								)
SET_PREF_FUNCTION(bool,		setDataAutoSynchronization, dataAutoSynchronization,	dataAutoSynchronizationChanged, Settings::DATA_AUTO_SYNCHRONIZATION					)
SET_PREF_FUNCTION(bool,		setUseDefaultEditor,		useDefaultEditor,			useDefaultEditorChanged,		Settings::USE_DEFAULT_SPREADSHEET_EDITOR			)
SET_PREF_FUNCTION(QString,	setCustomEditor,			customEditor,				customEditorChanged,			Settings::SPREADSHEET_EDITOR_NAME					)
SET_PREF_FUNCTION(bool,		setUseDefaultPPI,			useDefaultPPI,				useDefaultPPIChanged,			Settings::PPI_USE_DEFAULT							)
SET_PREF_FUNCTION(bool,		setDeveloperMode,			developerMode,				developerModeChanged,			Settings::DEVELOPER_MODE							)
SET_PREF_FUNCTION(QString,	setDeveloperFolder,			developerFolder,			developerFolderChanged,			Settings::DEVELOPER_FOLDER							)
SET_PREF_FUNCTION(int,		setCustomPPI,				customPPI,					customPPIChanged,				Settings::PPI_CUSTOM_VALUE							)
SET_PREF_FUNCTION(bool,		setDevModRegenDESC,			devModRegenDESC,			devModRegenDESCChanged,			Settings::DEVELOPER_MODE_REGENERATE_DESCRIPTION_ETC	)
SET_PREF_FUNCTION(bool,		setLogToFile,				logToFile,					logToFileChanged,				Settings::LOG_TO_FILE								)
SET_PREF_FUNCTION(int,		setLogFilesMax,				logFilesMax,				logFilesMaxChanged,				Settings::LOG_FILES_MAX								)
SET_PREF_FUNCTION(int,		setMaxFlickVelocity,		maxFlickVelocity,			maxFlickVelocityChanged,		Settings::QML_MAX_FLICK_VELOCITY					)
SET_PREF_FUNCTION(bool,		setModulesRemember,			modulesRemember,			modulesRememberChanged,			Settings::MODULES_REMEMBER							)
SET_PREF_FUNCTION(QString,	setCranRepoURL,				cranRepoURL,				cranRepoURLChanged,				Settings::CRAN_REPO_URL								)

void PreferencesModel::setWhiteBackground(bool newWhiteBackground)
{
	if (whiteBackground() == newWhiteBackground)
		return;

	Settings::setValue(Settings::IMAGE_BACKGROUND, newWhiteBackground ? "white" : "transparent");
	emit whiteBackgroundChanged(newWhiteBackground);
	emit plotBackgroundChanged(Settings::value(Settings::IMAGE_BACKGROUND).toString());
}

void PreferencesModel::setDefaultPPI(int defaultPPI)
{
	if (_defaultPPI == defaultPPI)
		return;

	_defaultPPI = defaultPPI;
	emit defaultPPIChanged(_defaultPPI);
}

void PreferencesModel::setUiScale(double newUiScale)
{
	newUiScale = std::min(3.0, std::max(0.2, newUiScale));

	if (std::abs(uiScale() - newUiScale) < 0.001)
		return;

	Settings::setValue(Settings::UI_SCALE, newUiScale);
	emit uiScaleChanged(newUiScale);
}

void PreferencesModel::setModulesRemembered(QStringList newModulesRemembered)
{
	if (modulesRemembered() == newModulesRemembered)
		return;

	Settings::setValue(Settings::MODULES_REMEMBERED, newModulesRemembered.join('|'));
	emit modulesRememberedChanged();
}

void PreferencesModel::setSafeGraphics(bool newSafeGraphics)
{
	if (safeGraphics() == newSafeGraphics)
		return;

	Settings::setValue(Settings::SAFE_GRAPHICS_MODE, newSafeGraphics);
	emit modulesRememberChanged(newSafeGraphics);

	MessageForwarder::showWarning("Safe Graphics mode changed", "You've changed the Safe Graphics mode of JASP, for this option to take effect you need to restart JASP");
}

void PreferencesModel::zoomIn()
{
	setUiScale(uiScale() + 0.1);
}

void PreferencesModel::zoomOut()
{
	if (uiScale() >= 0.2)
		setUiScale(uiScale() - 0.1);
}

void PreferencesModel::zoomReset()
{
	setUiScale(1.0);
}


void PreferencesModel::removeMissingValue(QString value)
{
	QStringList currentValues = missingValues();
	if(currentValues.contains(value))
	{
		currentValues.removeAll(value);
		Settings::setValue(Settings::MISSING_VALUES_LIST, currentValues.join("|"));
		emit missingValuesChanged();
	}
}

void PreferencesModel::addMissingValue(QString value)
{
	{
		QStringList currentValues = missingValues();
		if(!currentValues.contains(value))
		{
			currentValues.append(value);
			Settings::setValue(Settings::MISSING_VALUES_LIST, currentValues.join("|"));
			emit missingValuesChanged();
		}
	}
}

void PreferencesModel::resetMissingValues()
{
	QStringList currentValues = missingValues();
	Settings::setValue(Settings::MISSING_VALUES_LIST, Settings::defaultMissingValues);

	if(missingValues() != currentValues)
		emit missingValuesChanged();
}

void PreferencesModel::setCustomThresholdScale(bool newCustomThresholdScale)
{
	if (customThresholdScale() == newCustomThresholdScale)
		return;

	Settings::setValue(Settings::USE_CUSTOM_THRESHOLD_SCALE, newCustomThresholdScale);
	emit customThresholdScaleChanged (newCustomThresholdScale);
}

void PreferencesModel::setThresholdScale(int newThresholdScale)
{
	if (thresholdScale() == newThresholdScale)
		return;

	Settings::setValue(Settings::THRESHOLD_SCALE, newThresholdScale);
	emit thresholdScaleChanged(newThresholdScale);

}

void PreferencesModel::updateUtilsMissingValues()
{
	missingValuesToStdVector(Utils::_currentEmptyValues);
	Utils::processEmptyValues();
}

void PreferencesModel::missingValuesToStdVector(std::vector<std::string> & out)	const
{
	QStringList currentValues = missingValues();

	out.resize(size_t(currentValues.size()));

	for(size_t i=0; i<out.size(); i++)
		out[i] = currentValues[int(i)].toStdString();
}

