#ifndef TCPCLOCK_H
#define TCPCLOCK_H
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtNetwork/QTcpServer>
#include <QTNetwork/QTcpSocket>
#include <QList>
#include "logtcpserverlock.h"
#include "stringprocess.h"
#include <QObject>

#define SERVER_PORT 42000

class TcpClock : public QObject
{
    Q_OBJECT

public:
    TcpClock(QObject *parent = nullptr);

private:
    QQmlApplicationEngine*  clockAppEngine;
    QQmlContext*            clockAppContext;
    QTcpServer*             clockServer;
    QList<QTcpSocket*>      clockListSocket;
    QList<QObject*>         listTcpLog;
    int portNumber;

public slots:
    void addNewSocket();
    void readDataFromSocket();
    void clientDisconnection();

signals:
    void updateTime(int hour, int minute, int second);

public:
    void setQmlAppEngine(QQmlApplicationEngine *engine);
    void initApplication();
public:
    int getServerPort() const;
};

#endif // TCPCLOCK_H
