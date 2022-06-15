import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: r
    width: sweg.objSignsCircle.width*0.5
    height: width
    //color: 'transparent'
    anchors.centerIn: parent
    parent: sweg
    //clip: true//showAsCircle
    //radius: width*0.5//showAsCircle?width*0.5:0
    property bool showAsCircle: true
    onVisibleChanged: {
        if(visible){
            swe.centerZoomAndPos()
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: r.showAsCircle=!r.showAsCircle
        onDoubleClicked: {
                r.visible=false
        }
    }
    Rectangle{
        id: xCircle
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: !r.showAsCircle
        HorizonteBg{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: img1.bottom
        }
        SubsueloBg{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: img1.bottom
        }
        Image {
            id: img1
            source: "hospital.png"
            width: app.fs*3
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.bottom: parent.verticalCenter
        }
        Image {
            id: img2
            source: "sotano.png"
            width: img1.width
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.top:  img1.bottom
            //anchors.bottomMargin: height
        }
        //Arboles
        Image {
            source: "arbol_1.png"
            width: app.fs*6
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: img1.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*0.35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: img1.width*1.5
        }
        Brujula{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-app.fs*3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*3
        }
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width:  txt2.contentWidth+app.fs
            height: txt2.contentHeight+app.fs
            border.width: 3
            border.color: 'black'
            radius: app.fs*0.5
            Text {
                id: txt2
                text: '<b>Bajo tierra</b>'
                font.pixelSize: app.fs
                anchors.centerIn: parent
            }
        }
    }
    Rectangle{
        id: xCircleMask
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: r.showAsCircle
    }
    OpacityMask {
        anchors.fill: xCircle
        source: xCircle
        maskSource: xCircleMask
        visible: r.showAsCircle
    }
}
