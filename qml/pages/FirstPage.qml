import QtQuick 2.2
import Sailfish.Silica 1.0
import QtWebKit 3.0
import "./js/util.js" as Util

Page {
    Connections {
        target: app
        onConnectedChanged: {
            switch(app.connected) {
            case 0:
                console.log("[DEBUG] Connection lost, destroying webview...")
                break;

            case 1:
                console.log("[DEBUG] Connection back but different network, recreating webview...")
                break;

            case 2:
                console.log("[DEBUG] Connection back, creating webview...")
                break;
            }
        }
    }

    FBWebview {
        id: fbWebview
        anchors { left: parent.left; right: parent.right; top: parent.top; bottom: navigation.top }
        opacity: app.connected? 1.0: 0.0
        visible: opacity > 0
        Behavior on opacity { FadeAnimation {} }
    }

    Rectangle {
        id: navigation
        height: Theme.itemSizeMedium
        color: Util.getBackgroundColor(settings.theme)
        opacity: app.connected? 1.0: 0.0
        visible: opacity > 0
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Behavior on opacity { FadeAnimation {} }

        Row {
            anchors { fill: parent }
            NavigationButton { onClicked: fbWebview.goBack(); iconSource: "../resources/images/icon-back.svg"; visible: settings.placeBack==1 && fbWebview.canGoBack }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/home.php?sk=" + Util.getFeedPriority(settings.priorityFeed)); notifyIndicator: app.notifications[0]; iconSource: "../resources/images/icon-newsfeed.svg"; visible: settings.showFeed }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/friends"); notifyIndicator: app.notifications[1]; iconSource: "../resources/images/icon-requests.svg"; visible: settings.showFriends }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/messages"); notifyIndicator: app.notifications[2]; iconSource: "../resources/images/icon-messages.svg"; visible: settings.showMessages }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/notifications"); notifyIndicator: app.notifications[3]; iconSource: "../resources/images/icon-notifications.svg"; visible: settings.showNotifications }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/search"); notifyIndicator: app.notifications[4]; iconSource: "../resources/images/icon-search.svg"; visible: settings.showSearch }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/events/upcoming"); notifyIndicator: app.notifications[5]; iconSource: "../resources/images/icon-events.svg"; visible: settings.showEvents }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/groups"); notifyIndicator: app.notifications[6]; iconSource: "../resources/images/icon-groups.svg"; visible: settings.showGroups }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/pages/?category=liked"); notifyIndicator: app.notifications[7]; iconSource: "../resources/images/icon-pages.svg"; visible: settings.showLikedPages }
            NavigationButton { onClicked: fbWebview.setUrl("https://m.facebook.com/settings"); notifyIndicator: app.notifications[8]; iconSource: "../resources/images/icon-settings.svg"; visible: settings.showSettings }
        }
    }

    SplashScreen { opacity: app.connected? 0.0: 1.0 }
}

