import QtQuick 2.0
import org.nemomobile.notifications 1.0


Item {
    id: notification
    property string summary
    property string body
    property string previewSummary
    property string previewBody
    property string activeUrl
    property int count: 1

    function publish()
    {
        if(settings.showNotifications) {
            notify.summary = summary
            notify.body = body
            notify.previewSummary = previewSummary
            notify.previewBody = previewBody
            notify.publish()
        }
    }

    function close()
    {
        notify.close()
    }

    Notification {
        id: notify
        category: "x-nemo.social.facebook.notification"
        appName: "Sailbook"
        appIcon: "/usr/share/harbour-sailbook/qml/resources/images/icon-sailbook.svg"
        itemCount: count
        timestamp: new Date("yyyy-MM-dd hh:mm:ss")
        replacesId: 0
        onClicked: console.log("Clicked")
        onClosed: {
            app.activate() // Bring to foreground
            console.log("Closed, reason: " + reason)
        }
    }
}

