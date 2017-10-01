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

QT += core \
    gui \
    dbus \
    network

# Disable debug and warning messages while releasing for security reasons
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT \
QT_NO_WARNING_OUTPUT

# APP_VERSION retrieved from .spec file
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

PKGCONFIG += nemonotifications-qt5

SOURCES += src/harbour-sailbook.cpp \
    src/sailbook.cpp \
    src/os.cpp \
    src/logger.cpp \
    src/transferengine.cpp

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
    translations/harbour-sailbook-es.ts \
    translations/harbour-sailbook-pl.ts \
    translations/harbour-sailbook-fr.ts

DISTFILES += \
    qml/pages/AboutPage.qml \
    qml/pages/TranslationsPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/js/util.js \
    qml/pages/js/messages.js \
    qml/pages/ExternalUrlPage.qml \
    qml/pages/VideoPage.qml \
    qml/pages/ImagePage.qml \
    qml/pages/js/media.js \
    qml/pages/ImageSelectorPage.qml \
    rpm/harbour-sailbook.changes \
    qml/pages/PlaceholderWebview.qml \
    qml/components/ExternalWebview.qml \
    qml/components/FBWebview.qml \
    qml/components/IconTextButton.qml \
    qml/components/ImagePicker.qml \
    qml/components/PlaceholderWebview.qml \
    qml/components/TextLabel.qml \
    qml/components/NavigationButton.qml \
    qml/js/media.js \
    qml/js/messages.js \
    qml/js/util.js

HEADERS += \
    src/sailbook.h \
    src/os.h \
    src/logger.h \
    src/transferengine.h

RESOURCES += \
    qml/resources/resources.qrc
