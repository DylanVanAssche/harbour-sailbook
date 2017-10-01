#ifndef SAILBOOK_H
#define SAILBOOK_H

#include <QtCore/QtGlobal>
#include <QtCore/QObject>
#include <QtCore/QDebug>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QDir>
#include <QtCore/QStandardPaths>
#include "os.h"

class Sailbook: public QObject {
    Q_OBJECT

    public:
        explicit Sailbook();
        bool clearCache();

    private:
        OS sfos;
};

#endif // SAILBOOK_H
