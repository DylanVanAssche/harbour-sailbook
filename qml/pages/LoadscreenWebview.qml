import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "./js/util.js" as Util

Rectangle {
    anchors { fill: parent }
    color: Util.getBackgroundColor(settings.theme)
    opacity: webview.loading? 1.0: 0.0
    
    Behavior on opacity { FadeAnimation {} }
    
    Image {
        anchors { fill: parent }
        source: "../resources/images/icon-cover.svg"
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
        asynchronous: true
    }

    ProgressBar {
         anchors {
             left: parent.left
             right: parent.right
             bottom: parent.bottom
         }

         visible: webview.visible && webview.loading
         minimumValue: 0
         maximumValue: 100
         indeterminate: webview.loadProgress === 0
         value: webview.loadProgress
         }
 }
