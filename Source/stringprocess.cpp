#include "stringprocess.h"
#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
StringProcess::StringProcess() {}

bool StringProcess::checkFormatTime(QString formatString)
{
    // format 'HH:mm:ss'
    QString format = "HH:mm:ss";

    // convert to dateTime
    QDateTime dateTime = QDateTime::fromString(formatString, format);

    // check valid
    return dateTime.isValid();
}
