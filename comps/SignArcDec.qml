import QtQuick 2.0

Item {
    id: r
    width: app.fs*3
    height: 100
    property int gr: parent.rotation
    property int n: -1
    property int w: sweg.w*0.5
    property int wparent: 0
    property color c
    property bool showBorder: false
    //Behavior on w{NumberAnimation{duration: sweg.speedRotation}}
    //onWidthChanged: canvas.requestPaint()
    Rectangle{
        anchors.fill: r
        color: 'transparent'
        border.width: 1
        border.color: 'red'
        radius: width*0.5
        visible: r.showBorder
    }
    Rectangle{
        anchors.fill: r
        color: 'red'
        border.width: 1
        border.color: 'red'
        //radius: width*0.5
        //visible: r.showBorder
    }
    Canvas {
        id:canvas
        width: r.width-r.w*2
        height: width
        //rotation: 0.5
        onPaint:{
            var ctx = canvas.getContext('2d');
            var x = r.width*0.5;
            var y = r.height*0.5;
            var radius=canvas.width*0.5//-r.w*0.5//*2
            //ejeIcon.width=radius*2
            var startAngle = 1.0 * Math.PI;
            var endAngle = 1.056 * Math.PI;
            var counterClockwise = false;
            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, endAngle, counterClockwise);
            ctx.lineWidth = r.w;
            // line color
            ctx.strokeStyle = r.c
            ctx.stroke();
        }
    }
    Rectangle{
        id: ejeIcon
        width: canvas.width//-((r.w-xImg.width)/2)
        height: 8
        anchors.centerIn: r
        color: 'transparent'
        rotation: 5
        antialiasing: true
        //border.width: 2
        //border.color: 'red'
        Item{
            id: xImg
            width: r.w*0.75
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.left
            rotation: 0-r.rotation-5-r.gr//-90
            antialiasing: true
            property bool resaltado: false//panelDataBodies.currentIndexSign === r.n - 1
            Image {
                id: iconoSigno
                source: "../resources/imgs/signos/"+r.n+".svg"
                property int w: xImg.width*0.75
                width: xImg.width//!xImg.resaltado?r.w:r.w*2
                height: width
                anchors.centerIn: parent
                antialiasing: true
            }
        }
    }
}
