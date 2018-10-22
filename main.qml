import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtPositioning 5.11
import QtLocation 5.11
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: applicationWindow

    //    Material.theme: Material.Light
    //    Material.primary: Material.BlueGrey
    //    Material.accent: Material.Teal

    visible: true
    width: 640
    height: 480
    //color: "#0b1f34"
    title: qsTr("Model Traker")
    StackLayout {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            id: bluetoothDevices
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
            id:mapPage
//            Map {
//                plugin: Plugin { name: "mapboxgl" }

//                center: QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
//                zoomLevel: 12

//                MapParameter {
//                    type: "source"

//                    property var name: "routeSource"
//                    property var sourceType: "geojson"
//                    property var data: '{ "type": "FeatureCollection", "features": \
//                        [{ "type": "Feature", "properties": {}, "geometry": { \
//                        "type": "LineString", "coordinates": [[ 24.934938848018646, \
//                        60.16830257086771 ], [ 24.943315386772156, 60.16227776476442 ]]}}]}'
//                }

//                MapParameter {
//                    type: "layer"

//                    property var name: "route"
//                    property var layerType: "line"
//                    property var source: "routeSource"

//                    // Draw under the first road label layer
//                    // of the mapbox-streets style.
//                    property var before: "road-label-small"
//                }

//                MapParameter {
//                    type: "paint"

//                    property var layer: "route"
//                    property var lineColor: "blue"
//                    property var lineWidth: 8.0
//                }

//                MapParameter {
//                    type: "layout"

//                    property var layer: "route"
//                    property var lineJoin: "round"
//                    property var lineCap: "round"
//                }
//            }
            Map {
                id: mapOfEurope
                copyrightsVisible: false
                anchors.centerIn: parent;
                anchors.fill: parent
                plugin: Plugin {
                    //name: "mapbox"
                    //locales: "ru_RU"
                    //name: "here"
                    name:"osm"
                    PluginParameter {name: "osm.mapping.host";value: "http://osm.tile.openstreetmap.org/"}
                    PluginParameter { name: "osm.mapping.host"; value: "http://osm.tile.server.address/" }
                    PluginParameter { name: "osm.mapping.copyright"; value: "All mine" }
                    PluginParameter { name: "osm.routing.host"; value: "http://osrm.server.address/viaroute" }
                    PluginParameter { name: "osm.geocoding.host"; value: "http://geocoding.server.address" }
                    //PluginParameter { name: "osm.key"; value: "dmlus6CpNPDJbQQEQ2PdgUkKbKhTz8Hw" }
                    //PluginParameter { name: "osm.secret"; value: "36Hb0MXOhC4hF9jZ" }
                    //PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1Ijoic25hcnVzIiwiYSI6ImNpczFpNDdkdzAwNm4yc3MyODRiand6YzkifQ.1-PjqVw8fu0Gava8lBHsSQ" }
                    //PluginParameter { name: "mapbox.map_id"; value: "mapbox://styles/snarus/ciugjonpu00jj2ipsbyl445hj" }
                    //PluginParameter { name: "#country_label"; value: "name_ru" }
                    //PluginParameter { name: "osm.token"; value: "pk.eyJ1Ijoic25hcnVzIiwiYSI6ImNpczFpNDdkdzAwNm4yc3MyODRiand6YzkifQ.1-PjqVw8fu0Gava8lBHsSQ" }
                    //PluginParameter { name: "here.app_id"; value: "NHL0mSGzKN9GHrujpztb" }
                    //PluginParameter { name: "here.token"; value: "utIUBPBSYsRTRJc1POnwUw" }
                    //preferred: ["here", "osm"]
                    //required: Plugin.AnyMappingFeatures | Plugin.AnyGeocodingFeatures
                }
                //activeMapType: mapOfEurope.supportedMapTypes[7]
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
                        mapOfEurope.fitViewportToMapItems()
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
                            mapOfEurope.fitViewportToMapItems()
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
        ProgramPage{
            id:modelPage
        }
    }

    footer:TabBar {
        id: tabBar
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
