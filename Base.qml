import QtQuick 2.4
import QtLocation 5.6

MapQuickItem{
    id:base
    property int bearing: 0;
    anchorPoint.x: image.width/2
    anchorPoint.y: image.height/2
    sourceItem: Row{
        id: row1
        //width: 65
        //height: 21
        //anchors.left: parent.left
        //anchors.leftMargin: 0
        //columns: 2
        spacing:3
        //        horizontalItemAlignment: Grid.AlignHCenter

        Image{
            id:image
            source:"arrow.png"
            rotation: bearing
        }

        Rectangle {
            id: banner
            property int distance: 0
            color: "lightblue"
            border.width: 1
            radius: 5
            width: text.width * 1.3
            height: text.height * 1.3
            Text {
                id: text
                anchors.centerIn: parent
                text: banner.distance ? banner.distance: ""
            }
        }
    }

    function showMessage(message) {
        banner.distance = message
        //playMessage.start()
        //! [PlaneMapQuick2]
    }
}
