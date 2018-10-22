#include "bluetoothclient.h"

BluetoothClient::BluetoothClient(QObject *parent) : QObject(parent)
{
    localAddress=QBluetoothLocalDevice::allDevices().first().address();
    m_discoveryAgent=new QBluetoothServiceDiscoveryAgent(this);
    connect(m_discoveryAgent,SIGNAL(serviceDiscovered(QBluetoothServiceInfo)),
            this,SLOT(on_serviceDiscovered(QBluetoothServiceInfo)));

    m_discoveryAgent->start(QBluetoothServiceDiscoveryAgent::FullDiscovery);
    QBluetoothDeviceDiscoveryAgent *discoveryAgent=new QBluetoothDeviceDiscoveryAgent(localAddress,this);
    connect(discoveryAgent,SIGNAL(deviceDiscovered(QBluetoothDeviceInfo)),
            this,SLOT(on_deviceDiscovered(QBluetoothDeviceInfo)));

    discoveryAgent->start();
    //connect(&timer,&QTimer::timeout,this,&BluetoothClient::on_timer);
    //timer.start(1000);

}

BluetoothClient::~BluetoothClient()
{
    if(m_socket)
        delete m_socket;
    m_socket=nullptr;
    delete m_discoveryAgent;
}

QGeoCoordinate BluetoothClient::position() const
{
    return coordinate;
}

float BluetoothClient::direction()
{
    return m_direction;
}

void BluetoothClient::on_deviceDiscovered(QBluetoothDeviceInfo device)
{
    if(!discoveredDevices.contains(device)){
        if(device.isCached())
            return;
        if(!device.isValid())
            return;
//        if(device.rssi()==0)
//            return;
        discoveredDevices.append(device);
        //qDebug()<<"protocol uuid"<<device.deviceUuid().toString();
        qDebug()<<"discovered device"<<device.name()<<"("<<device.address().toString()<<")";
        qDebug()<<"rssi"<<device.rssi();
        BluetoothDataObject *object=new BluetoothDataObject(this,&device);
        dataList.append(object);
        if(m_socket)
            return;
        m_socket=new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol);
        qDebug()<<"create socket";
        connect(m_socket,SIGNAL(error(QBluetoothSocket::SocketError)),this,SLOT(onError()));
        connect(m_socket,SIGNAL(readyRead()),this,SLOT(readSocket()));
        connect(m_socket,SIGNAL(connected()),this,SLOT(connected()));
        connect(m_socket,SIGNAL(disconnected()),this,SLOT(disconnected()));
        m_socket->connectToService(device.address(),device.deviceUuid());
    }
}

void BluetoothClient::on_serviceDiscovered(QBluetoothServiceInfo service)
{
    if(service.socketProtocol()==QBluetoothServiceInfo::RfcommProtocol){
        BluetoothDataObject *object=new BluetoothDataObject(this,&service);
        dataList.append(object);
        qDebug()<<"discovered service"<<service.device().name();
        if(m_socket)
            return;
        m_socket=new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol);
        qDebug()<<"create socket";
        connect(m_socket,SIGNAL(error()),this,SLOT(onError()));
        connect(m_socket,SIGNAL(readyRead()),this,SLOT(readSocket()));
        connect(m_socket,SIGNAL(connected()),this,SLOT(connected()));
        connect(m_socket,SIGNAL(disconnected()),this,SLOT(disconnected()));
        m_socket->connectToService(service);
    }
}

void BluetoothClient::on_deviceDiscoveryError(QBluetoothDeviceDiscoveryAgent::Error error)
{
    qDebug()<<"error with discovery device:"<<error;
}

void BluetoothClient::readSocket()
{
    while(m_socket->canReadLine()){
        QByteArray line=m_socket->readLine();
        //qDebug()<<line;
        qDebug()<<"received data"<<line;
        QGeoPositionInfo info;
        bool fix;
        BluetoothPositionInfoSource source(QNmeaPositionInfoSource::RealTimeMode);
        if(source.parsePosInfoFromNmeaData(line,line.size(),&info,&fix)){
            if(info.isValid()){
                qDebug()<<"direction:"<<info.attribute(QGeoPositionInfo::Direction);
                qDebug()<<"ground speed:"<<info.attribute(QGeoPositionInfo::GroundSpeed);
                qDebug()<<"vertical speed:"<<info.attribute(QGeoPositionInfo::VerticalSpeed);
                qDebug()<<"hor accuracy:"<<info.attribute(QGeoPositionInfo::HorizontalAccuracy);
                qDebug()<<"vert accuracy:"<<info.attribute(QGeoPositionInfo::VerticalAccuracy);
                if(!qIsNaN(info.attribute(QGeoPositionInfo::Direction))){
                    m_direction=info.attribute(QGeoPositionInfo::Direction);
                    emit directionChanged();
                }
                coordinate=info.coordinate();
                emit positionChanged();
                qDebug()<<"coords:"<<info.coordinate().toString();
                //qDebug()<<"hor accuracy:"<<info.attribute(QGeoPositionInfo::HorizontalAccuracy);
                //qDebug()<<"ver accuracy:"<<info.attribute(QGeoPositionInfo::VerticalAccuracy);
            }
        }
    }
    emit messageReceived();
}

void BluetoothClient::connected()
{
    qDebug()<<"connected"<<m_socket->peerName();
}

void BluetoothClient::disconnected()
{
    qDebug()<<"disconnected";
}

void BluetoothClient::onError()
{
    if(m_socket!=nullptr)
        qDebug()<<"error"<<m_socket->errorString();
    else
        qDebug()<<"error without socket";
}

void BluetoothClient::on_timer()
{
    const QByteArray line="$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A";

    //QByteArray line=m_socket->readLine();
    //qDebug()<<line;
    qDebug()<<"received data"<<line;
    QGeoPositionInfo info;
    bool fix;
    BluetoothPositionInfoSource source(QNmeaPositionInfoSource::RealTimeMode);
    if(source.parsePosInfoFromNmeaData(line,line.size(),&info,&fix)){
        if(info.isValid()){
            qDebug()<<"direction:"<<info.attribute(QGeoPositionInfo::Direction);
            qDebug()<<"ground speed:"<<info.attribute(QGeoPositionInfo::GroundSpeed);
            qDebug()<<"vertical speed:"<<info.attribute(QGeoPositionInfo::VerticalSpeed);
            qDebug()<<"hor accuracy:"<<info.attribute(QGeoPositionInfo::HorizontalAccuracy);
            qDebug()<<"vert accuracy:"<<info.attribute(QGeoPositionInfo::VerticalAccuracy);
            if(!qIsNaN(info.attribute(QGeoPositionInfo::Direction))){
                m_direction=info.attribute(QGeoPositionInfo::Direction);
                emit directionChanged();
            }
            coordinate=info.coordinate();
            emit positionChanged();
            qDebug()<<"coords:"<<info.coordinate().toString();
            //qDebug()<<"hor accuracy:"<<info.attribute(QGeoPositionInfo::HorizontalAccuracy);
            //qDebug()<<"ver accuracy:"<<info.attribute(QGeoPositionInfo::VerticalAccuracy);
        }
    }

}
