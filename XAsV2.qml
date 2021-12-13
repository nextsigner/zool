import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: r
    //width: !selected?(planetsCircle.expand?parent.width-(r.fs*2*objData.p)-r.fs:parent.width-(r.fs*1.5*objData.p))-r.fs:parent.width//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    //width: !selected?parent.width-(r.fs*1.5*objData.p)-r.fs-(!apps.showNumberLines?0:r.fs):parent.width-(!apps.showNumberLines?0:r.fs)//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    width: parent.width-(r.fs*1.5*objData.p)-r.fs-(!apps.showNumberLines?0:r.fs)
    height: 1
    anchors.centerIn: parent
    z: !selected?numAstro:15
    property bool selected: numAstro === app.currentPlanetIndex//panelDataBodies.currentIndex
    property string astro
    property int is
    property int fs
    property var objData: ({g:0, m:0,ih:0,rsgdeg:0,rsg:0, retro:0})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: 0

    property color colorCuerpo: '#ff3300'

    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.85
//            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                colorCuerpo: '#000000'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.5
//            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
//            PropertyChanges {
//                target: xIcon
//                width: r.fs*0.5
//            }
        }
    ]
    onSelectedChanged: {
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected)housesCircle.currentHouse=objData.ih
    }


    Rectangle{
        id: xIcon
        //width: !selected?r.fs*0.85:r.fs*1.4
        width: r.fs*0.85
        height: width
        anchors.left: parent.left
        //anchors.leftMargin: !r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        color: r.selected?apps.backgroundColor:'transparent'
        radius: width*0.5
        PointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: img.rotation
            p: r.numAstro
            opacity: r.selected?1.0:0.0
            //anchors.centerIn: xIcon
            //z:co1.z+1
        }
        MouseArea{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons;
            hoverEnabled: true
            onWheel: {
                //apps.enableFullAnimation=false
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y>=0){
                            pointerPlanet.pointerRot+=5
                    }else{
                            pointerPlanet.pointerRot-=5
                    }
                }else{
                    if(wheel.angleDelta.y>=0){
    //                    if(reSizeAppsFs.fs<app.fs*2){
    //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
    //                    }else{
    //                        reSizeAppsFs.fs=app.fs
    //                    }
                        pointerPlanet.pointerRot+=45
                    }else{
    //                    if(reSizeAppsFs.fs>app.fs){
    //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
    //                    }else{
    //                        reSizeAppsFs.fs=app.fs*2
    //                    }
                        pointerPlanet.pointerRot-=45
                    }
                }
                //reSizeAppsFs.restart()
            }
            onEntered: {
                vClick=0
                r.parent.cAs=r
            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.popup()
                } else if (mouse.button === Qt.LeftButton) {
                    vClick++
                    tClick.restart()
                }
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
            id: img
            source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
            //width: r.parent.parent.objectName==='sweg'?!r.selected?parent.width:parent.width*2:!r.selected?parent.width:parent.width*1.25
            width: parent.width*0.8
            height: width
            //x:!r.selected?0:r.parent.width*0.5-img.width*0.5-(apps.showNumberLines?sweg.fs*0.5:0)//+sweg.fs*2
            //y: (parent.width-width)/2
            rotation: 0-parent.parent.rotation
            antialiasing: true
            anchors.centerIn: parent
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
            id: co1
            anchors.fill: img
            source: img
            color: r.selected?apps.fontColor:apps.xAsColor
            rotation: img.rotation
            antialiasing: true
        }

    }
}
