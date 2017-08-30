/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import org.nemomobile.configuration 1.0
import "pages"
import "./pages/js/notify.js" as Notify

ApplicationWindow
{
    id: app
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    property bool pythonReady
    property bool connected: true // Improve startup speed
    property variant notifications: [0,0,0,0,0,0,0,0,0]
    property string appName: "Sailbook"
    property string version: "9.2"
    property string userAgentName
    property string userAgent

    // App settings
    ConfigurationGroup {
        id: settings
        path: "/apps/harbour-sailbook/settings"

        property bool enableNotifications: false
        property bool showFeed: true
        property bool showFriends: true
        property bool showMessages: true
        property bool showNotifications: true
        property bool showSearch: true
        property bool showEvents: false
        property bool showGroups: false
        property bool showLikedPages: false
        property bool showSettings: false
        property bool showLogout: false
        property bool enableVideoPlayer: true
        property bool enableNightmode: false
        property int priorityFeed: 0
        property int placeBack: 0
        property int intervalNotifications: 1
        property int theme: 0
        property int externalLink: 0
        property int videoQuality: 0
    }

    Toaster { id: toaster }
    NotificationManager { id: notifyRequests }
    NotificationManager { id: notifyMessages }
    NotificationManager { id: notifyNotifications }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl("./backend")); //Add the import path for our QML/Python bridge 'app.py'
            addImportPath(Qt.resolvedUrl("./backend/sailbook")); //Add import path for our backend module 'sailbook'
            addImportPath(Qt.resolvedUrl("./backend/lib/noarch/")); //Platform indepent imports
            importModule("platform", function() {   //Add the right import path depending on the architecture of the processor
                if (evaluate("platform.machine()") == "armv7l") {
                    console.log("[INFO] ARM processor detected")
                    addImportPath(Qt.resolvedUrl("./backend/lib/armv7l/"));
                } else {
                    console.log("[INFO] x86 processor detected")
                    addImportPath(Qt.resolvedUrl("./backend/lib/i486/"));
                }

                importModule("app", function() {}); // Import "app" after we imported our platform specific modules
                call("app.connection.status") // Check our network status at launch
                pythonReady = true
                if(Qt.application.arguments[1] == "debug") {
                    console.log("[INFO] User enabled debugging, check the log file for verbose output.")
                    call("app.debug.enable")
                }
            })

            //Receive our parsed notifications
            setHandler("notifications", function (notificationsList) {
                notifications = notificationsList
                Notify.requests(notificationsList[1])
                Notify.messages(notificationsList[2])
                Notify.notifications(notificationsList[3])
                console.log(notificationsList)
            });

            setHandler("network", function (status, type) {
                console.log("[INFO] Network status: " + status)
                connected = status
            });
        }
        onError: console.log("Error: %1".arg(traceback));
        onReceived: console.log("Message: " + JSON.stringify(data));
    }
}

