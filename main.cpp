#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "bluetoothclient.h"

//#include "bluetoothdataobject.h"


int main(int argc, char *argv[])
{
    BluetoothClient client;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("plane", &client);
    engine.rootContext()->setContextProperty("ServicesModel", &client.dataList);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
