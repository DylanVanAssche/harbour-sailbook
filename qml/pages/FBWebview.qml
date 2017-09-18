import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import Nemo.DBus 2.0
import Harbour.Sailbook.SFOS 1.0
import "./js/util.js" as Util
import "./js/messages.js" as Messages
import "./js/media.js" as Media

Item {
    property bool _wasLoading
    property bool canGoBack: webview.canGoBack

    function setUrl(url) { // Make url accessible from outside our component
        python.call("app.connection.status", [], function(result) { // Check our connection status before we do something
            console.log(result)
            if(result) {
                webview.url = url;
            }
        })
    }

    function reload() { // webview.reload() isn't broken out outside our component
        python.call("app.connection.status", [], function(result) { // Check our connection status before we do something
            if(result) {
                webview.reload()
            }
        })
    }

    function goBack() { // webview.goBack() isn't broken out outside our component
        python.call("app.connection.status", [], function(result) { // Check our connection status before we do something
            if(result) {
                webview.goBack();
            }
        })
    }

    function logout() {
        webview.experimental.deleteAllCookies();
        webview.reload()
    }

    DBusAdaptor {
             id: dbus
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
        experimental.preferences.javascriptEnabled: true
        experimental.preferences.navigatorQtObjectEnabled: true
        experimental.preferences.developerExtrasEnabled: true

        property variant devicePixelRatio: {//1.5
            if (Screen.width <= 540) return 1.5;
            else if (Screen.width > 540 && Screen.width <= 768) return 2.0;
            else if (Screen.width > 768) return 3.0;
        }
        experimental.customLayoutWidth: parent.width / devicePixelRatio
        experimental.overview: true

        experimental.userAgent: "Mozilla/5.0 (PlayStation 4 4.71) AppleWebKit/601.2 (KHTML, like Gecko)"
        experimental.userStyleSheets: Qt.resolvedUrl(Util.getThemeFileName(settings.enableNightmode))
        experimental.userScripts: Qt.resolvedUrl("../resources/js/sailbook.js")
        experimental.onMessageReceived: Messages.parse(message.data)
        experimental.filePicker: ImagePicker { filePicker: model } // Send filepicker model to our ImagePicker
        onNavigationRequested: Media.detectImage(request) //When link is an image, cancel request and show our image viewer
        clip: true // Enforce painting inside our defined screen
        opacity: loading? 0.0: 1.0
        url: "https://m.facebook.com/home.php?sk=" + Util.getFeedPriority(settings.priorityFeed)
        onLoadingChanged: loading? undefined: Messages.publishNotifications();

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
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("Settings")
                onClicked: {
                    var oldUrl = webview.url
                    var settingsDialog = pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                    settingsDialog.accepted.connect(function(){ // Refresh Javascript specific settings by reloading
                        if(oldUrl == webview.url) { // Don't do this when url has been changed
                            webview.reload()
                        }
                    })
                }
            }

            MenuItem {
                color: Util.getPrimaryColor(settings.theme)
                text: qsTr("Back")
                visible: webview.canGoBack && settings.placeBack==0 // Hide when we haven't navigated yet
                onClicked: webview.goBack()
            }
        }
    }

    // Loadscreen
    LoadscreenWebview { id: loadScreen }
}
