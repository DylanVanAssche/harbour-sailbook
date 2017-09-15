#include "sailbook.h"

/* Sailbook class:
 *      - Clear cache function
 */
Sailbook::Sailbook() {
}

/* Clear the webview cache and return true if succesfull otherwise false. */
bool Sailbook::clearCache() {
    const QString cachePath = sfos.cacheLocation() + "/harbour-sailbook/.QtWebkit";
    qDebug() << cachePath;
    QDir webcache(cachePath);
    if (webcache.exists()) {
        if (webcache.removeRecursively()) {
            qInfo() << "Succesfully cleared webview cache (" << cachePath << ")";
            return true;
        }
        else {
            qCritical() << "Clearing webview cache failed (" << cachePath << ")!";
        }
    }
    else {
        qWarning() << "Webview cache not found (" << cachePath << ")";
    }
    return false;
}
