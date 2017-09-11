var msgCode = {"HTML": 0, "EXTERNAL": 1, "VIDEO": 2, "DEBUG": 42}

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

// Execute
screenAdaption()

