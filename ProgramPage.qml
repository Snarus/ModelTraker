import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

ProgramPageForm {
    ListModel{
        id:programModel
        ListElement{
            name:"Program 1"
            time:0
        }
        ListElement{
            name:"Program 2"
            time:1.1
        }
        ListElement{
            name:"Program 3"
            time:2.0
        }
        ListElement{
            name:"Program 4"
            time:3.0
        }
        ListElement{
            name:"Program 5"
            time:4.0
        }
        ListElement{
            name:"Program 6"
            time:5.0
        }
    }
   Component{
        id: programDelegate
        Rectangle{
            id: rectangle
            x: 12
            y: 4
            width: 300
            height: 40
            //color: "#36ff05"
            //width: 418
            radius: 4
            //anchors.left: parent.left
            //anchors.leftMargin: 0
            //anchors.top: parent.top
            //anchors.topMargin: 0
            //anchors.fill: parent
            border.width: 3
            border.color: "#36ff05"
            Label{
                id:label
                x: 20
                y: -2
                text: name
                anchors.left: parent.left
                anchors.leftMargin: 8
                font.bold: true
                font.pointSize: 24
                anchors.verticalCenter: parent.verticalCenter
                //color: "lightgreen"
            }

            Text{
                id:timeValue
                width: 64
                text: time+" S"
                anchors.left: label.right
                anchors.leftMargin: 53
                font.bold: true
                font.pointSize: 24
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: label.verticalCenter
                //readOnly: true
                horizontalAlignment: TextInput.AlignHCenter
                //color: "lightgreen"
            }
        }


    }
}
