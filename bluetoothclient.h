#ifndef BLUETOOTHCLIENT_H
#define BLUETOOTHCLIENT_H

#include <QObject>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothLocalDevice>
#include <QBluetoothServiceDiscoveryAgent>
#include <QBluetoothSocket>
#include <QDebug>
#include "bluetoothpositioninfosource.h"
#include "bluetoothdataobject.h"

#include "QtQmlTricksPlugin_SmartDataModels.h"
#include "QQmlObjectListModel.h"

class BluetoothClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoCoordinate position READ position NOTIFY positionChanged)
    Q_PROPERTY(float direction READ direction NOTIFY directionChanged)
public:
    explicit BluetoothClient(QObject *parent = 0);
    ~BluetoothClient();
    QGeoCoordinate position() const;
    float direction();
    QQmlObjectListModel<BluetoothDataObject>dataList;
signals:
    void positionChanged();
    void directionChanged();
    void messageReceived();
public slots:
private slots:
    void on_deviceDiscovered(QBluetoothDeviceInfo device);
    void on_serviceDiscovered(QBluetoothServiceInfo service);
    void on_deviceDiscoveryError(QBluetoothDeviceDiscoveryAgent::Error error);
    void readSocket();
    void connected();
    void disconnected();
private:
    QBluetoothServiceDiscoveryAgent *m_discoveryAgent;
    QVector<QBluetoothDeviceInfo>discoveredDevices;
    QVector<QBluetoothServiceInfo>discoveredServices;
    QBluetoothSocket *m_socket=NULL;
    QBluetoothAddress localAddress;
    QBluetoothLocalDevice *localDevice;
    QGeoCoordinate coordinate;
    float m_direction;
};

#endif // BLUETOOTHCLIENT_H
