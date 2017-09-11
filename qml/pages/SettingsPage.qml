import QtQuick 2.2
import Sailfish.Silica 1.0
import "./js/util.js" as Util

Dialog {

    onAccepted: {
        settings.enableNotifications = notifications.checked
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
        settings.placeBack = placeBack.currentIndex
        settings.theme = theme.currentIndex
        settings.enableNightmode = enableNightmode.checked
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

            TextSwitch {
                id: enableNightmode
                text: qsTr("Enable nightmode")
                checked: settings.enableNightmode
                description: qsTr("%1 will use dark colors to reduce eye strain while browsing Facebook in the dark.").arg("Sailbook")
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

            SectionHeader{ text: qsTr("Video player") }

            TextSwitch {
                id: enableVideoPlayer
                text: qsTr("Enable native videoplayer")
                enabled: settings.externalLink==0
                checked: settings.enableVideoPlayer
                description: qsTr("%1 will open Facebook and Youtube videos in his native videoplayer. If disabled, they will be opened in the external browser.").arg("Sailbook")
            }

            ComboBox {
                id: videoQuality
                label: qsTr("Video quality")
                currentIndex: settings.videoQuality
                menu: ContextMenu {
                    MenuItem { text: qsTr("360p (SD)") }
                    MenuItem { text: qsTr("720p (HD)") }
                }
            }

            SectionHeader{ text: qsTr("Notifications") }

            IconTextSwitch {
                id: notifications
                text: qsTr("Enable notifications")
                icon.source: "../resources/images/icon-notifications.png"
                icon.scale: Theme.iconSizeMedium/icon.width // Scale icons according to the screen sizes
                checked: settings.enableNotifications
                description: qsTr("%1 will send you notifications when you have a new message, a new notification or a friend request.").arg("Sailbook")
            }
        }
    }
}
