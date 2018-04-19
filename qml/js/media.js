function detectImage(request) {
    var imageExtensions = [".png", ".jpg", ".jpeg", ".bmp", ".svg"];
    for (var i=0; i < Object.keys(imageExtensions).length; i++) { // Search for common image formats in the URL
        if(request.url.toString().match(imageExtensions[i])) {
            request.action = WebView.IgnoreRequest;
            pageStack.push(Qt.resolvedUrl("../pages/ImagePage.qml"), { url: request.url.toString() });
            return true;
        }
    }
    return false;
}
