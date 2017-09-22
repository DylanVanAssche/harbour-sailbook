var msgCode = {"NOTIFICATION": 0, "EXTERNAL": 1, "VIDEO": 2, "DEBUG": 42};
var nightModeState = false;

// Create our JSON payload and send it to QML
function send(type, data) {
    var payload = new Object;
    payload.type = type;
    payload.data = data;
    navigator.qt.postMessage(JSON.stringify(payload))
}

// Adapt to different screen sizes
function screenAdaption() {
    var meta = document.createElement('meta');
    meta.setAttribute('name', 'viewport');
    if (screen.width <= 540) {
        meta.setAttribute('content', 'width=device-width/1.5, initial-scale='+(1.5)+', maximum-scale='+(1.5)+', user-scalable=yes');
    }
    else if (screen.width > 540 && screen.width <= 768) {
        meta.setAttribute('content', 'width=device-width/2.0, initial-scale='+(2.0)+', maximum-scale='+(2.0)+', user-scalable=yes');
    }
    else if (screen.width > 768) {
        meta.setAttribute('content', 'width=device-width/3.0, initial-scale='+(3.0)+', maximum-scale='+(3.0)+', user-scalable=yes');
    }
    else {
        meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
    }
    document.head.appendChild(meta);
}

// Create notificationObject
function getNotificationsData() {
    var notificationsData = document.getElementsByClassName("_59tg");
    var notificationObject = new Object;
    notificationObject.feed = parseInt(notificationsData[0].innerText) || 0;
    notificationObject.friends = parseInt(notificationsData[1].innerText) || 0;
    notificationObject.messenger = parseInt(notificationsData[2].innerText) || 0;
    notificationObject.notifications = parseInt(notificationsData[3].innerText) || 0;
    notificationObject.search = parseInt(notificationsData[4].innerText) || 0;
    notificationObject.options = parseInt(notificationsData[5].innerText) || 0;
    return notificationObject;
}

// Detect external links
function findHyperlink(element) {
    while(element) {
        if(element.tagName === "A") {
            try {
                send(42, element.dataset.store);
            }
            catch(e) {
                send(42, "NO DATASET STORE");
            }


            return element.href;
        }
        element = element.parentNode;
    }
}

// Detect HTML5 Facebook videos
function findFacebookVideo(touchEvent) {
    var element = touchEvent.target;

    if((element.tagName === "DIV") && (element.hasAttribute("data-sigil"))) {
        element = element.parentElement;
    }

    if((element.tagName === "I") && (element.hasAttribute("data-sigil"))) {
        element = element.parentElement;
    }

    if((element.tagName !== "DIV") || !element.hasAttribute("data-store")) {
        return false;
    }

    var video = JSON.parse(element.getAttribute("data-store"));

    if(!video.hasOwnProperty("videoID") || !video.hasOwnProperty("src")) {
        return false;
    }

    return video.src;
}

// Execute on load: attach evenlisteners and adapt screensizes
screenAdaption();
var notificationClasses = document.getElementsByClassName('_59tg');
for(var i=0; i<notificationClasses.length; i++) {
    notificationClasses[i].addEventListener('DOMSubtreeModified', function() {
        send(msgCode["NOTIFICATION"], getNotificationsData());
    }, false);
}
document.addEventListener('click', function(element) { // Trigger on link click
    var externalUrl = findHyperlink(element.target);
    if(externalUrl.match("lm.facebook.com")) { // Valid external link detection
        send(msgCode["EXTERNAL"], externalUrl);
    }
}, true); // useCapture=true: trigger on click begin
document.addEventListener("touchend",  function(touchEvent) { // Trigger on video touch
    var videoUrl = findFacebookVideo(touchEvent);
    if (videoUrl.match("fbcdn.net")) { // Valid Facebook video link detection
        send(msgCode["VIDEO"], videoUrl);
    }
}, true); // useCapture=true: trigger on touch begin
