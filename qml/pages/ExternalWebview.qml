import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
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
        enabled: !loading
        experimental.preferences.javascriptEnabled: true
        experimental.userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko)"
        experimental.userStyleSheets: [Qt.resolvedUrl("../resources/css/external.css")]
        experimental.userScripts: Qt.resolvedUrl("../resources/js/external.js")
        experimental.customLayoutWidth: parent.width / devicePixelRatio
        experimental.overview: true
        clip: true
        opacity: loading? 0.0: 1.0
        url: externalUrl
        onNavigationRequested: {
            Media.detectDownload(request)
            Media.detectYoutubeDLVideo(request)
        }

        // Rounding floating numbers in JS: https://stackoverflow.com/questions/9453421/how-to-round-float-numbers-in-javascript
        // Default 1.5x zoom
        property real devicePixelRatio: Math.round(1.5*Theme.pixelRatio * 10) / 10.0

        Behavior on opacity { FadeAnimation {} }
    }

    // External link loadscreen
    LoadscreenWebview {}
}
