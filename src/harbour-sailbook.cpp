#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QtQml>
#include <QQuickView>
#include <QProcess>

void clearWebCache() {
    const QStringList cachePaths = QStandardPaths::standardLocations(
                QStandardPaths::CacheLocation);

    if (cachePaths.size()) {
        const QString webCache = QDir(cachePaths.at(0)).filePath(".QtWebKit");
        QDir cacheDir(webCache);
        if (cacheDir.exists()) {
            if (cacheDir.removeRecursively()) {
                qDebug() << "Cleared web cache:" << webCache;
            } else {
                qDebug() << "Failed to clear web cache:" << webCache;
            }
        } else {
            qDebug() << "Web cache does not exist:" << webCache;
        }
    } else {
        qDebug() << "No web cache available.";
    }
}

int main(int argc, char *argv[])
{
    setenv("QT_NO_FAST_MOVE", "0", 0);
    setenv("QT_NO_FT_CACHE","0",0);
    setenv("QT_NO_FAST_SCROLL","0",0);
    setenv("QT_NO_ANTIALIASING","1",1);
    setenv("QT_NO_FREE","1",1);
    setenv("USE_ASYNC", "1", 1);
    QQuickWindow::setDefaultAlphaBuffer(true);

    QGuiApplication* app = SailfishApp::application(argc, argv);

    QScopedPointer<QGuiApplication> application(SailfishApp::application(argc, argv));

    clearWebCache();

    application->setApplicationName("harbour-sailbook");

    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/harbour-sailbook.qml"));

    QObject::connect((QObject*)view->engine(), SIGNAL(quit()), app, SLOT(quit()));
    view->show();
    return app->exec();;
}
