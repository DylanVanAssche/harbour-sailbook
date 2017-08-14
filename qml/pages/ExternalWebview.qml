import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import "./js/util.js" as Util
import "./js/media.js" as Media

Item {
    anchors { fill: parent }

    property string externalUrl
    property bool _isYoutube

    function setUrl(url) { // Make setting url possible from outside our component
        webview.url = url;
    }

    function getUrl() { // Make reading url possible from outside our component
        return webview.url;
    }

    function getProgress() { // Make progress accessible from outside our component
        return webview.progress;
    }

    SilicaWebView {
        id: webview
        anchors { fill: parent }
        experimental.preferences.javascriptEnabled: true
        experimental.userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko)"
        experimental.userStyleSheet: Qt.resolvedUrl("../resources/css/external.css")
        experimental.userScripts: Qt.resolvedUrl("../resources/js/external.js")
        clip: true
        opacity: loading? 0.0: 1.0
        url: externalUrl
        onNavigationRequested: {
            Media.detectDownload(request)
            Media.detectYoutubeDLVideo(request)
        }

        Behavior on opacity { FadeAnimation {} }
    }

    // External link loadscreen
    LoadscreenWebview { iconSource: "../resources/images/icon-external.png" }

    // Youtube loadscreen
    LoadscreenWebview { iconSource: "../resources/images/icon-youtube.png"; iconText: "Youtube"; opacity: _isYoutube? 1.0: 0.0 }
}
