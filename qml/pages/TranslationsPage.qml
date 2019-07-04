import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/util.js" as Util
import "../components"

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
                onClicked: Qt.openUrlExternally("https://www.transifex.com/dylanvanassche/sailbook/")
            }
        }

        Column {
            id: transColumn
            width: parent.width
            spacing: Theme.paddingLarge
            
            PageHeader { title: qsTr("Translators") }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Pljmn"
                iconSource: "qrc:///images/icon-belgium.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Dashinfantry"
                iconSource: "qrc:///images/icon-china.png"
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
                text: "Adriano C"
                iconSource: "qrc:///images/icon-brasil.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Carmen Fernández B"
                iconSource: "qrc:///images/icon-spain.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Sebastian Nilsson"
                iconSource: "qrc:///images/icon-sweden.png"
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Szabó G"
                iconSource: "qrc:///images/icon-hungary.png"
            }
         }
    }
}           
