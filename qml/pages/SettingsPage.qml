import QtQuick 2.2
import Sailfish.Silica 1.0
import "../js/util.js" as Util

Dialog {

    onAccepted: {
        settings.notifyRequests = notifyRequests.checked
        settings.notifyMessages = notifyMessages.checked
        settings.notifyNotifications = notifyNotifications.checked
        settings.priorityFeed = priorityFeed.currentIndex
        settings.showFeed = showFeed.checked
        settings.showFriends = showFriends.checked
        settings.showMessages = showMessages.checked
        settings.showNotifications = showNotifications.checked
        settings.showSearch = showSearch.checked
        settings.showEvents = showEvents.checked
        settings.showGroups = showGroups.checked
        settings.showLikedPages = showLikedPages.checked
        settings.showSettings = showSettings.checked
        settings.showLogout = showLogout.checked
        settings.showRefresh = showRefresh.checked
        settings.placeBack = placeBack.currentIndex
        settings.theme = theme.currentIndex
        settings.externalLink = externalLink.currentIndex
        settings.enableVideoPlayer = enableVideoPlayer.checked
        settings.videoQuality = videoQuality.currentIndex
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: settingsColumn.height

        VerticalScrollDecorator {}

        Column {
            id: settingsColumn
            width: parent.width
            spacing: Theme.paddingLarge

            DialogHeader { title: qsTr("Settings") }

            SectionHeader{ text: qsTr("Appearance") }

            ComboBox {
                id: theme
                label: qsTr("Theme")
                currentIndex: settings.theme
                menu: ContextMenu {
                    MenuItem { text: qsTr("Ambience") }
                    MenuItem { text: qsTr("Facebook") }
                    MenuItem { text: qsTr("Facebook nightmode") }
                }
            }

            ComboBox {
                id: placeBack
                label: qsTr("Back button in")
                currentIndex: settings.placeBack
                menu: ContextMenu {
                    MenuItem { text: qsTr("Pulldown menu") }
                    MenuItem { text: qsTr("Menu bar") }
                }
            }

            ComboBox {
                id: priorityFeed
                label: qsTr("Feed priority")
                currentIndex: settings.priorityFeed
                menu: ContextMenu {
                    MenuItem { text: qsTr("Most recent") }
                    MenuItem { text: qsTr("Top stories") }
                }
            }

            TextSwitch {
                id: showFeed
                text: qsTr("Show Facebook feed button")
                checked: settings.showFeed
            }

            TextSwitch {
                id: showFriends
                text: qsTr("Show Facebook friends button")
                checked: settings.showFriends
                description: qsTr("When disabled, the notifications for friend requests aren't shown as well.")
            }

            TextSwitch {
                id: showMessages
                text: qsTr("Show Facebook messages button")
                checked: settings.showMessages
                description: qsTr("When disabled, the notifications for new messages aren't shown as well.")
            }

            TextSwitch {
                id: showNotifications
                text: qsTr("Show Facebook notifications button")
                checked: settings.showNotifications
                description: qsTr("When disabled, the notifications for events, ... aren't shown as well.")
            }

            TextSwitch {
                id: showSearch
                text: qsTr("Show Facebook search button")
                checked: settings.showSearch
            }

            TextSwitch {
                id: showEvents
                text: qsTr("Show Facebook events button")
                checked: settings.showEvents
            }

            TextSwitch {
                id: showGroups
                text: qsTr("Show Facebook groups button")
                checked: settings.showGroups
            }

            TextSwitch {
                id: showLikedPages
                text: qsTr("Show Facebook liked pages button")
                checked: settings.showLikedPages
            }

            TextSwitch {
                id: showSettings
                text: qsTr("Show Facebook settings button")
                checked: settings.showSettings
            }

            TextSwitch {
                id: showRefresh
                text: qsTr("Show Facebook refresh pulldown menu")
                checked: settings.showRefresh
            }

            TextSwitch {
                id: showLogout
                text: qsTr("Show Facebook logout pulldown menu")
                checked: settings.showLogout
            }

            SectionHeader{ text: qsTr("External links") }

            ComboBox {
                id: externalLink
                label: qsTr("Opening external link in")
                currentIndex: settings.externalLink
                menu: ContextMenu {
                    MenuItem { text: "Sailbook" }
                    MenuItem { text: qsTr("external browser") }
                }
            }

            SectionHeader{ text: qsTr("Notifications") }

            TextSwitch {
                id: notifyRequests
                text: qsTr("Notify friend requests")
                checked: settings.notifyRequests
                description: qsTr("%1 will send you notifications when getting a friend request.").arg("Sailbook")
            }

            TextSwitch {
                id: notifyMessages
                text: qsTr("Notify incoming messages")
                checked: settings.notifyMessages
                description: qsTr("%1 will send you notifications when receiving a new message.").arg("Sailbook")
            }

            TextSwitch {
                id: notifyNotifications
                text: qsTr("Notify new notifications")
                checked: settings.notifyNotifications
                description: qsTr("%1 will send you notifications when you have a new Facebook notification.").arg("Sailbook")
            }
        }
    }
}
