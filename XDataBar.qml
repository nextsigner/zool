import QtQuick 2.7
import "Funcs.js" as JS
import "./comps" as Comps

Rectangle {
    id: r
    width: parent.width
    height: tResizeText.running?uH:rowData.height+rowData.height*0.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    property string titleData//: txtCurrentData.text
    //property alias currentDateText: txtCurrentDate.text
    //property alias currentGmtText: txtCurrentGmt.text
    property bool showTimes: false
    property int fs: app.fs*0.5
    property var at: []
    property int uH: r.fs
    state: 'hide'
    states:[
        State {
            name: "show"
            PropertyChanges {
                target: r
                y:0
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                y:0-r.height
            }
        }
    ]
    Behavior on y{NumberAnimation{duration:app.msDesDuration;easing.type: Easing.InOutQuad}}
    onStateChanged: {
        //if(state==='show')tHide.restart()
    }
    onAtChanged: {
        rep.model=at
        r.fs=app.fs*0.5
        tResizeText.restart()
    }
    onTitleDataChanged: {
//        let a=titleData.split('|')
//        rep.model=a
//        r.fs=app.fs*0.5
//        tResizeText.restart()
    }
    onHeightChanged: uH=height
    Timer{
        id: tResizeText
        running: false
        repeat: true
        interval: 50
        onTriggered: {
            if(row.width>r.width-app.fs){
                r.fs=r.fs-1
            }else{
                stop()
            }
            //log.l('fs: '+r.fs)
        }
    }

    Timer{
        id: tHide
        running: false
        repeat: false
        interval: 15*1000
        //onTriggered: r.state='hide'
    }
    Row{
        id: row
        spacing: app.fs*0.15
        y:(parent.height-height)/2
        //x: app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter//!sweg.objHousesCircleBack.visible?parent.horizontalCenter:undefined
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: app.fileData===app.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            y:(parent.height-height)/2
            visible:  !sweg.objHousesCircleBack.visible
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJson()
                }
            }
        }
        Row{
            id: rowData
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter            
            Repeater{
                id: rep
                Rectangle{
                    width: modelData==='@'?1:txtRow.contentWidth+app.fs*0.3
                    height: txtRow.contentHeight+app.fs*0.3
                    color: apps.backgroundColor
                    border.width: modelData==='@'?0:1
                    border.color: apps.fontColor
                    radius: app.fs*0.1
                    //visible:  !sweg.objHousesCircleBack.visible&&(index!==6&&index!==7)//!(modelData.indexOf('lat:')>0||modelData.indexOf('lon:')>0)
                   Text{
                        id: txtRow
                        text: modelData//.replace(/_/g, ' ')
                        font.pixelSize: r.fs
                        color: apps.fontColor
                        visible: modelData!=='@'
                        anchors.centerIn: parent
                    }
                    //Component.onCompleted: r.height=height+height*0.2
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColor
                        visible: modelData==='@'&&index===0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                        anchors.leftMargin: 0-r.width
                    }
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColorBack
                        visible: modelData==='@'&&index!==0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                    }
                }
            }
        }
    }
    Comps.XTimes{
        id: xTimes
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: yPos
        visible:  !sweg.objHousesCircleBack.visible
    }
//    Row{
//        spacing: app.fs*0.5
//        height: txtCurrentDate.contentHeight+app.fs*0.5
//        y:parent.height
//        anchors.left: parent.left
//        anchors.leftMargin: xLatIzq.width
//        visible: app.fileData!==app.currentData
//        Rectangle{
//            width: txtCurrentDate.contentWidth+app.fs*0.5
//            height: txtCurrentDate.contentHeight+app.fs*0.5
//            color: apps.backgroundColor
//            border.width: 1
//            border.color: apps.fontColor
//            XText {
//                id: txtCurrentDate
//                text: '0/0/000 00:00'
//                font.pixelSize: app.fs*0.5
//                height: app.fs*0.5
//                color: 'white'
//                textFormat: Text.RichText
//                anchors.centerIn: parent
//            }
//        }
//        Rectangle{
//            width: txtCurrentGmt.contentWidth+app.fs//*0.5
//            height: txtCurrentGmt.contentHeight+app.fs*0.5
//            color: apps.backgroundColor
//            border.width: 1
//            border.color: apps.fontColor
//            XText {
//                id: txtCurrentGmt
//                text: '?'
//                font.pixelSize: app.fs*0.5
//                height: app.fs*0.5
//                color: 'white'
//                textFormat: Text.RichText
//                anchors.centerIn: parent
//            }
//            MouseArea {
//                id: maw
//                anchors.fill: parent
//                onClicked: r.v=!r.v
//                property int m:0
//                property date uDate//: app.currentDate
//                property int f: 0
//                property int uY: 0
//                onWheel: {
//                    let cgmt=app.currentGmt
//                    if(wheel.angleDelta.y===120){
//                        if(cgmt<12.00){
//                            cgmt+=0.1
//                        }else{
//                            cgmt=-12.00
//                        }
//                    }else{
//                        if(cgmt>-12.00){
//                            cgmt-=0.1
//                        }else{
//                            cgmt=12.00
//                        }
//                    }
//                    app.currentGmt=parseFloat(cgmt).toFixed(1)
//                }
//            }
//        }
//    }
}
