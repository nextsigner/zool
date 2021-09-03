import QtQuick 2.0

Item{
    width: 1
    height: xLupa.width
    anchors.centerIn: xLupa
    rotation: -45-(15*apps.lupaRot)
    visible: !xLayerTouch.visible&&apps.lupaMod===2&&apps.showLupa
    Rectangle{
        width: app.fs*0.5
        height: width
        anchors.top: parent.bottom
        color: apps.lupaColor
        MouseArea{
            anchors.fill: parent
            drag.target: xLupa
            drag.axis: Drag.XAndYAxis
        }
        Rectangle{
            width: parent.width*0.5
            height: width
            radius: width*0.5
            anchors.centerIn: parent
            color: apps.lt?'red':'green'
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xLupa.x=xLupa.parent.width*0.5-xLupa.height*0.5
                    xLupa.y=xLupa.parent.height*0.5-xLupa.width*0.5+sweg.verticalOffSet
                    //apps.lt=!apps.lt
                }
            }
        }
        Rectangle{
            width: parent.width*1.5
            height: app.fs*2
            radius: app.fs*0.1
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: apps.lupaColor
            MouseArea{
                anchors.fill: parent
                drag.target: xLupa
                drag.axis: Drag.XAndYAxis
                onDoubleClicked: apps.lupaRot++
            }
        }
    }
}
