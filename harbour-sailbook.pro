# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-sailbook

i18n_files.files = translations
i18n_files.path = /usr/share/$$TARGET

INSTALLS += i18n_files

CONFIG += sailfishapp

SOURCES += src/harbour-sailbook.cpp

OTHER_FILES += qml/harbour-sailbook.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-sailbook.spec \
    rpm/harbour-sailbook.yaml \
    translations/*.ts \
    harbour-sailbook.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

CONFIG += sailfishapp_i18n

TRANSLATIONS += \
    translations/harbour-sailbook-de.ts \
    translations/harbour-sailbook-fi.ts \
    translations/harbour-sailbook-nl.ts \
    translations/harbour-sailbook-it.ts \
    translations/harbour-sailbook-fr.ts

DISTFILES += \
    qml/resources/css/sailbook.css \
    qml/resources/js/sailbook.js \
    qml/pages/AboutPage.qml \
    qml/pages/TextLabel.qml \
    qml/pages/GlassButton.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/js/util.js \
    qml/pages/NavigationButton.qml \
    qml/pages/FBWebview.qml \
    qml/pages/js/messages.js \
    qml/pages/ExternalUrlPage.qml \
    qml/pages/ExternalWebview.qml \
    qml/resources/js/external.js \
    qml/pages/NotificationManager.qml \
    qml/pages/js/notify.js \
    qml/resources/images/icon-twitter.png \
    qml/resources/images/icon-sailbook.png \
    qml/resources/images/icon-paypal.png \
    qml/resources/images/icon-notifications.png \
    qml/resources/images/icon-github.png \
    qml/resources/images/icon-fontawesome.png \
    qml/resources/images/icon-external.png \
    qml/resources/images/sources.txt \
    qml/pages/LoadscreenWebview.qml \
    qml/pages/ImagePicker.qml \
    qml/pages/VideoPage.qml \
    qml/pages/ImagePage.qml \
    qml/pages/js/media.js \
    qml/pages/ImageSelectorPage.qml \
    qml/resources/css/external.css \
    qml/pages/Toaster.qml \
    qml/pages/InputPage.qml \
    rpm/harbour-sailbook.changes \
    qml/pages/SplashScreen.qml
