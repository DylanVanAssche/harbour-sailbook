import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../js/media.js" as Media

Page {
    id: page
    property string url
    property int type

    Component.onCompleted: {
        switch(type) {
        case 0: // Internal Facebook video
            console.debug("Internal Facebook video: " + url);
            videoPlayer.source = url;
            break;
        }
    }

    Timer {
        id: hideControlBar
        running: true
        repeat: false
        interval: 2500
        onTriggered: videoPlayer.playbackState == MediaPlayer.PlayingState? controlBar.opacity = 0.0: undefined
    }

    Timer { // Give some time to buffer
        id: buffering
        running: false
        repeat: false
        interval: 1500
        onTriggered: videoPlayer.play()
    }

    SilicaFlickable {
        anchors { fill: parent }

        Column {
            anchors { fill: parent }

            PageHeader {
                id: header
                title: qsTr("Videoplayer")
            }

            VideoOutput {
                id: video
                width: parent.width
                height: parent.height - header.height
                fillMode: VideoOutput.PreserveAspectFit
                source: MediaPlayer {
                    id: videoPlayer
                    autoPlay: true
                    onStopped: controlBar.opacity = 1.0
                    onError: {
                        placeholder.enabled = true;
                        placeholder.text = qsTr("Error!");
                        placeholder.hintText = errorString;
                        video.visible = false;
                        console.error("Videoplayer can't load video: " + errorString)
                    }
                    onBufferProgressChanged: bufferProgress > 0.95? buffering.restart(): pause()
                }
            }
        }

        BusyIndicator { // Buffering video
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            visible: (videoPlayer.bufferProgress < 0.05 || buffering.running) && !placeholder.enabled
            running: true
        }

        MouseArea { // Clicking on video can resume or pause video
            anchors.fill: parent
            onClicked: {
                videoPlayer.playbackState == MediaPlayer.PlayingState? videoPlayer.pause(): videoPlayer.play()
                controlBar.opacity = 1.0
            }
        }

        Rectangle {
            id: controlBar
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom; }
            height: Theme.itemSizeHuge
            color: Theme.highlightDimmerColor
            onOpacityChanged: opacity == 1.0? hideControlBar.restart(): undefined

            Behavior on opacity { FadeAnimation {} }

            IconButton { // Play/Pause button
                anchors.horizontalCenter: parent.horizontalCenter
                anchors { bottom: videoProgress.top }
                icon.source: videoPlayer.playbackState == MediaPlayer.PausedState? "image://theme/icon-l-play?" + (pressed? Theme.highlightColor: Theme.primaryColor): "image://theme/icon-l-pause?" + (pressed? Theme.highlightColor: Theme.primaryColor)
                onClicked: {
                    videoPlayer.playbackState == MediaPlayer.PausedState? videoPlayer.play(): videoPlayer.pause()
                    hideControlBar.restart()
                }
            }

            Slider { // Progress video bar
                id: videoProgress
                enabled: videoPlayer.seekable
                anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
                maximumValue: videoPlayer.duration > 0 ? videoPlayer.duration : 1
                value: videoPlayer.position
                onReleased: {
                    videoPlayer.seek(value)
                    value = videoPlayer.position
                    hideControlBar.restart()
                }
            }
        }

        ViewPlaceholder {
            id: placeholder
        }
    }
}
