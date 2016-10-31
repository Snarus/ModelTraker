#include "bluetoothpositioninfosource.h"

BluetoothPositionInfoSource::BluetoothPositionInfoSource(UpdateMode updateMode, QObject *parent)
    :QNmeaPositionInfoSource(updateMode,parent)
{

}

bool BluetoothPositionInfoSource::parsePosInfoFromNmeaData(const char *data, int size, QGeoPositionInfo *posInfo, bool *hasFix)
{
    return QNmeaPositionInfoSource::parsePosInfoFromNmeaData(data,size,posInfo,hasFix);
}
