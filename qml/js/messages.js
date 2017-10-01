function parse(msg) {
    msg = JSON.parse(msg);
    switch(msg.type)
    {
    case 0:
        requestsData = msg.data.friends;
        messagesData = msg.data.messenger;
        notificationsData = msg.data.notifications;

        if(!webview.loading) { // When loading, FB updates these properties several times, this workaround prevents too many notifications. After loading we call this manually.
            publishNotifications();
        }
        app.notifications = [0, msg.data.friends, msg.data.messenger, msg.data.notifications, msg.data.search, msg.data.options, 0, 0, 0];

        var eventMsg = "Notification event received: requests=" + requestsData + " messages=" + messagesData + " notifications=" + notificationsData;
        console.debug(eventMsg)
        break;
    case 1:
        sfos.createToaster(qsTr("Opening external link") + "...", "icon-s-time", "sailbook-external");

        if(msg.data.match("cdn.fbsbx.com")) { // When attachment downloaded, go back
            fbWebview.goBack();
        }

        if(settings.externalLink == 1) {
            Qt.openUrlExternally(msg.data);
        }
        else {
            pageStack.push(Qt.resolvedUrl("../pages/ExternalUrlPage.qml"), { url: msg.data });
        }
        break;
    case 2:
        pageStack.push(Qt.resolvedUrl("../pages/VideoPage.qml"), { url: msg.data }); // Facebook video
        break;

    case 3:
        Qt.openUrlExternally(msg.data);
        break;
    default:
        console.debug(JSON.stringify(msg));
        break;
    }
}


var requestsData = 0;
var messagesData = 0;
var notificationsData = 0;
var requestsDataOld = 0;
var messagesDataOld = 0;
var notificationsDataOld = 0;

function _requests() {
    // Notification data is different from the older notification data, create new notification. If 0, reset and close.
    if(requestsData == 0) {
        requestsDataOld = 0;
        sfos.closeNotificationByCategory("sailbook-request");
    }
    else if(requestsDataOld != requestsData && settings.showFriends && settings.enableNotifications) {
        var title = requestsData==1? qsTr("New friend request"): qsTr("New friend requests");
        var text = requestsData==1? qsTr("You have %1 new friend request").arg(requestsData): qsTr("You have %1 friend requests").arg(requestsData);
        sfos.createNotification(title, text, "social", "sailbook-request");
        requestsDataOld = requestsData;
    }
}

function _messages() {
    // Notification data is different from the older notification data, create new notification. If 0, reset and close.
    if(messagesData == 0) {
        messagesDataOld = 0;
        sfos.closeNotificationByCategory("sailbook-message");
    }
    else if(messagesDataOld != messagesData && settings.showMessages && settings.enableNotifications) {
        var title = messagesData==1? qsTr("New message"): qsTr("New messages");
        var text = messagesData==1? qsTr("You have %1 new message").arg(messagesData): qsTr("You have %1 messages").arg(messagesData);
        sfos.createNotification(title, text, "social", "sailbook-message");
        messagesDataOld = messagesData;
    }
}

function _notifications() {
    // Notification data is different from the older notification data, create new notification. If 0, reset and close.
    if(notificationsData == 0) {
        notificationsDataOld = 0;
        sfos.closeNotificationByCategory("sailbook-notification");
    }
    else if(notificationsDataOld != notificationsData && settings.showNotifications && settings.enableNotifications) {
        var title = notificationsData==1? qsTr("New notification"): qsTr("New notifications");
        var text = notificationsData==1? qsTr("You have %1 new notification").arg(notificationsData): qsTr("You have %1 notifications").arg(notificationsData);
        sfos.createNotification(title, text, "social", "sailbook-notification");
        notificationsDataOld = notificationsData;
    }
}

function publishNotifications() {
    console.debug("Publishing notifications...")
    _requests();
    _messages();
    _notifications();
}
