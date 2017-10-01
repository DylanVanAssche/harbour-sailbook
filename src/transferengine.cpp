#include "transferengine.h"

/* Transfer engine to transfer files.
 * Currently, the following features are supported:
 *      - Download a file with a given link
 */
Transferengine::Transferengine()
{
    // Initiate a new QNetworkAccessManager
    QNAM = new QNetworkAccessManager(this);
    QNetworkConfigurationManager QNAM_config;
    QNAM->setConfiguration(QNAM_config.defaultConfiguration());

    // Connect QNetworkAccessManager signals
    connect(QNAM, SIGNAL(networkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility)), this, SLOT(networkAccessible(QNetworkAccessManager::NetworkAccessibility)));
    connect(QNAM, SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)), this, SLOT(sslErrors(QNetworkReply*,QList<QSslError>)));
    connect(QNAM, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));
}

/* Download a file from the Internet given an URL */
void Transferengine::download(QString url) {
    qInfo() << "Download started for URL:" << url;
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::UserAgentHeader, m_useragent);
    QNAM->get(request);
}

/* Save the file as soon as the request has been completed */
void Transferengine::finished(QNetworkReply *reply) {
    if(reply->error())
    {
        qCritical() << reply->errorString();
    }
    else
    {
        qInfo() << "Download finished!";
        qDebug() << "Content-Length:" << reply->header(QNetworkRequest::ContentLengthHeader).toULongLong() << "bytes";
        qDebug() << "HTTP code:" << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

        if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() < 300) {
            QByteArray data = reply->readAll();
            QString mime = QMimeDatabase().mimeTypeForData(data).name();
            QString time = QDateTime::currentDateTime().toString("dd-MM-yyyy_hh:mm:ss");
            if(mime == "image/jpeg") {
                file.setFileName(sfos.photoLocation() + "/" + time + ".jpg");
            }
            else {
                qWarning() << "MIME type unsupported!";
            }
            file.open(QIODevice::WriteOnly);
            file.write(data);
            file.close();
            emit downloadFinished();
        }
        else {
            qInfo() << "HTTP redirection or an error has occured while downloading.";
        }
    }

    reply->deleteLater();
}

/* Log SSL errors */
void Transferengine::sslErrors(QNetworkReply* reply, QList<QSslError> sslError) {
    qCritical() << "SSL error occured:" << reply->errorString() << sslError;
}

/* Log network status */
void Transferengine::networkAccessible(QNetworkAccessManager::NetworkAccessibility state) {
    QString networkStatus = "Network status: %1";
    qInfo() << networkStatus.arg(state);
}
