#ifndef TRANSFERENGINE_H
#define TRANSFERENGINE_H

#include <QtCore/QtGlobal>
#include <QtCore/QObject>
#include <QtCore/QDebug>
#include <QtCore/QDataStream>
#include <QtCore/QFile>
#include <QtCore/QList>
#include <QtCore/QMimeDatabase>
#include <QtCore/QMimeData>
#include <QtCore/QMimeType>
#include <QtCore/QDateTime>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkConfigurationManager>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QSslError>

#include "os.h"

class Transferengine: public QObject {
    Q_OBJECT

    public:
        explicit Transferengine();
        Q_INVOKABLE void download(QString url);

    signals:
        void downloadFinished();

    private slots:
        void finished(QNetworkReply *reply);
        void sslErrors(QNetworkReply*,QList<QSslError>);
        void networkAccessible(QNetworkAccessManager::NetworkAccessibility accessible);

    private:
        QString m_useragent = QString("Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/14A403 Safari/602.1");
        QFile file;
        OS sfos;
        QNetworkAccessManager *QNAM;
};

#endif // TRANSFERENGINE_H
