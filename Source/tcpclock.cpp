#include "tcpclock.h"

TcpClock::TcpClock(QObject* parent) : QObject(parent)
{
    this->portNumber = SERVER_PORT;
}


void TcpClock::setQmlAppEngine(QQmlApplicationEngine *engine)
{
    this->clockAppEngine = engine;
}

void TcpClock::initApplication()
{
    this->clockAppContext = this->clockAppEngine->rootContext();
    const QUrl url(QStringLiteral("qrc:/Resource/main.qml"));
    this->clockAppEngine->load(url);
    if(this->clockAppEngine->rootObjects().isEmpty())
        return;

    this->clockAppContext->setContextProperty("LockServer", this);

    // Set up init log
    this->clockServer = new QTcpServer();
    if(this->clockServer->listen(QHostAddress::Any, SERVER_PORT))
    {
        QObject::connect(clockServer, SIGNAL(newConnection()), this, SLOT(addNewSocket()));
        this->listTcpLog.push_front(new LogTcpServer("Initialize Server " + QString::number(this->clockServer->serverPort()), "Application Server"));
        this->clockAppContext->setContextProperty("logTcp", QVariant::fromValue(this->listTcpLog));
    }
}

void TcpClock::addNewSocket()
{
    while(this->clockServer->hasPendingConnections())
    {
        QTcpSocket* client = this->clockServer->nextPendingConnection();
        this->clockListSocket.append(client);
        QObject::connect(client, SIGNAL(readyRead()), this, SLOT(readDataFromSocket()));
        QObject::connect(client, SIGNAL(disconnected()), this, SLOT(clientDisconnection()));
        QString descriptorClientSocket = QString::number(client->socketDescriptor());
        QString dir = QString(descriptorClientSocket) + " --> Application Server";
        QString content = "Connection";
        this->listTcpLog.push_front(new LogTcpServer(content, dir));
        this->clockAppContext->setContextProperty("logTcp", QVariant::fromValue(this->listTcpLog));
    }
}

void TcpClock::readDataFromSocket()
{
    QTcpSocket* socket = reinterpret_cast<QTcpSocket*> (sender());
    QByteArray messageFromClient = socket->readAll();
    qDebug() << messageFromClient;
    QString timeStr(messageFromClient);
    QString content;

    // convert string to QTime
    QTime time = QTime::fromString(timeStr, "hh:mm:ss");

    if (time.isValid()) {
        // hour, minute, second
        int hour = time.hour();
        int minute = time.minute();
        int second = time.second();
        content = "m\'" + QString::fromStdString(messageFromClient.toStdString()) + "\'";
        QString dir = QString::number(socket->socketDescriptor()) + " --> Application Server";
        this->listTcpLog.push_front(new LogTcpServer(content, dir));
        this->clockAppContext->setContextProperty("logTcp", QVariant::fromValue(this->listTcpLog));
        // emit signal to update time in qml
        emit updateTime(hour, minute, second);
    } else {
        qDebug() << "Invalid time format.";
    }
}

int TcpClock::getServerPort() const
{
    return this->portNumber;
}

void TcpClock::clientDisconnection()
{
    QTcpSocket *clientSocket = qobject_cast<QTcpSocket *>(sender());
    if (clientSocket && clientSocket->isValid())
    {
        QString content = "Close to " + QString::number(this->clockServer->serverPort());
        QString dir = QString::number(clientSocket->socketDescriptor());
        this->listTcpLog.push_front(new LogTcpServer(content, dir));
        this->clockListSocket.removeOne(clientSocket);
        clientSocket->deleteLater(); // Delete the socket on disconnection
        this->clockAppContext->setContextProperty("logTcp", QVariant::fromValue(this->listTcpLog));
    }
}
