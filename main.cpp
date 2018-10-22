#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "bluetoothclient.h"

//#include "bluetoothdataobject.h"


int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    BluetoothClient client;
    // Exposes the QQuickMapboxGL module so we
    // can do `import QQuickMapboxGL 1.0`.
   // QMapbox::registerTypes();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("plane", &client);
    engine.rootContext()->setContextProperty("ServicesModel", &client.dataList);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
