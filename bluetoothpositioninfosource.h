#ifndef BLUETOOTHPOSITIONINFOSOURCE_H
#define BLUETOOTHPOSITIONINFOSOURCE_H
#include <QNmeaPositionInfoSource>

class BluetoothPositionInfoSource : public QNmeaPositionInfoSource
{
public:
    BluetoothPositionInfoSource(UpdateMode updateMode, QObject *parent = Q_NULLPTR);
    bool parsePosInfoFromNmeaData(const char *data, int size, QGeoPositionInfo *posInfo, bool *hasFix);
};

#endif // BLUETOOTHPOSITIONINFOSOURCE_H
