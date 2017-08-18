import QtQuick 2.2
import Sailfish.Silica 1.0
import "./js/util.js" as Util

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

            GlassButton { iconSource: "../resources/images/icon-belgium.png"; iconText: "Pascal de Klein" }
            GlassButton { iconSource: "../resources/images/icon-finland.png"; iconText: "Mikko Kokkonen" }
            GlassButton { iconSource: "../resources/images/icon-french.png"; iconText: "Jimmy Huguet" }
            GlassButton { iconSource: "../resources/images/icon-germany.png"; iconText: "Pawel Radomychelski" }
            GlassButton { iconSource: "../resources/images/icon-germany.png"; iconText: "Alain Molteni" }
            GlassButton { iconSource: "../resources/images/icon-germany.png"; iconText: "Dark One" }
            GlassButton { iconSource: "../resources/images/icon-italy.png"; iconText: "Francesco Vaccaro" }
            GlassButton { iconSource: "../resources/images/icon-polish.png"; iconText: "A Atlochowski" }
            GlassButton { iconSource: "../resources/images/icon-spain.png"; iconText: "Carlos Gonzalez" }
         }
    }
}           
