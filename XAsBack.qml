import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: r
    //width: !selected?(planetsCircle.expand?parent.width-(r.fs*2*objData.p)-r.fs:parent.width-(r.fs*1.5*objData.p))-r.fs:parent.width//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    width: (signCircle.width+sweg.fs*0.25)+(r.fs*2*objData.p)+sweg.fs*2
    height: 1
    anchors.centerIn: parent
    //z: !selected?numAstro:15
    property bool selected: numAstro === app.currentPlanetIndexBack
    property string astro
    property int is
    property int fs:planetsCircleBack.planetSize
    property var objData: ({g:0, m:0,ih:0,rsgdeg:0,rsg:0})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: 0

    property color colorCuerpo: '#ff3300'

//    state: sweg.state
//    states: [
//        State {
//            name: sweg.aStates[0]
//            PropertyChanges {
//                target: r
//                colorCuerpo: '#ffffff'
//            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.85
//            }
//        },
//        State {
//            name: sweg.aStates[1]
//            PropertyChanges {
//                target: r
//                colorCuerpo: '#000000'
//            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.5
//            }
//        },
//        State {
//            name: sweg.aStates[2]
//            PropertyChanges {
//                target: r
//                colorCuerpo: '#ffffff'
//            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fcs*0.5
//            }
//        }
//    ]

//    onWidthChanged: {
//        //        if(r.width===r.parent.width-sweg.fs*2){
//        //            r.opacity=1.0
//        //        }else{
//        //            r.opacity=0.5
//        //        }
//    }
//    onSelectedChanged: {
//        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
//        if(selected)housesCircle.currentHouse=objData.ih
//    }
    //Probando/Visualizando rotación
    Rectangle{
        width: r.width
        height: apps.widthHousesAxis
        anchors.centerIn: parent
        //color: apps.fontColor
        //visible: apps.showHousesAxis
        //y: lineaEje2.y
        visible: false
        color: 'yellow'
        antialiasing: true
    }
    Rectangle{
        width: (r.width-signCircle.width)*0.5+signCircle.w*0.5//+r.fs*0.25//r.fs+r.fs*objData.p-1
        height: 1//apps.widthHousesAxis
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0//-r.fs*0.25
        //anchors.centerIn: parent
        color: apps.fontColor
        antialiasing: true
        Canvas {
            id:canvasSen
            width: sweg.fs*0.2
            height: width
            //rotation: 180
            anchors.verticalCenter: parent.verticalCenter
            //anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 0-width
            antialiasing: true
            onPaint:{
                var ctx = canvasSen.getContext('2d');
                ctx.beginPath();
                ctx.moveTo(0, canvasSen.width*0.5);
                ctx.lineTo(canvasSen.width, 0);
                ctx.lineTo(canvasSen.width, canvasSen.width);
                ctx.lineTo(0, canvasSen.width*0.5);
                ctx.strokeStyle = canvasSen.parent.color
                ctx.lineWidth = 1;
                ctx.fillStyle = canvasSen.parent.color
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    Item{
        id: xIcon
        width: r.fs*0.85
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 0-xIconPlanetSmall.width
        //anchors.leftMargin: !r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        Rectangle{
            //Circulo que queda mostrando el cuerpo chico.
            id: xIconPlanetSmall
            width: parent.width+sweg.fs*0.1
            height: width
            anchors.centerIn: parent
            radius: width*0.5
            border.width: 0
            border.color: apps.backgroundColor
            opacity: apps.xAsBackgroundOpacityBack
            color: apps.xAsBackgroundColorBack
            antialiasing: true
        }
        MouseArea{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                vClick=0
                r.parent.cAs=r
            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                vClick++
                tClick.restart()
                //r.parent.pressed(r)
            }
            onDoubleClicked: {
                tClick.stop()
                r.parent.doublePressed(r)
            }
            Timer{
                id: tClick
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Image {
            id: img0
            source: img.source
            width: parent.width*0.9
            height: width
            rotation: 0-parent.parent.rotation
            antialiasing: true
            anchors.centerIn: parent
            visible: false
        }
        Image {
            id: img
            source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
            //width: r.parent.parent.objectName==='sweg'?!r.selected?parent.width:parent.width*2:!r.selected?parent.width:parent.width*1.25
            width: parent.width*0.5
            height: width
            anchors.centerIn: parent
            x:!r.selected?0:r.parent.width*0.5-img.width*0.5//+sweg.fs*2
            y: (parent.width-width)/2
            rotation: 0-parent.parent.rotation
            antialiasing: true
            visible: false
            Behavior on width {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on x {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }
        }
        ColorOverlay {
            id: co
            anchors.fill: img
            source: img
            color: 'red'
            rotation: img.rotation
            visible: r.selected
            antialiasing: true
//            SequentialAnimation{
//                running: !r.selected//!apps.anColorXAs
//                loops: 3//Animation.Infinite
//                PropertyAnimation {
//                    target: co0
//                    properties: "color"
//                    from: co0.color
//                    to: apps.xAsColorBack
//                    duration: 500
//                }
//            }
//            SequentialAnimation{
//                running: r.selected//apps.anColorXAs
//                loops: Animation.Infinite
//                PropertyAnimation {
//                    target: co0
//                    properties: "color"
//                    from: 'red'
//                    to: 'white'
//                    duration: 500
//                }
//                PropertyAnimation {
//                    target: co0
//                    properties: "color"
//                    from: 'red'
//                    to: 'red'
//                    duration: 500
//                }
//            }
        }
        ColorOverlay {
            id: co1
            anchors.fill: img0
            source: img0
            color: apps.backgroundColor
            rotation: img.rotation
            //visible: r.selected
            antialiasing: true
            SequentialAnimation{
                running: !r.selected//!apps.anColorXAs
                loops: 3//Animation.Infinite
                PropertyAnimation {
                    target: co1
                    properties: "color"
                    from: co1.color
                    to: apps.xAsColorBack
                    duration: 500
                }
            }
            SequentialAnimation{
                running: r.selected//apps.anColorXAs
                loops: Animation.Infinite
                PropertyAnimation {
                    target: co1
                    properties: "color"
                    from: 'red'
                    to: 'white'
                    duration: 500
                }
                PropertyAnimation {
                    target: co1
                    properties: "color"
                    from: 'red'
                    to: 'red'
                    duration: 500
                }
            }
        }
    }
}
