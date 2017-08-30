import QtQuick 2.2
import Sailfish.Silica 1.0
import "./js/util.js" as Util

Page {
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height

        VerticalScrollDecorator {}

        Column {
            id: aboutColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("About") }

            SectionHeader { text: qsTr("What's") + " Sailbook?" }
            TextLabel { labelText: qsTr("Sailbook is an unofficial Facebook client for Sailfish OS.") }

            SectionHeader { text: qsTr("Privacy & licensing") }
            TextLabel { labelText: "Sailbook " + qsTr("is free software released under the GNU General Public License (GPL), version 3 or later.") }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("GitHub")
                iconSource: "../resources/images/icon-github.png"
                onClicked: { Qt.openUrlExternally("https://github.com/Sailbook/harbour-sailbook");
                }
            }

            SectionHeader { text: "Telegram" }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Telegram Sailbook Group")
                iconSource: "../resources/images/icon-telegram.png"
                onClicked: { Qt.openUrlExternally("https://t.me/joinchat/Fcodjwu4wFLZDSO_AsMQaQ");
                }
            }

            SectionHeader { text: qsTr("Developers") }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Rudi Timmermans")
                iconSource: "../resources/images/image-rudi.jpg"
                onClicked: { Qt.openUrlExternally("https://www.twitter.com/xray20001");
                }
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Dylan Van Assche")
                iconSource: "../resources/images/image-dylan.jpg"
                onClicked: { Qt.openUrlExternally("https://www.github.com/modulebaan");
                }
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Matthias Weiß")
                iconSource: "../resources/images/image-matthias.jpg"
                onClicked: { Qt.openUrlExternally("https://github.com/codeandcreate");
                }
            }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Donate with Paypal")
                iconSource: "../resources/images/icon-paypal.png"
                onClicked: { Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6Z4P9MAAD996W");
                }
            }

            SectionHeader { text: qsTr("Translators") }

            IconTextButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Translations")
                iconSource: "../resources/images/icon-trans.png"
                onClicked: pageStack.push(Qt.resolvedUrl("TranslationsPage.qml"))
            }

            SectionHeader { text: qsTr("Icons") }
            TextLabel { labelText: qsTr("Sailbook icons made by Alain Molteni.") }

            SectionHeader { text: qsTr("Version") }
            TextLabel { labelText: app.appName + " v" + app.version }

            Item { width: parent.width; height: Theme.itemSizeMedium } //Spacer
        }
    }
}
