import QtQuick 2.0
import "../"
import "../../Funcs.js" as JS
Item {
    id: r
    property var aDes: ['dato1', 'dato2', 'dato3', 'dato4', 'dato5', 'dato6', 'dato7', 'dato8', 'dato9']

    property var currentDate
    property int currentNum: 0


    property color borderColor: apps.fontColor
    property int borderWidth: app.fs*0.15
    property int dir: -1
    property int uRot: 0

    property int currentNumKarma: -1
    property int currentNumAnioPersonal: -1

    onCurrentNumAnioPersonalChanged: {
        currentNum=currentNumAnioPersonal-1
    }
    onCurrentDateChanged: {
        //currentNum++
        let aGetNums=JS.getNums('10/2/1999')
        currentNumKarma=aGetNums[0]
    }

    //    onCurrentNumChanged: {
    //        let rot=360/9
    //        rot=parseInt(rot)
    //        if(r.dir===0){
    //            r.uRot=r.uRot+rot//+90
    //        }else{
    //            r.uRot=r.uRot-rot//+90
    //        }
    //        xNums.rotation=r.uRot
    //    }
    Row{
        anchors.centerIn: parent
        Item{
            width: app.fs*10
            height: r.height
            Column{
                spacing: app.fs
                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: '<b>Fecha de Nacimiento</b>'
                        color: 'white'
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ControlsTimeDate{
                        id: controlTimeDateNac
                        anchors.verticalCenter: parent.verticalCenter
                        onCurrentDateChanged: {
                            let d=currentDate.getDate()
                            let m=currentDate.getMonth() + 1
                            let a = currentDate.getFullYear()
                            let sf=''+d+'/'+m+'/'+a
                            let aGetNums=JS.getNums(sf)
                            currentNumKarma=aGetNums[0]
                            let dateP = new Date(controlTimeDate.currentDate.getFullYear(), m - 1, d, 0, 1)
                            controlTimeDate.currentDate=dateP
                        }
                    }
                    Text{
                        text: '<b>N° Karma</b>: '+r.currentNumKarma
                        color: 'white'
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: '<b>Fecha</b>'
                        color: 'white'
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ControlsTimeDate{
                        id: controlTimeDate
                        anchors.verticalCenter: parent.verticalCenter
                        onCurrentDateChanged: {
                            let d = currentDate.getDate()
                            let m = currentDate.getMonth() + 1
                            let a = currentDate.getFullYear()
                            let sf=''+d+'/'+m+'/'+a
                            let aGetNums=JS.getNums(sf)
                            currentNumAnioPersonal=aGetNums[0]
                            //r.dir=1
                            //r.currentNum=currentNumAnioPersonal-1
                        }
                    }
                    Text{
                        text: '<b>N° Año Personal</b>: '+r.currentNumAnioPersonal
                        color: 'white'
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
        Rectangle{
            id: xNums
            width: app.fs*20
            height: width
            border.width: r.borderWidth
            border.color: r.borderColor
            color: apps.backgroundColor
            radius: width*0.5
            anchors.verticalCenter: parent.verticalCenter
            Behavior on rotation{NumberAnimation{duration: 500}}
            MouseArea{
                anchors.fill: parent
                onWheel: {
                    if(wheel.angleDelta.y>=0){
                        r.dir=1
                        if(r.currentNum<8){
                            r.currentNum++
                        }else{
                            r.currentNum=0
                        }
                    }else{
                        r.dir=0
                        if(r.currentNum>0){
                            r.currentNum--
                        }else{
                            r.currentNum=8
                        }
                    }
                }
            }
            Repeater{
                id: rep
                model: r.aDes
                Item{
                    width: 1
                    height: parent.width-parent.border.width*2
                    anchors.centerIn: parent
                    rotation: 360/9*index//+90
                    Rectangle{
                        width: r.borderWidth
                        height: parent.parent.height*0.5-xNum.width-xData.width*0.5-canvasSen.width*0.5
                        color: apps.fontColor
                        opacity: r.currentNum!==index?0.5:1.0
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin:  xNum.width
                        visible: r.currentNum===index
                        Canvas {
                            id:canvasSen
                            width: app.fs
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            //anchors.verticalCenter: parent.verticalCenter
                            //anchors.left: parent.right
                            antialiasing: true
                            rotation: -90
                            onPaint:{
                                var ctx = canvasSen.getContext('2d');
                                ctx.beginPath();
                                ctx.moveTo(0, canvasSen.width*0.5);
                                ctx.lineTo(canvasSen.width, 0);
                                ctx.lineTo(canvasSen.width, canvasSen.width);
                                ctx.lineTo(0, canvasSen.width*0.5);
                                ctx.strokeStyle = r.borderColor
                                ctx.lineWidth = 3//canvasSen.parent.height;
                                ctx.fillStyle = r.borderColor
                                ctx.fill();
                                ctx.stroke();
                            }
                        }
                    }
                    Rectangle{
                        id: xNum
                        width: app.fs*3
                        height: width
                        radius: width*0.5
                        border.width: app.fs*0.2
                        border.color: 'white'
                        //rotation: 360-parent.rotation
                        color: r.currentNum===index?apps.fontColor:apps.backgroundColor
                        rotation: 360-parent.rotation-parent.parent.rotation//-360/9*r.currentNum-90
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: r.currentNum!==index?0.5:1.0

                        Text{
                            text: '<b>'+index+'</b>'
                            font.pixelSize: parent.width*0.8
                            color: r.currentNum===index?apps.backgroundColor:apps.fontColor
                            anchors.centerIn: parent
                            Component.onCompleted: {
                                if(index===1){
                                    text='<b>11</b>'
                                }else{
                                    text='<b>'+parseInt(index + 1)+'</b>'
                                }
                            }
                        }
                    }
                }
            }
            //            Text{
            //                text: ''+xNums.rotation
            //                anchors.centerIn: parent
            //                color: 'white'
            //                font.pixelSize: app.fs*2
            //            }
            Rectangle{
                id: xData
                width: parent.width*0.4
                height: width
                border.width: r.borderWidth
                border.color: r.borderColor
                color: 'transparent'//apps.backgroundColor
                radius: width*0.5
                anchors.centerIn: parent
                Text{
                    id: data
                    text : ''+r.aDes[r.currentNum]
                    width: parent.width-app.fs
                    font.pixelSize: parent.width*0.1
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    color: 'white'
                }
            }
        }

    }
    Component.onCompleted: {
        let a =[]
        let d = 'INICIOS, VIDA NUEVA, RENOVACIONES'
        a.push(d)
        d = 'TOMA DE DESICIONES, SALIR DE TUS FRONTERAS, LA REALIDAD TE ALCANZA'
        a.push(d)
        d = 'NOTORIEDAD, BRILLO, OPCIONES, OPORTUNIDADES'
        a.push(d)
        d = 'CONSTRUCCIÓN, DISCIPLINA, TIEMPO DE PONER ORDEN EN TU VIDA'
        a.push(d)
        d = 'PROGRESO, MOVIMIENTO, SALIR DE LA ZONA DE CONFORT'
        a.push(d)
        d = 'TRABAJO EN RELACIONES, PRODUCTIVIDAD, GENERACIÓN'
        a.push(d)
        d = 'RESPONSABILIDAD Y ESTRUCTURA, ASUMIR LA PROPIA REALIDAD'
        a.push(d)
        d = 'COSECHA Y LOGROS, RETO Y CONQUISTA A SUPERAR'
        a.push(d)
        d = 'AUTOSUFICIENCIA, CONSOLIDACIÓN, CIERRE DE CICLO'
        a.push(d)
        r.aDes=a
        rep.model=a
        //xNums.rotation=90
    }
}
