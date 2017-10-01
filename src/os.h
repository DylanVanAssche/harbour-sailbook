#ifndef OS_H
#define OS_H

#include <sailfishapp/sailfishapp.h>
#include <QtGui/QGuiApplication>
#include <nemonotifications-qt5/notification.h>
#include <QtGui/QGuiApplication>
#include <QtCore/QtGlobal>
#include <QtCore/QDir>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QList>
#include <QtCore/QPair>
#include <QtCore/QFile>
#include <QtCore/QIODevice>
#include <QtCore/QTextStream>
#include <QtCore/QStandardPaths>
#include <QtCore/QDebug>

#define MAX_BODY_LENGTH 100
#define MAX_PREVIEW_LENGTH 40

class OS: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString release READ release NOTIFY releaseChanged)
    Q_PROPERTY(QString version READ version NOTIFY versionChanged)
    Q_PROPERTY(QString appName READ appName NOTIFY appNameChanged)
    Q_PROPERTY(QString appNamePretty READ appNamePretty NOTIFY appNamePrettyChanged)
    Q_PROPERTY(QString appVersion READ appVersion NOTIFY appVersionChanged)
    Q_PROPERTY(QString devicepixelratio READ devicepixelratio NOTIFY devicepixelratioChanged)

    public:
        explicit OS();
        Q_INVOKABLE void createNotification(QString title, QString text, QString feedback, QString category);
        Q_INVOKABLE void createToaster(QString text, QString icon, QString category);
        Q_INVOKABLE void closeNotificationByCategory(QString category);
        Q_INVOKABLE void closeNotificationByReplacesId(QString replacesId);
        Q_INVOKABLE void closeNotificationAll();
        QString release();
        QString version();
        QString device();
        QString cacheLocation();
        QString dataLocation();
        QString configLocation();
        QString photoLocation();
        QString musicLocation();
        QString documentLocation();
        QString videoLocation();
        QString downloadLocation();
        QString logLocation();
        QString logFile();
        QString appName();
        QString appNamePretty();
        QString appVersion();
        qreal devicepixelratio();

    signals:
        void releaseChanged();
        void versionChanged();
        void appNameChanged();
        void appNamePrettyChanged();
        void appVersionChanged();
        void devicepixelratioChanged();

    private:
        QList<QPair<QString, QString>> extractFileData(QString location, QStringList querryList);
        QString m_release;
        QString m_version;
        QString m_device;
};

#endif // OS_H
