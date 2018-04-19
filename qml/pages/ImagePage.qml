import QtQuick 2.0
import Sailfish.Silica 1.0
import Harbour.Sailbook.Transferengine 1.0
import Harbour.Sailbook.SFOS 1.0

Page {
    id: page

    property string url

    SFOS {
        id: sfos
    }

    Transferengine {
        id: transferengine
        onDownloadFinished: sfos.createToaster(qsTr("Saving image complete") + "!", "icon-s-installed", "sailbook-external");
    }

    SilicaFlickable {
        anchors { fill: parent }

        PullDownMenu {
            MenuItem {
                text: qsTr("Save")
                onClicked: transferengine.download(url)
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
            source: url
            asynchronous: true
        }

        BusyIndicator {
            anchors { centerIn: parent }
            size: BusyIndicatorSize.Large
            running: image.progress < 1.0
        }
    }
}
