import QtQuick 2.2
import Sailfish.Silica 1.0

Dialog {
    property string path
    property string url
    property int type: 0

    Column {
        width: parent.width

        DialogHeader { title: qsTr("File name") }

        TextField {
            id: fileName
            width: parent.width
            placeholderText: qsTr("Name of the file")
            label: qsTr("Name")
            inputMethodHints: Qt.ImhUrlCharactersOnly
        }

        TextLabel { labelText: qsTr("The right extension is automatically added."); labelFontSize: Theme.fontSizeSmall }
    }

    onAccepted: {
        switch(type) {
        case 0:
            python.call("app.gallery.save", [path, fileName.text , url], function(result) {
                if(result) {
                    toaster.previewBody = qsTr("Saving image OK!")
                }
                else {
                    toaster.previewBody = qsTr("Saving image failed!")
                }
                toaster.publish()
            })
            break;
        case 1:
            python.call("app.facebook.downloadAttachment", [path, fileName.text , url], function(result) {
                if(result) {
                    toaster.previewBody = qsTr("Download complete!")
                }
                else {
                    toaster.previewBody = qsTr("Download failed!")
                }
                toaster.publish()
            })
            break;
        }
    }
}
