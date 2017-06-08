var oldRequests = 0;
var oldMessages = 0;
var oldNotificastions = 0;

function requests(data) {
    if(data > 0 && typeof data !== 'undefined' && data != oldRequests && settings.showFriends && settings.enableNotifications) { // detect if data is valid and higher then 0
        oldRequests = data;
        notifyRequests.close(); // Close previous
        notifyRequests.previewSummary = data + " " + qsTr("friend request(s)");
        notifyRequests.previewBody = qsTr("You have") + " " + data + " " + qsTr("friend request(s)") + "!";
        notifyRequests.summary = notifyRequests.previewSummary;
        notifyRequests.body = notifyRequests.previewBody;
        notifyRequests.count = data;
        notifyRequests.publish();
        notifyRequests.activeUrl = "https://m.facebook.com/friends"
    }
    else if(data == 0) { // User read notification, reset
        notifyRequests.close();
        oldRequests = 0;
    }
}


function messages(data) {
    if(data > 0 && typeof data !== 'undefined' && data != oldMessages && settings.showMessages && settings.enableNotifications) { // detect if data is valid and higher then 0
        oldMessages = data;
        notifyMessages.close(); // Close previous
        notifyMessages.previewSummary = data + " " + qsTr("message(s)");
        notifyMessages.previewBody = qsTr("You have") + " " + data + " " + qsTr("message(s)") + "!";
        notifyMessages.summary = notifyMessages.previewSummary;
        notifyMessages.body = notifyMessages.previewBody;
        notifyMessages.count = data;
        notifyMessages.publish();
        notifyMessages.activeUrl = "https://m.facebook.com/messages"
    }
    else if(data == 0) { // User read notification, reset
        notifyMessages.close();
        oldMessages = 0;
    }
}

function notifications(data) {
    if(data > 0 && typeof data !== 'undefined' && data != oldNotificastions && settings.showNotifications && settings.enableNotifications) { // detect if data is valid and higher then 0
        oldNotificastions = data;
        notifyNotifications.close(); // Close previous
        notifyNotifications.previewSummary = data + " " + qsTr("notification(s)");
        notifyNotifications.previewBody = qsTr("You have") + " " + data + " " + qsTr("notification(s)") + "!";
        notifyNotifications.summary = notifyNotifications.previewSummary;
        notifyNotifications.body = notifyNotifications.previewBody;
        notifyNotifications.count = data;
        notifyNotifications.publish();
        notifyNotifications.activeUrl = "https://m.facebook.com/notifications"
    }
    else if (data == 0) { // User read notification, reset
        notifyNotifications.close();
        oldNotificastions = 0;
    }
}
