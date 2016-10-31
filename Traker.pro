QT += qml quick bluetooth positioning

CONFIG += c++11

SOURCES += main.cpp \
    bluetoothclient.cpp \
    bluetoothpositioninfosource.cpp \
    bluetoothdataobject.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    Plane.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    bluetoothclient.h \
    bluetoothpositioninfosource.h \
    bluetoothdataobject.h

include ($$PWD/libQtQmlTricks/SuperMacros/QtSuperMacros.pri)
include ($$PWD/libQtQmlTricks/SmartDataModels/QtQmlModels.pri)

