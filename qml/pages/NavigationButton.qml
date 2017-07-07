import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "./js/util.js" as Util

BackgroundItem {
    property string iconSource
    property string notifyIndicator: "0"

    width: parent.width/Util.getMenubarItems()
    height: parent.height
    highlightedColor: Util.getHighlightBackgroundColor(settings.theme)

    Rectangle {
        anchors { fill: parent }
        color: Util.getHighlightBackgroundColor(settings.theme)
        opacity: indicator.visible? 1.0: 0.0

        Behavior on opacity { FadeAnimation {} }
    }
    
    Image {
        width: Theme.iconSizeSmallPlus
        height: width
        anchors { centerIn: parent }
        source: iconSource
        asynchronous: true
    }

    Label {
        id: indicator
        anchors { right: parent.right; bottom: parent.bottom; }
        visible: text != "0"? true: false
        font.bold: true
        text: notifyIndicator
    }
}
