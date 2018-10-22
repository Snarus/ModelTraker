import QtQuick 2.4
import QtLocation 5.6

MapQuickItem{
    id:plane
    property int bearing: 0;
    anchorPoint.x: image.width/2
    anchorPoint.y: image.height/2
    sourceItem: Row{
        spacing:3
        Image{
            id:image
            source:"airplane.png"
            rotation: bearing
            Rectangle{
                id:banner
                x: 16
                y: 16
                width: 16
                height: 16
                border.width: 1
                radius:8
                color: "red"
                ColorAnimation  on color {
                    id: bannerAnimation
                    from: "yellow"
                    to: "red"
                    duration: 3000
                }

            }
        }

    }
    function showSignal(){
        bannerAnimation.start()
    }
}
