import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/util.js" as Util

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: transColumn.height

        VerticalScrollDecorator {}

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Translation Platform")
                onClicked: Qt.openUrlExternally("https://www.transifex.com/sailbook/sailbook")
            }
        }

        Column {
            id: transColumn
            width: parent.width
            spacing: Theme.paddingLarge
            
            PageHeader { title: qsTr("Translators") }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Pascal de Klein"
                iconSource: "qrc:///images/icon-belgium.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Mikko Kokkonen"
                iconSource: "qrc:///images/icon-finland.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Jimmy Huguet"
                iconSource: "qrc:///images/icon-french.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Alain Molteni"
                iconSource: "qrc:///images/icon-germany.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Pawel Radomychelski"
                iconSource: "qrc:///images/icon-germany.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Matthias Weiß"
                iconSource: "qrc:///images/icon-germany.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Francesco Vaccaro"
                iconSource: "qrc:///images/icon-italy.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "A Atlochowski"
                iconSource: "qrc:///images/icon-polish.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Carlos Gonzalez"
                iconSource: "qrc:///images/icon-spain.png"
            }
         }
    }
}           
