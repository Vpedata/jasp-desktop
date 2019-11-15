import QtQuick			2.13
import JASP.Widgets		1.0
import JASP.Theme		1.0
import QtQuick.Controls	2.4

Popup
{
    id:					plotEditorPopup
    y:					(parent.height / 2) - (height / 2)
    x:					(parent.width  / 2) - (width  / 2)
    width:				parent.width  * 0.8
    height:				parent.height * 0.8
    modal:				true
    background:			Rectangle { color: Theme.uiBackground }
    closePolicy:		Popup.CloseOnPressOutside | Popup.CloseOnEscape

    visible:			plotEditorModel.visible
    onVisibleChanged:	plotEditorModel.visible = visible

    Loader
    {
        visible:			plotEditorModel.visible
        sourceComponent:	visible ? plotEditorComponent : null
        anchors.fill:		parent
    }

    Component
    {
        id:		plotEditorComponent

        Rectangle
        {
            color:			Theme.uiBackground
            border.color:	Theme.uiBorder
            border.width:	preferencesModel.uiScale

            Flickable
            {
                anchors.fill:		parent
                anchors.margins:	Theme.generalAnchorMargin
                clip:				true
                contentWidth:		width
                contentHeight:		imgOpts.height

                Item
                {
                    id:			imgOpts
                    width:		parent.width
                    //spacing:	Theme.rowSpacing
                    height:		childrenRect.height

                    Text
                    {
                        id:							title
                        font:						Theme.fontLabel
                        text:						plotEditorModel.title
                        anchors.horizontalCenter:	parent.horizontalCenter
                        y:							Theme.generalAnchorMargin

                        anchors
                        {
                            top:    parent.top
                            bottom: mainBar.top
                        }
                    }

                    TabBar
                    {
                        id:     mainBar
                        width:  250
                        x:      450

                        anchors
                        {
                            bottom:    plotImgRect.top
                            //center?:       plotImgRect.horizontalCenter
                            margins:			Theme.generalAnchorMargin
                        }
                        TabButton {
                            id:   mainGraph
                            text: qsTr("Main Graph")
                            onClicked:
                            {
                            }
                        }
                        TabButton {
                            id:     mainOther
                            text: qsTr("Other")
                            onClicked:
                            {
                            }
                        }
                    }

                    TabBar
                    {
                        id:     sideImageBar
                        visible: false
                        anchors
                        {
                            left:    colorBoxIdY.left
                            right:   colorBoxIdY.right
                            bottom:  colorBoxIdY.top
                            bottomMargin: Theme.generalAnchorMargin
                        }
                        TabButton {
                            id:   sideImageBarColor
                            text: qsTr("Colors")
                            onClicked:
                            {
                            }
                        }
                        TabButton {
                            id:     sideImageBarPL
                            text: qsTr("Points & Lines")
                            onClicked: {
                            }
                        }
                    }

                    TabBar
                    {
                        id:     sideOtherBar
                        visible: false
                        width:  250

                        anchors
                        {
                            left:    colorBoxIdY.left
                            right:   colorBoxIdY.right
                            bottom:  colorBoxIdY.top
                            bottomMargin: Theme.generalAnchorMargin
                        }

                        TabButton {
                            text: qsTr("Fonts")
                            id:     sideOtherBarFonts
                            onClicked: {
                            }
                        }
                        TabButton {
                            id:     sideOtherBarAxis
                            text: qsTr("Axis")
                            onClicked: {
                            }
                        }
                    }

                    Rectangle
                    {
                        id:                      yAxisClickBoxTitle
                        color:                   Theme.red
                        z:                       2
                        width:                   49
                        height:                  385
                        x:                       210


                        anchors
                        {
                            top:            plotImgRect.top
                        }

                        MouseArea {
                          anchors.fill: parent
                          onClicked: {
                          }
                        }
                    }

                    Rectangle
                    {
                        id:                      yAxisClickBoxTicks
                        color:                   Theme.blue
                        z:                       2
                        width:                   59
                        height:                  385
                        x:                       260

                        anchors
                        {
                            top:            plotImgRect.top
                        }

                        MouseArea {
                          anchors.fill: parent
                          onClicked: {
                          }
                        }

                    }

                    Rectangle
                    {
                        id:                      xAxisClickBoxTitle
                        color:                   Theme.green
                        z:                       2
                        width:                   620
                        height:                  49
                        y:                       500


                        anchors
                        {
                            right:            plotImgRect.right
                        }

                        MouseArea {
                          anchors.fill: parent
                          onClicked: {
                          }
                        }

                    }

                    Rectangle
                    {
                        id:                      xAxisClickBoxTicks
                        color:                   Theme.gray
                        z:                       2
                        width:                   620
                        height:                  55
                        y:                       430


                        anchors
                        {
                            right:            plotImgRect.right
                        }

                        MouseArea {
                          anchors.fill: parent
                          onClicked: {
                          }
                        }

                    }

                    Rectangle
                    {
                        id:                      clickablePlotImgRect
                        color:                   Theme.black
                        z:                       2
                        width:                   600
                        height:                  350
                        y:                       80
                        x:                       325

                        MouseArea {
                          anchors.fill: parent
                          onClicked: {
                          }
                        }

                    }

                    Rectangle
                    {
                        id:				colorBoxIdY
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              1
                        visible:        false

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			colorBoxIdX.bottom
                        }

                        Text
                        {
                            id: colorWord
                            text: "color"

                            anchors
                            {
                                top: colorBoxIdY.verticalCenter
                                left: colorBoxIdY.horizontalCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        id:				pointsLinesBoxIdY

                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              1
                        visible:        false

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			colorBoxIdX.bottom
                        }

                        Text
                        {
                            id: pLword
                            text: "PL"

                            anchors
                            {
                                top: pointsLinesBoxIdY.verticalCenter
                                left: pointsLinesBoxIdY.horizontalCenter
                            }

                        }
                    }

                    Rectangle
                    {
                        id:				fontBoxIdY

                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              1
                        visible:        false

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			colorBoxIdX.bottom
                        }

                        Text
                        {
                            id: fontWordId
                            text: "Font"

                            anchors
                            {
                                top: fontBoxIdY.verticalCenter
                                left: fontBoxIdY.horizontalCenter
                            }

                        }

                    }

                    Rectangle
                    {
                        id:				axisBoxIdY

                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              1
                        visible:        false

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			plotImgRect.bottom
                        }

                        TableView
                        {
                            id:						yAxis
                            clip:					true
                            model:					plotEditorModel.yAxis
                            delegate:				axisElement
                            anchors.fill:			parent
                            columnWidthProvider:	function(column) { return yAxis.width / 2 }
                        }
                    }

                    Rectangle
                    {
                        id:				colorBoxIdX

                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              1
                        visible:        false

                        anchors
                        {
                            top:		plotImgRect.bottom
                            topMargin:	Theme.generalAnchorMargin
                            left:		plotImgRect.left
                            right:		plotImgRect.right
                        }

                        Text
                        {
                            id: colorWordX
                            text: "color"

                            anchors
                            {
                                left: colorBoxIdX.horizontalCenter
                                top: colorBoxIdX.verticalCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        id:				pointsLinesBoxIdX
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              1
                        visible:        false

                        anchors
                        {
                            top:		plotImgRect.bottom
                            topMargin:	Theme.generalAnchorMargin
                            left:		plotImgRect.left
                            right:		plotImgRect.right
                        }

                        Text
                        {
                            id: pLwordX
                            text: "PL"

                            anchors
                            {
                                left: pointsLinesBoxIdX.horizontalCenter
                                top: pointsLinesBoxIdX.verticalCenter
                            }

                        }
                    }

                    Rectangle
                    {
                        id:				fontBoxIdX
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              1
                        visible:        false

                        anchors
                        {
                            top:		plotImgRect.bottom
                            topMargin:	Theme.generalAnchorMargin
                            left:		plotImgRect.left
                            right:		plotImgRect.right
                        }

                        Text
                        {
                            id: fontWordIdX
                            text: "Font"

                            anchors
                            {
                                left: fontBoxIdX.horizontalCenter
                                top: fontBoxIdX.verticalCenter
                            }

                        }

                    }

                    Rectangle
                    {
                        id:				axisBoxIdX
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              1
                        visible:        false

                        anchors
                        {
                            top:		plotImgRect.bottom
                            topMargin:	Theme.generalAnchorMargin
                            left:		plotImgRect.left
                            right:		plotImgRect.right
                        }

                        TableView
                        {
                            id:				xAxis
                            clip:			true
                            model:			plotEditorModel.xAxis
                            delegate:		axisElement
                            anchors.fill:	parent
                        }
                    }


                    Rectangle
                    {
                        id:				yAxisId
                        visible:        false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              -2

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			plotImgRect.bottom
                        }

                        TableView
                        {
                            id:						yAxisOther
                            clip:					true
                            model:					plotEditorModel.yAxis
                            delegate:				axisElement
                            anchors.fill:			parent
                            columnWidthProvider:	function(column) { return yAxis.width / 2 }
                        }
                    }

                    Rectangle
                    {
                        id:					yAxisTitle
                        z:					-1
                        color:				Theme.white
                        border.color:		Theme.black
                        border.width:		1
                        height:				Theme.font.pixelSize * 2
                        visible:            false

                        anchors
                        {
                            left:		yAxisId.left
                            top:		xAxisId.top
                            right:		yAxisId.right
                        }

                        TextInput
                        {
                            text:					plotEditorModel.yAxis.title
                            padding:				4 * preferencesModel.uiScale
                            font:					Theme.font
                            anchors.centerIn:		parent
                            horizontalAlignment:	Text.AlignHCenter
                            verticalAlignment:		Text.AlignVCenter
                            onEditingFinished:		plotEditorModel.yAxis.title = text
                        }
                    }

                    Rectangle
                    {
                        id:					xAxisTitle
                        z:					-1
                        color:				Theme.white
                        border.color:		Theme.black
                        border.width:		1
                        height:				Theme.font.pixelSize * 2
                        visible:            false

                        anchors
                        {
                            left:		yAxisTitle.left
                            right:		yAxisTitle.right
                            bottom:		xAxisId.bottom
                        }

                        TextInput
                        {
                            text:					plotEditorModel.xAxis.title
                            padding:				4 * preferencesModel.uiScale
                            font:					Theme.font
                            anchors.centerIn:		parent
                            horizontalAlignment:	Text.AlignHCenter
                            verticalAlignment:		Text.AlignVCenter
                            onEditingFinished:		plotEditorModel.xAxis.title = text
                        }
                    }

                    Rectangle
                    {
                        id:						plotImgRect
                        color:					"white"
                        border.color:			"black"
                        border.width:			preferencesModel.uiScale
                        height:					plotImg.height	+ (2 * Theme.generalAnchorMargin)
                        anchors
                        {
                            top:				mainBar.bottom
                            left:				yAxisId.right
                            right:				parent.right
                            margins:			Theme.generalAnchorMargin
                        }

                        Image
                        {
                            id:					plotImg
                            cache:				false
                            source:				plotEditorModel.imgFile
                            sourceSize.width:	plotEditorModel.width
                            sourceSize.height:	plotEditorModel.height
                            width:				Math.max((parent.width - ( 2 * plotImgRect.border.width)), plotEditorModel.width)
                            height:				(width * (plotEditorModel.height / plotEditorModel.width) + ( 2 * plotImgRect.border.width))
                            x:					plotImgRect.border.width
                            y:					plotImgRect.border.width
                            mipmap:				true
                        }
                    }

                    Rectangle
                    {
                        id:				xAxisId
                        z:              -2
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5

                        anchors
                        {
                            top:		plotImgRect.bottom
                            topMargin:	Theme.generalAnchorMargin
                            left:		plotImgRect.left
                            right:		plotImgRect.right
                        }


                    }


                    Component
                    {
                        id:		axisElement

                        Item
                        {
                            implicitWidth:	Math.max(textDelegate.implicitWidth, editor.implicitWidth) + ( 10 * preferencesModel.uiScale)
                            implicitHeight:	Theme.font.pixelSize * 2

                            Text
                            {
                                id:						textDelegate
                                text:					display
                                padding:				4 * preferencesModel.uiScale
                                font:					Theme.font
                                visible:				!editor.visible
                                horizontalAlignment:	Text.AlignHCenter
                                verticalAlignment:		Text.AlignVCenter
                                anchors.centerIn:		parent

                                MouseArea
                                {
                                    anchors.fill:	parent
                                    onClicked:
                                    {
                                        editor.visible = true;
                                        editor.forceActiveFocus();
                                    }
                                }
                            }

                            TextInput
                            {
                                id:						editor
                                z:						2
                                text:					display
                                padding:				4 * preferencesModel.uiScale
                                font:					Theme.font
                                anchors.centerIn:		parent
                                horizontalAlignment:	Text.AlignHCenter
                                verticalAlignment:		Text.AlignVCenter
                                visible:				false

                                onEditingFinished:
                                {
                                    model.display	= editor.text
                                    focus			= false;
                                }

                                onActiveFocusChanged:	if(!activeFocus)
                                                        {
                                                            visible = false;
                                                            text	= Qt.binding(function(){ return display; });
                                                        }
                                Rectangle
                                {
                                    z:					-1
                                    color:				Theme.white
                                    border.color:		Theme.black
                                    border.width:		1
                                    anchors.fill:		parent
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}
