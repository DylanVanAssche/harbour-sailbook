import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import org.nemomobile.dbus 2.0
import Harbour.Sailbook.SFOS 1.0
import "../js/util.js" as Util
import "../js/messages.js" as Messages
import "../js/media.js" as Media

Item {
    property bool _wasLoading
    property bool canGoBack: webview.canGoBack
    property bool connected: true

    function setUrl(url) { // Make url accessible from outside our component
        webview.url = url;
    }

    function reload() { // webview.reload() isn't broken out outside our component
        webview.reload()
    }

    function goBack() { // webview.goBack() isn't broken out outside our component
        webview.goBack();
    }

    function logout() {
        webview.experimental.deleteAllCookies();
        webview.reload()
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

    DBusAdaptor {
        id: sailbookDBusInterface
        service: sfos.appName.replace("-", ".")
        iface: sfos.appName.replace("-", ".")
        path: "/"
        xml: '  <interface name="' + sfos.appName.replace("-", ".") + '">\n' +
             '    <method name="activate" />\n' +
             '  </interface>\n'

        function activate(category) {
            if(category == "sailbook-request") {
                webview.url = "https://m.facebook.com/friends";
                app.activate();
                console.debug("Notification activation: " + category);
            }
            else if(category == "sailbook-message") {
                webview.url = "https://m.facebook.com/messages";
                app.activate();
                console.debug("Notification activation: " + category);
            }
            else if(category == "sailbook-notification") {
                webview.url = "https://m.facebook.com/notifications";
                app.activate();
                console.debug("Notification activation: " + category);
            }
            else {
                console.warn("Notification activation doesn't match with our categories: " + category);
            }
        }
    }

    SFOS {
        id: sfos
    }

    SilicaWebView {
        id: webview
        anchors { fill: parent }
        enabled: !loading && connected
        experimental.preferences.javascriptEnabled: true
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.preferences.developerExtrasEnabled: true
        experimental.transparentBackground: true
        experimental.customLayoutWidth: parent.width / devicePixelRatio
        experimental.overview: true
        experimental.userAgent: "Mozilla/5.0 (PlayStation 4 4.71) AppleWebKit/601.2 (KHTML, like Gecko)"
        experimental.userStyleSheets: Qt.resolvedUrl(Util.getThemeFileName(settings.theme))
        experimental.userScripts: Qt.resolvedUrl("qrc:///js/sailbook.js")
        experimental.onMessageReceived: Messages.parse(message.data)
        experimental.filePicker: ImagePicker { filePicker: model } // Send filepicker model to our ImagePicker
        onNavigationRequested: {
            if(Media.detectImage(request)) { // When link is an image, cancel request and show our image viewer
                request.action = WebView.IgnoreRequest;
            }
        }
        clip: true // Enforce painting inside our defined screen
        opacity: loading || !connected? 0.0: 1.0
        url: "https://m.facebook.com/home.php?sk=" + Util.getFeedPriority(settings.priorityFeed)
        onLoadingChanged: loading? undefined: Messages.publishNotifications();

        // Rounding floating numbers in JS: https://stackoverflow.com/questions/9453421/how-to-round-float-numbers-in-javascript
        // Default 1.5x zoom
        property real devicePixelRatio: Math.round(1.5*Theme.pixelRatio*10)/10.0

        Behavior on opacity { FadeAnimation {} }

        PullDownMenu {
            backgroundColor: Util.getBackgroundColor(settings.theme)
            highlightColor: Util.getHighlightColor(settings.theme)
            enabled: !webview.loading

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("Facebook logout")
                visible: settings.showLogout
                onClicked: logout()
            }

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/AboutPage.qml"))
            }

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/SettingsPage.qml"))
            }

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("Back")
                visible: webview.canGoBack && settings.placeBack==0 // Hide when we haven't navigated yet
                onClicked: webview.goBack()
            }
        }
    }

    // Placeholder
    PlaceholderWebview {
        id: placeholder
        opacity: connected && !webview.loading? 0.0: 1.0
        note: !connected? qsTr("No network"): ""
    }
}
