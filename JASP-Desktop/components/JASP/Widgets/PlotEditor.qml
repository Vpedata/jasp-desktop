﻿import QtQuick			2.13
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
                            bottom: bar.top
                        }
                    }

                    TabBar {
                        id: bar
                        width: 500
                        z:      1

                        anchors
                        {
                            left:    yAxisId.right
                            margins:			Theme.generalAnchorMargin
                        }

                        TabButton {
                            text: qsTr("Colors")
                            onClicked: {
                            colorBoxIdY.isClicked = true
                            colorBoxIdY.isClicked = true
                            pointsLinesBoxIdY.isClicked = false
                            pointsLinesBoxIdX.isClicked = false
                            fontBoxIdY.isClicked = false
                            fontBoxIdX.isClicked = false
                            axisBoxIdY.isClicked = false
                            axisBoxIdX.isClicked = false
                            }
                        }
                        TabButton {
                            text: qsTr("Points/nLines")
                            onClicked: {
                            colorBoxIdY.isClicked = false
                            colorBoxIdY.isClicked = false
                            pointsLinesBoxIdY.isClicked = true
                            pointsLinesBoxIdX.isClicked = true
                            fontBoxIdY.isClicked = false
                            fontBoxIdX.isClicked = false
                            axisBoxIdY.isClicked = false
                            axisBoxIdX.isClicked = false
                            }
                        }
                        TabButton {
                            text: qsTr("Fonts")
                            onClicked: {
                            colorBoxIdY.isClicked = false
                            colorBoxIdY.isClicked = false
                            pointsLinesBoxIdY.isClicked = false
                            pointsLinesBoxIdX.isClicked = false
                            fontBoxIdY.isClicked = true
                            fontBoxIdX.isClicked = true
                            axisBoxIdY.isClicked = false
                            axisBoxIdX.isClicked = false
                            }
                        }
                        TabButton {
                            text: qsTr("Axis")
                            onClicked: {
                            colorBoxIdY.isClicked = false
                            colorBoxIdY.isClicked = false
                            pointsLinesBoxIdY.isClicked = false
                            pointsLinesBoxIdX.isClicked = false
                            fontBoxIdY.isClicked = false
                            fontBoxIdX.isClicked = false
                            axisBoxIdY.isClicked = true
                            axisBoxIdX.isClicked = true
                            }
                        }
                    }

                    Rectangle
                    {
                        id:				colorBoxIdY
                        property bool isClicked: true
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              isClicked ? 1 : -1

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			plotImgRect.bottom
                        }

                        Text
                        {
                            id: colorWord
                            text: "color"

                            anchors
                            {
                                top: plotImgRect.verticalCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        id:				pointsLinesBoxIdY
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              isClicked ? 1 : -1

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			plotImgRect.bottom
                        }

                        Text
                        {
                            id: pLword
                            text: "PL"

                            anchors
                            {
                                top: plotImgRect.verticalCenter
                            }

                        }
                    }

                    Rectangle
                    {
                        id:				fontBoxIdY
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              isClicked ? 1 : -1

                        anchors
                        {
                            left:			parent.left
                            leftMargin:		Theme.generalAnchorMargin
                            top:            plotImgRect.top
                            bottom:			plotImgRect.bottom
                        }

                        Text
                        {
                            id: fontWordId
                            text: "Font"

                            anchors
                            {
                                top: plotImgRect.verticalCenter
                            }

                        }

                    }

                    Rectangle
                    {
                        id:     test
                        property bool isClicked: true
                        color: isClicked ? "red" : "transparent"
                        height: 100
                        width:  100
                        z:      2

                        anchors
                        {
                            top: plotImgRect.verticalCenter
                        }

                        MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    test.isClicked = !test.isClicked
                                                }
                                            }


                    }

                    Rectangle
                    {
                        id:				axisBoxIdY
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        width:			parent.width * 0.2
                        z:              isClicked ? 1 : -1

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
                        property bool isClicked: true
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              isClicked ? 1 : -1

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
                                top: plotImgRect.horizontalCenter
                            }
                        }
                    }

                    Rectangle
                    {
                        id:				pointsLinesBoxIdX
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              isClicked ? 1 : -1

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
                                top: plotImgRect.horizontalCenter
                            }

                        }
                    }

                    Rectangle
                    {
                        id:				fontBoxIdX
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              isClicked ? 1 : -1

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
                                top: plotImgRect.horizontalCenter
                            }

                        }

                    }

                    Rectangle
                    {
                        id:				axisBoxIdX
                        property bool isClicked: false
                        color:			Theme.white
                        border.color:	Theme.black
                        border.width:	preferencesModel.uiScale
                        height:			Theme.font.pixelSize * 4.5
                        z:              isClicked ? 1 : -1

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
                            top:				bar.bottom
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
