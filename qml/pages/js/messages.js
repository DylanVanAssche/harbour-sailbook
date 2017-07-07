function parse(msg) {
    msg = JSON.parse(msg);
    switch(msg.type)
    {
    case 0:
        python.call("app.facebook.getNotifications", [msg.data]);
        break;
    case 1:
        toaster.previewBody = qsTr("Opening external link") + "...";
        toaster.publish();

        if(msg.data.match("cdn.fbsbx.com")) { // When attachment downloaded, go back
            fbWebview.goBack();
        }

        if(settings.externalLink == 1) {
            Qt.openUrlExternally(msg.data);
        }
        else {
            pageStack.push(Qt.resolvedUrl("../ExternalUrlPage.qml"), { url: msg.data });
        }
        break;
    case 2:
        pageStack.push(Qt.resolvedUrl("../VideoPage.qml"), { url: [msg.data], type: 0 }); // Facebook video
        break;
    default:
        console.log(JSON.stringify(msg));
        break;
    }
}

// Follow link first before sending to Youtube-DL !!!! Python?
// Check if link is a video and supported by Youtube-DL
function checkYoutubeDLcompatible(link) {
    var compatibleLinks = ["youtube", "m.youtube", "youtu", "goo.gl", "dailymotion"]
    for (var i=0; i < Object.keys(compatibleLinks).length; i++) {
        if(link.match(compatibleLinks[i])) {
            return true;
        }
    }
    return false;
}

/* Video links for Youtube and other sites are detected on external link click*/
