import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/js/util.js" as Util

CoverBackground {

    // App Icon
    Image
    {
        id: imgcover
        source: "../resources/images/icon-cover.svg"
        asynchronous: true
        opacity: 0.2
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.bottomMargin
        fillMode: Image.PreserveAspectFit
    }

    Column {
		anchors {
			fill: parent
			topMargin: Theme.paddingMedium
			leftMargin: Theme.paddingLarge
			rightMargin: Theme.paddingLarge 
		}
        spacing: Theme.paddingMedium

        // Messages
        Item {
            width: parent.width
            height: numberOfMessages.contentHeight

            Label {
                id: numberOfMessages
                anchors { left: parent.left; top: parent.top; }
                font.pixelSize: Theme.fontSizeHuge
                font.family: Theme.fontFamilyHeading
                text: Util.formatNotificationNumber(2)
            }

            Label {
                wrapMode: Text.WordWrap
                text: qsTr("unread") + "\n" + qsTr("message(s)")
                font.pixelSize: Theme.fontSizeExtraSmall
                font.family: Theme.fontFamilyHeading
                font.weight: Font.Light
                lineHeight: 0.8
                truncationMode: TruncationMode.Fade 

                anchors {
                    left: numberOfMessages.right
                    leftMargin: Theme.paddingMedium
                    verticalCenter: numberOfMessages.verticalCenter
                }
           }
        }

        // Friend requests and notifications
        Row {
            spacing: Theme.paddingMedium
            anchors { left: parent.left; right: parent.right }

            // Notifications
            Image {
                width: Theme.iconSizeSmall
                height: width
                source: "../resources/images/icon-notifications.svg"
                anchors {
                    verticalCenter: numberOfNotifications.verticalCenter
                }
            }

            Label {
                id: numberOfNotifications
                text: Util.formatNotificationNumber(3)
            }

            // Friend requests
            Image {
                width: Theme.iconSizeSmall*1.1
                height: width
                source: "../resources/images/icon-requests.svg"
                anchors {
                    verticalCenter: numberOfFriendRequests.verticalCenter
                }
            }

            Label {
                id: numberOfFriendRequests
                text: Util.formatNotificationNumber(1)
            }
        }
    }
}
