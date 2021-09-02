import QtQuick 2.0

Item{
    id: lineasGrados
    width: signCircle.width
    height: width
    anchors.centerIn: parent
    rotation: signCircle.rot
    Repeater{
        model: 360
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.25
                height: 1
                //y:0-1
                color: 'white'
                antialiasing: true
            }
        }
    }
    Repeater{
        model: 36
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.35
                height: 3
                y:-1
                color: 'white'
                antialiasing: true
            }
        }
    }
    Repeater{
        model: 36
        Item{
            width: parent.width-signCircle.w
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*0.35
                height: width
                x:sweg.fs*0.25
                y:0-width*0.5
                radius: width*0.5
                color: 'white'
                Text{text: 360-(index*10)===360?0:360-(index*10);font.pixelSize: parent.width*0.6;anchors.centerIn: parent}
            }
        }
    }
}
