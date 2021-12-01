import QtQuick 2.0

Rectangle {
    id: r
    width: row.width//+app.fs
    height: r.fs+app.fs
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property bool isBack: false
    property var currentDate: !isBack?app.currentDate:app.currentDateBack
    property int anio: 0
    property int mes: 0
    property int dia: 0
    property int hora: 0
    property int minuto: 0
    property int fs: app.fs*0.5
    property bool setAppTime: true
    onCurrentDateChanged: {
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        r.hora=r.currentDate.getHours()
        r.minuto=r.currentDate.getMinutes()
        if(r.setAppTime){
            if(!r.isBack){
                app.currentDate=r.currentDate
            }else{
                app.currentDateBack=r.currentDate
    //            log.l('cdb:'+app.currentDateBack.toString())
    //            log.width=xApp.width*0.2
    //            log.visible=true
            }
        }
        r.setAppTime=true
    }
    Row{
        Rectangle{
            width: row1.width
            height: r.height*0.4
            Text {
                id: labelHora
                text: 'Hora'
                font.pixelSize: app.fs*0.35
                anchors.centerIn: parent
            }
        }
        Rectangle{
            id: xLabelGmt
            width: r.fs*3
            height: r.height*0.4
            Text {
                id: labelGmt
                text: 'GMT'
                font.pixelSize: app.fs*0.35
                anchors.centerIn: parent
            }
        }
        Rectangle{
            width: row2.width
            height: r.height*0.4
            Text {
                id: labelFecha
                text: 'Fecha'
                font.pixelSize: app.fs*0.35
                anchors.centerIn: parent
            }
        }
    }
    Row{
        id: row
        anchors.bottom: parent.bottom
        Row{
            id: row1
            Rectangle{
                id: xHora
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setHours(d2.getHours() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setHours(d2.getHours() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t4
                    text: r.hora
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
            }

            Rectangle{
                id: xMinuto
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setMinutes(d2.getMinutes() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setMinutes(d2.getMinutes() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t6
                    text: r.minuto>9?r.minuto:'0'+r.minuto
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                Rectangle{
                    width: t5.contentWidth+2
                    height: t5.contentHeight+2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    color: apps.backgroundColor
                    Text{
                        id: t5
                        text: ':'
                        color: apps.fontColor
                        font.pixelSize: r.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
        Rectangle{
            id: xGmt
            width: xLabelGmt.width
            height: r.height*0.6
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            Text{
                id: t8
                text: !r.isBack?app.currentGmt:app.currentGmtBack
                color: apps.fontColor
                font.pixelSize: r.fs
                anchors.centerIn: parent
            }
            MouseArea {
                id: maw
                anchors.fill: parent
                onClicked: r.v=!r.v
                property int m:0
                property date uDate//: app.currentDate
                property int f: 0
                property int uY: 0
                onWheel: {
                    let cgmt
                    if(!r.isBack){
                        cgmt=app.currentGmt
                    }else{
                        cgmt=app.currentGmtBack
                    }
                    if(wheel.angleDelta.y===120){
                        if(cgmt<12.00){
                            cgmt+=0.1
                        }else{
                            cgmt=-12.00
                        }
                    }else{
                        if(cgmt>-12.00){
                            cgmt-=0.1
                        }else{
                            cgmt=12.00
                        }
                    }
                    if(!r.isBack){
                        app.currentGmt=parseFloat(cgmt).toFixed(1)
                    }else{
                        app.currentGmtBack=parseFloat(cgmt).toFixed(1)
                    }
                }
            }
        }
        Row{
            id: row2
            spacing: -1
            Rectangle{
                id: xDia
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setDate(d2.getDate() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setDate(d2.getDate() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t3
                    text: r.dia
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: xMes
                width: r.fs*2
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setMonth(d2.getMonth() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setMonth(d2.getMonth() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t2
                    text: r.mes>9?r.mes:'0'+r.mes
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                Rectangle{
                    width: tb1.contentWidth+2
                    height: tb1.contentHeight+2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    color: apps.backgroundColor
                    Text{
                        id: tb1
                        text: '/'
                        color: apps.fontColor
                        font.pixelSize: r.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle{
                id: xAnio
                width: r.fs*3
                height: r.height*0.6
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                MouseArea{
                    anchors.fill: parent
                    onWheel: {
                        let d = r.currentDate
                        let d2=new Date(d.getTime())
                        if(wheel.angleDelta.y>=0){
                            d2.setFullYear(d2.getFullYear() + 1)
                            r.currentDate = new Date(d2)
                        }else{
                            d2.setFullYear(d2.getFullYear() - 1)
                            r.currentDate = new Date(d2)
                        }
                    }
                }
                Text{
                    id: t1
                    text: r.anio
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                Rectangle{
                    width: tb2.contentWidth+2
                    height: tb2.contentHeight+2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    color: apps.backgroundColor
                    Text{
                        id: tb2
                        text: '/'
                        color: apps.fontColor
                        font.pixelSize: r.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        if(!r.currentDate)r.currentDate=new Date(Date.now())
    }
    function setTime(datetime){
        r.setAppTime=false
        r.currentDate=datetime
    }
}
