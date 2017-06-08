import QtQuick 2.0
import Sailfish.Silica 1.0
import "./js/util.js" as Util

Rectangle {
    anchors { fill: parent }
    color: Util.getBackgroundColor(settings.theme)

    property string iconSource: "../resources/images/icon-sailbook.svg"
    property string iconText: qsTr("Connecting...")

    Behavior on opacity { FadeAnimation {} }

    Timer { // When no connected, check every second if ConnMan is back online
        interval: 1000
        running: !app.connected
        repeat: true
        onTriggered: python.call("app.connection.status")
    }

    Image {
        anchors { fill: parent }
        source: "../resources/images/image-loadscreen.jpg"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.25
        asynchronous: true
    }

    Image {
        id: icon
        anchors { centerIn: parent }
        source: iconSource
        width: Theme.iconSizeExtraLarge
        height: width
        asynchronous: true
    }

    Label {
        anchors { top: icon.bottom; topMargin: Theme.paddingLarge; horizontalCenter: parent.horizontalCenter }
        font.pixelSize: Theme.fontSizeExtraLarge
        text: iconText
    }
}
