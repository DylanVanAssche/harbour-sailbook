import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property string url

    SilicaFlickable {
        anchors { fill: parent }

        PullDownMenu {
            MenuItem {
                text: qsTr("Save")
                onClicked: pageStack.push(Qt.resolvedUrl("../pages/InputPage.qml"), {path: StandardPaths.pictures + "/Sailbook", url: url})
            }
        }

        PageHeader {
            id: header
            title: qsTr("Image")
        }

        Image {
            id: image
            anchors { centerIn: parent }
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            source: visible? url: "qrc:///images/image-placeholder.png"
            asynchronous: true
        }

        BusyIndicator {
            anchors { centerIn: parent }
            size: BusyIndicatorSize.Large
            running: image.progress < 1.0
        }
    }
}
