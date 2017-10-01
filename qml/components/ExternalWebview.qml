import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import org.nemomobile.dbus 2.0
import "../js/util.js" as Util
import "../js/media.js" as Media

Item {
    anchors { fill: parent }

    property string externalUrl
    property bool connected

    function setUrl(url) { // Make setting url possible from outside our component
        webview.url = url;
    }

    function getUrl() { // Make reading url possible from outside our component
        return webview.url;
    }

    function getProgress() { // Make progress accessible from outside our component
        return webview.progress;
    }

    DBusInterface {
        id: networkDBusListener
        bus: DBus.SystemBus
        service: "net.connman"
        path: "/"
        iface: "net.connman.Manager"
        signalsEnabled: true
        Component.onCompleted: getStatus() // Init

        // Methods
        function getStatus() {
            typedCall("GetProperties", [], function(properties) {
                if(properties["State"] == "online") {
                    console.debug("Network connected, loading...");
                    connected = true;
                }
                else {
                    console.debug("Offline!");
                    connected = false;
                }
            },
            function(trace) {
                console.error("Network state couldn't be retrieved: " + trace);
            })
        }

        // Signals
        function propertyChanged(name, value) {
            if(name == "State") {
                if(value == "online") {
                    console.debug("Network connected, reloading...");
                    webview.reload();
                    connected = true;
                }
                else {
                    console.debug("Offline!");
                    connected = false;
                }
            }
        }
    }

    SilicaWebView {
        id: webview
        anchors { fill: parent }
        enabled: !loading
        experimental.preferences.javascriptEnabled: true
        experimental.transparentBackground: true
        experimental.userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/14A403 Safari/602.1"
        experimental.userStyleSheets: [Qt.resolvedUrl("qrc:///css/external.css")]
        experimental.userScripts: Qt.resolvedUrl("qrc:///js/external.js")
        experimental.customLayoutWidth: parent.width / devicePixelRatio
        experimental.overview: true
        clip: true
        opacity: loading || !connected? 0.0: 1.0
        url: externalUrl

        // Rounding floating numbers in JS: https://stackoverflow.com/questions/9453421/how-to-round-float-numbers-in-javascript
        // Default 1.5x zoom
        property real devicePixelRatio: Math.round(1.5*Theme.pixelRatio * 10) / 10.0

        Behavior on opacity { FadeAnimation {} }
    }

    // External link loadscreen
    PlaceholderWebview {
        id: placeholder
        opacity: connected && !webview.loading? 0.0: 1.0
        note: connected? "": qsTr("No network")
    }
}
