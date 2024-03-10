#ifndef LOGTCPSERVER_H
#define LOGTCPSERVER_H
#include <QObject>
#include <QDateTime>
#include <QMutex>
#include <QString>
class LogTcpServer : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QString dateTimeLog MEMBER dateTimeLog NOTIFY dateTimeLogChanged)
    Q_PROPERTY (QString contentLog MEMBER contentLog NOTIFY contentLogChanged)
    Q_PROPERTY (QString dirLog MEMBER dirLog NOTIFY dirLogChanged)

public:
    LogTcpServer(QString, QString, QObject *parent = nullptr);
    //LogTcpServer(QString, QString);
    ~LogTcpServer();

private:
    QString dateTimeLog;
    QString contentLog;
    QString dirLog;

signals:
    void dateTimeLogChanged();
    void contentLogChanged();
    void dirLogChanged();

public:
    QString getDateTimeLog() const;
    QString getContentLog() const;
    QString getDirLog() const;
    void setDateTimeLog(QString);
    void setContentLog(QString);
    void setDirLog(QString);

};

#endif // LOGTCPSERVER_H
