#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp/sailfishapp.h>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QtQml>
#include <QQuickView>
#include "sailbook.h"
#include "logger.h"
#include "os.h"
#include "transferengine.h"

#define APP_VERSION "10.0-0"

int main(int argc, char *argv[])
{
    // Setup environment
    setenv("QT_NO_FAST_MOVE", "0", 0);
    setenv("QT_NO_FT_CACHE", "0", 0);
    setenv("QT_NO_FAST_SCROLL", "0", 0);
    setenv("QT_NO_ANTIALIASING", "1", 1);
    setenv("QT_NO_FREE", "1", 1);
    setenv("USE_ASYNC", "1", 1);
    QQuickWindow::setDefaultAlphaBuffer(true);
    QGuiApplication* app = SailfishApp::application(argc, argv);
    qApp->setApplicationVersion(QString(APP_VERSION));

    // Init Sailbook object and clear webview cache
    Sailbook sailbook;
    sailbook.clearCache();

    // TEST
    //Transferengine engine;
    //engine.download("https://upload.wikimedia.org/wikipedia/en/d/dc/Gran_Palacio%2C_Bangkok%2C_Tailandia%2C_2013-08-22%2C_DD_57_%28Cropped%29.jpg");

    // Enable logger
    enableLogger(true);

    // Expose C++ modules to QML
    qmlRegisterType<OS>("Harbour.Sailbook.SFOS", 1, 0, "SFOS");
    qmlRegisterType<Transferengine>("Harbour.Sailbook.Transferengine", 1, 0, "Transferengine");

    // Create view, attach quit() signal and show QML
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/harbour-sailbook.qml"));
    QObject::connect((QObject*)view->engine(), SIGNAL(quit()), app, SLOT(quit()));
    view->show();

    return app->exec();;
}
