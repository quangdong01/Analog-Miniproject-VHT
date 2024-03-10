#include "logtcpserverlock.h"

LogTcpServer::LogTcpServer(QString contentLog, QString dirLog, QObject *parent)
    : QObject(parent)
{
    static QMutex mutex;
    mutex.lock();
    QString time_format = "yyyy-MM-dd HH:mm:ss";
    QDateTime dateTime = dateTime.currentDateTime();
    QString strTime = dateTime.toString(time_format);
    this->dateTimeLog = strTime;
    this->contentLog = contentLog;
    this->dirLog = dirLog;
    mutex.unlock();
}
LogTcpServer::~LogTcpServer()
{

}

QString LogTcpServer::getDateTimeLog() const
{
    return this->dateTimeLog;
}

QString LogTcpServer::getContentLog() const
{
    return this->contentLog;
}

QString LogTcpServer::getDirLog() const
{
    return this->dirLog;
}

void LogTcpServer::setDateTimeLog(QString dateTimeLog)
{
    this->dateTimeLog = dateTimeLog;
}

void LogTcpServer::setContentLog(QString contentLog)
{
    this->contentLog = contentLog;
}

void LogTcpServer::setDirLog(QString dirLog)
{
    this->dirLog = dirLog;
}
