import QtQuick 2.12
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: sweg.objSignsCircle.width*0.5
    height: width
    anchors.centerIn: parent
    parent: sweg
    visible: false
    property string moduleName: 'Contexto de Nacimiento'
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
            id: horizonteBg
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
    Component{
        id: comp
        Rectangle{
            id: xPanel
            width: panelZoolModules.width-app.fs*0.25
            height: col.height+app.fs
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.25
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            property bool showPanel: false
            Behavior on height{
                NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}
            }
            Column{
                id: col
                anchors.centerIn: parent
                Rectangle{
                    width: xPanel.width-app.fs*0.5
                    height: app.fs*1.5
                    color: apps.fontColor
                    radius: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xPanel.showPanel=!xPanel.showPanel
                    }
                    Text{
                        text: r.moduleName
                        font.pixelSize: app.fs
                        color: 'black'//apps.backgroundColor
                        anchors.centerIn: parent
                        opacity: t1.running?0.0:1.0
                        Behavior on opacity{
                            NumberAnimation{duration: 250}
                        }
                        Timer{
                            id: t1
                            running: parent.contentWidth>parent.parent.width-app.fs
                            repeat: true
                            interval: 100
                            onTriggered: parent.font.pixelSize-=1
                        }
                    }
                }
                Rectangle{
                    visible: xPanel.showPanel
                    width: parent.width
                    height: btn1.height+app.fs*0.5
                    color: apps.backgroundColor
                    Button{
                        id: btn1
                        text: r.visible?'Ocultar':'Mostrar'
                        anchors.centerIn: parent
                        onClicked: r.visible=!r.visible
                    }
                }
            }


            //            Rectangle{
//                width: parent.width
//                height: app.fs*1.5
//                color: apps.fontColor
//                Text{
//                    text: r.moduleName
//                    font.pixelSize: app.fs
//                    color: apps.backgroundColor
//                    anchors.centerIn: parent
//                    Timer{
//                        id: t1
//                        running: parent.contentWidth>parent.parent.width-app.fs
//                        repeat: true
//                        interval: 100
//                        onTriggered: parent.font.pixelSize-=1
//                    }
//                }

//            }


        }
    }
    Timer{
        id: tCheck
        running: r.visible
        repeat: true
        interval: 1000
        onTriggered: {
            let json=app.currentJson
            //log.ls('json: '+JSON.stringify(json.pc.c0), 0, xLatIzq.width)
            let ih=parseInt(json.pc.c0.ih)
            if(ih===12||ih===7){
                horizonteBg.posSol=0
            }else if(ih===1||ih===2||ih===3||ih===4||ih===5||ih===6){
                horizonteBg.posSol=3
                //horizonteBg.opacity-=0.05
            }else if(ih===8||ih===9||ih===11){
                horizonteBg.posSol=4
            }else{
                //horizonteBg.posSol=1
            }
            //log.ls('json: '+ih, 0, xLatIzq.width)
            //log.ls('horizonteBg.posSol: '+horizonteBg.posSol, 0, xLatIzq.width)
        }
    }
    Component.onCompleted: {
        let obj=comp.createObject(panelZoolModules.c, {})
    }
}
