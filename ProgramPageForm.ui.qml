import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    property alias programsList: programsList
    property alias rectangle: rectangle

    RowLayout {
        id: rowLayout
        spacing: 7.5
        anchors.fill: parent

        Rectangle {
            id: rectangle
            width: 200
            //width: 200
            //height: 200
            color: "#00000000"
            //Layout.minimumWidth: 0
            border.color: "#0d0000"

            //anchors.rightMargin: 6
            //anchors.leftMargin: 6
            //anchors.bottomMargin: 6
            //anchors.topMargin: 6
            //anchors.fill: parent
            //Layout.rowSpan: 1
            Layout.fillHeight: true
            //clip: false
            border.width: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            ListView {
                id: programsList
                anchors.fill: parent
                clip: false
                spacing: 16
                Layout.rowSpan: 6

                //contentHeight: 200
                Layout.fillHeight: true
                //Layout.fillWidth: false
                model: programModel
                delegate: programDelegate
            }
        }
    }
}
