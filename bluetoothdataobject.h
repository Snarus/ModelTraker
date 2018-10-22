#ifndef BLUETOOTHDATAOBJECT_H
#define BLUETOOTHDATAOBJECT_H

#include <QObject>
#include <QString>
#include <QBluetoothServiceDiscoveryAgent>
#include "QQmlVarPropertyHelpers.h"
#include "QQmlConstRefPropertyHelpers.h"
#include "QQmlAutoPropertyHelpers.h"
class BluetoothDataObject : public QObject
{
    Q_OBJECT
    QML_READONLY_VAR_PROPERTY(QString, name)



public:
    BluetoothDataObject(QObject *parent = nullptr,QBluetoothServiceInfo *service=nullptr)
        :QObject(parent)
    {
        if(service)
            m_name=service->device().name();
        else
            m_name="";
    }
    BluetoothDataObject(QObject *parent = nullptr,QBluetoothDeviceInfo *deviceInfo=nullptr)
        :QObject(parent)
    {
        if(deviceInfo){
            m_name=deviceInfo->name();
            m_deviceInfo=deviceInfo;
        }
    }


signals:

public slots:
private:
    QBluetoothDeviceInfo *m_deviceInfo;
};

#endif // BLUETOOTHDATAOBJECT_H
