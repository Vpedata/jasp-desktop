//
// Copyright (C) 2013-2017 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

#include "bainttestbayesianonesampleform.h"
#include "ui_bainttestbayesianonesampleform.h"

#include "widgets/itemmodelselectvariable.h"


BainTTestBayesianOneSampleForm::BainTTestBayesianOneSampleForm(QWidget *parent) :
	AnalysisForm("BainTTestBayesianOneSampleForm", parent),
	ui(new Ui::BainTTestBayesianOneSampleForm)
{
	ui->setupUi(this);

	_availableVariablesModel.setVariableTypesSuggested(Column::ColumnTypeScale);
	_availableVariablesModel.setVariableTypesAllowed(Column::ColumnTypeScale | Column::ColumnTypeOrdinal | Column::ColumnTypeNominal);

	ui->listAvailableFields->setModel(&_availableVariablesModel);
	ui->listAvailableFields->setDoubleClickTarget(ui->variables);

	TableModelVariablesAssigned *variablesModel = new TableModelVariablesAssigned(this);
	variablesModel->setSource(&_availableVariablesModel);
	variablesModel->setVariableTypesSuggested(Column::ColumnTypeScale);
	variablesModel->setVariableTypesAllowed(Column::ColumnTypeScale | Column::ColumnTypeOrdinal | Column::ColumnTypeNominal);
	ui->variables->setModel(variablesModel);
	ui->variables->setDoubleClickTarget(ui->listAvailableFields);

	ui->buttonAssign_main_fields->setSourceAndTarget(ui->listAvailableFields, ui->variables);

	ItemModelSelectVariable *model = new ItemModelSelectVariable(this);
	model->setSource(&_availableVariablesModel);

#ifndef JASP_DEBUG
    ui->logscale->hide();
#else
    ui->logscale->setStyleSheet("background-color: pink;");
#endif

}

BainTTestBayesianOneSampleForm::~BainTTestBayesianOneSampleForm()
{
	delete ui;
}