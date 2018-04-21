import QtQuick 2.2
import Sailfish.Pickers 1.0

ImagePickerPage {
    property string imageUrl: selectedContent
    signal finished

    title: qsTr("Upload image")
    Component.onDestruction: { console.debug(JSON.stringify(selectedContent)); finished() }
}
