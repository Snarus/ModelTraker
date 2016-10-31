import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtPositioning 5.3
import QtLocation 5.6
import QtQuick.Layouts 1.0


ApplicationWindow {
    id: applicationWindow1

    //    Material.theme: Material.Light
    //    Material.primary: Material.BlueGrey
    //    Material.accent: Material.Teal

    visible: true
    width: 640
    height: 480
    color: "#0b1f34"
    title: qsTr("Model Traker")
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            id: page1
            x: 0
            y: 0


            GridLayout {
                id: gridLayout1
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.topMargin: 2
                columns: 3
                rows: 5
                anchors.fill: parent


                TextField {
                    id: textField1
                    text: qsTr("")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.columnSpan: 2
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                }


                Button {
                    id: button1
                    text: qsTr("Scan")
                    checked: false
                    highlighted: false
                    spacing: 0
                    topPadding: 6
                    checkable: true
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.fillWidth: false
                }


                Row {
                    id: row1
                    x: 166
                    y: 34
                    width: 200
                    height: 400
                    Layout.maximumHeight: 25
                    Layout.minimumHeight: 25
                    Layout.preferredHeight: -1
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                }

                ListView {
                    id: devicesList
                    x: 16
                    y: 70
                    width: 192
                    height: 320
                    keyNavigationWraps: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    highlightRangeMode: ListView.NoHighlightRange
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    Layout.rowSpan: 2
                    Layout.columnSpan: 3
                    Layout.preferredHeight: -1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 3
                    model: ServicesModel
                    delegate:
                        MouseArea {
                        height: 35
                        width: parent.width
                        onClicked: { model.selected = !model.selected; }

                        Rectangle {
                            gradient: Gradient {
                                GradientStop {
                                    position: 0
                                    color: "#ffffff"
                                }

                                GradientStop {
                                    position: 0.993
                                    color: "#bddafd"
                                }

                            }
                            anchors.fill: parent;
                        }
                        Text {
                            text: "%1 ".arg (model.name);
                            anchors.leftMargin: 6
                            font.pointSize: 24
                            textFormat: Text.PlainText
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

            }
        }

        Page {
            Map {
                id: mapOfEurope
                copyrightsVisible: false
                anchors.centerIn: parent;
                anchors.fill: parent
                plugin: Plugin {
                    name: "mapbox"
                    locales: "ru_RU"
                    //name: "here"
                    //name:"osm"
                    //PluginParameter { name: "osm.key"; value: "dmlus6CpNPDJbQQEQ2PdgUkKbKhTz8Hw" }
                    //PluginParameter { name: "osm.secret"; value: "36Hb0MXOhC4hF9jZ" }
                    PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1Ijoic25hcnVzIiwiYSI6ImNpczFpNDdkdzAwNm4yc3MyODRiand6YzkifQ.1-PjqVw8fu0Gava8lBHsSQ" }
                    PluginParameter { name: "mapbox.map_id"; value: "mapbox//styles/mapbox/streets-v9" }
                    //PluginParameter { name: "#country_label"; value: "name_ru" }
                    //PluginParameter { name: "osm.token"; value: "pk.eyJ1Ijoic25hcnVzIiwiYSI6ImNpczFpNDdkdzAwNm4yc3MyODRiand6YzkifQ.1-PjqVw8fu0Gava8lBHsSQ" }
                    //PluginParameter { name: "here.app_id"; value: "NHL0mSGzKN9GHrujpztb" }
                    //PluginParameter { name: "here.token"; value: "utIUBPBSYsRTRJc1POnwUw" }
                    //preferred: ["here", "osm"]
                    //required: Plugin.AnyMappingFeatures | Plugin.AnyGeocodingFeatures
                }

                Plane{
                    id:qmlPlane
                    coordinate: plane.position
                    property real rotationDirection: plane.direction;
                    RotationAnimation{
                        id: planeAnimation
                        direction: RotationAnimation.Shortest
                        //running: true
                        target: qmlPlane;property: "bearing";duration:1000
                        easing.type: Easing.InOutQuad
                        to: qmlPlane.rotationDirection
                    }
                    Connections{
                        target: plane
                        onMessageReceived:qmlPlane.showSignal()
                    }

                    onCoordinateChanged: {
                        qmlPlane.rotationDirection=plane.direction
                        qmlBase.showMessage(coordinate.distanceTo(qmlBase.coordinate))
                        planeAnimation.start()
                        //qmlPlane.showSignal()
                    }
                }

                Base{
                    id:qmlBase

                    property real rotationDirection: 0;
                    RotationAnimation{
                        id: baseAnimation
                        direction: RotationAnimation.Shortest
                        //running: true
                        target: qmlBase;property: "bearing";duration:1000
                        easing.type: Easing.InOutQuad
                        to: qmlBase.rotationDirection
                    }
                    PositionSource{
                        active: true
                        updateInterval: 1000
                        onPositionChanged: {
                            qmlBase.coordinate=position.coordinate
                            mapOfEurope.center=position.coordinate
                            qmlBase.showMessage(position.coordinate.distanceTo(qmlPlane.coordinate))
                            if(position.directionValid){
                                //mapOfEurope.rotation=position.direction
                                qmlBase.rotationDirection=position.direction
                                baseAnimation.start()
                            }
                        }
                    }

                }

            }
        }
    }

    footer:TabBar {
        id: tabBar
//        y: 440
//        height: 40
//        anchors.right: parent.right
//        anchors.rightMargin: 0
//        anchors.left: parent.left
//        anchors.leftMargin: 0
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 0
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Bluetooth")
        }
        TabButton {
            text: qsTr("Map")
        }
        TabButton {
            text: qsTr("Model")
        }
    }
}
