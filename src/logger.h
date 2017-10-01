#ifndef LOGGER_H
#define LOGGER_H

#include <QtDebug>
#include <QtCore/QtGlobal>
#include <QtCore/QCoreApplication>
#include <QtCore/QString>
#include <QtCore/QTextStream>
#include <QtCore/QDebug>
#include <QtCore/QDateTime>
#include <QtCore/QFile>
#include <QtCore/QDir>
#include <QtCore/QIODevice>

#define LINE_LENGTH 100

static bool clearLog = true;
static QString name;
static QString version;
static QString compileDate;
static QString compileTime;
static QString logpath;
void handler(QtMsgType type, const QMessageLogContext &context, const QString &msg);
bool enableLogger(bool enabled);

#endif // LOGGER_H
