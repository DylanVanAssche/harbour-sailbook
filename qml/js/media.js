function detectDownload(request) {
    var facebookLinks = ["https://cdn.fbsbx"];
    if(request.url.toString().slice(0,30).match(facebookLinks[0])) {
        console.debug("Download started... " + request.url.toString())
        request.action = WebView.IgnoreRequest;
        pageStack.completeAnimation()
        pageStack.replace(Qt.resolvedUrl("../InputPage.qml"), {path: StandardPaths.download + "/Sailbook", url: request.url.toString(), type: 1})
        return true;
    }
    return false;
}

function detectImage(request) {
    var imageExtensions = [".png", ".jpg", ".jpeg", ".bmp", ".svg"];
    for (var i=0; i < Object.keys(imageExtensions).length; i++) { // Search for common image formats in the URL
        if(request.url.toString().match(imageExtensions[i])) {
            request.action = WebView.IgnoreRequest;
            python.call("app.facebook.followReferal", [request.url.toString()], function(link) {
                pageStack.push(Qt.resolvedUrl("../ImagePage.qml"), { url: link });
            });
            return true;
        }
    }
    return false;
}

function detectYoutubeDLVideo(request) {
    var youtubeLinks = ["youtube", "youtu", "m.youtube", "m.youtu"];
    for (var i=0; i < Object.keys(youtubeLinks).length; i++) { // Search for common image formats in the URL
        if(request.url.toString().match(youtubeLinks[i])) {
            _isYoutube = true;
            request.action = WebView.IgnoreRequest;
            python.call("app.youtubedl.getStream", [request.url.toString()], function(videoData) {
                pageStack.replace("../VideoPage.qml", { url: videoData, type: 1 });
            });
            return true;
        }
    }
    return false;
}

function getVideoUrl(type, url) {
    switch(type) {
    case 0: // Internal Facebook video
        return url[0];

    case 1: // Youtube video, preprocessing necessary!
        var format = "360p";
        var fallback = false;
        if("Forbidden" in url) { // Video can't be opened on this device, show error
            return fallback;
        }

        if(settings.videoQuality == 1) { // Default 360p, check if user wants 720p
            format = "720p";
        }

        for (var i=0; i < Object.keys(url).length; i++) { // Search for our format in the links from Youtube-DL
            if(format in url[i]) {
                return url[i][format]
            }
            else if ("360p" in url[i]) { // Save a fallback url is available
                fallback = url[i]["360p"];
            }
        }
        return fallback;
    }
}

function determineIcon() {
    var iconSource = "image://theme/icon-m-file-image"
    if (fileModel.isDir) {
        iconSource = "image://theme/icon-m-file-folder"
    }
    return iconSource + (highlighted ? "?" + Theme.highlightColor : "")
}
