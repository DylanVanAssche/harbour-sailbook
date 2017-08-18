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
            GlassButton { iconSource: "../resources/images/icon-github.png"; iconText: "GitHub"; link: "https://github.com/Sailbook/harbour-sailbook" }

            SectionHeader { text: "Telegram" }
            GlassButton { iconSource: "../resources/images/icon-telegram.png"; iconText: "Telegram Sailbook Group"; link: "https://t.me/joinchat/Fcodjwu4wFLZDSO_AsMQaQ" }

            SectionHeader { text: qsTr("Developers") }
            GlassButton { iconSource: "../resources/images/image-rudi.jpg"; iconText: "Rudi Timmermans"; link: "https://www.twitter.com/xray20001" }
            GlassButton { iconSource: "../resources/images/image-dylan.jpg"; iconText: "Dylan Van Assche"; link: "https://www.github.com/modulebaan" }
            GlassButton { iconSource: "../resources/images/icon-paypal.png"; iconText: "Donate with Paypal"; link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6Z4P9MAAD996W" }

            SectionHeader { text: qsTr("Translators") }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Translations")
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
