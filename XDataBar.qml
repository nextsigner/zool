import QtQuick 2.7
import QtQuick.Controls 2.12
import "Funcs.js" as JS
import "./comps" as Comps

Rectangle {
    id: r
    width: parent.width
    //height: tResizeText.running?uH:rowData.height+rowData.height*0.5
    height: xApp.height*0.05
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
    property string stringMiddleSeparator: 'Sinastría'
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
        numAn1.duration=1
        xLoading.opacity=1.0
        //row.opacity=0.5
        //rep.model=at
        tLoadAt.v=0
        tLoadAt.nAt=[]
        rep.model=[]
        tLoadAt.start()
        r.fs=app.fs*0.75
        tResizeText.restart()
    }
    onHeightChanged: uH=height
    Timer{
        id: tLoadAt
        running: false;//r.at.length>0 && r.at.length!==rep.model.length
        repeat: true
        interval: 100
        property int v: 0
        property var nAt: []
        onTriggered: {
            if(v<r.at.length){
                nAt.push(r.at[v])
                v++
            }
            rep.model=nAt
        }
    }
    Timer{
        id: tResizeText
        running: row.width-app.fs*3>xApp.width//row.width<app.width
        repeat: true
        interval: 100
        onRunningChanged: {
            if(!running){
                if(tLoadAt.nAt.length===r.at.length){
                    numAn1.duration=1500
                    xLoading.opacity=0.0
                }
                //xLoading.visible=false
                //xLoading.opacity=0.0
                //nao.duration=1000
                //row.opacity=1.0
            }
        }
        onTriggered: {
            if(row.width>xApp.width){
            //if(row.width>app.width){
                r.fs-=1
            }else{
                //nao.duration=1000
                //row.opacity=1.0
                //stop()
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
    Item{
        id: xSaveRects
        width: app.fs*0.5
        height: parent.height
    }
    Row{
        id: row
        spacing: app.fs*0.15
        y:(parent.height-height)/2
        //visible: opacity>0.1 && r.at.length>3
        //opacity: row.width>r.width?0.0:1.0
        //x: app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter//!app.ev?parent.horizontalCenter:undefined
        anchors.horizontalCenterOffset: 0-((xApp.width>rowData.width?xApp.width-rowData.width:rowData.width-xApp.width)*0.5)-row.spacing*0.5
        Behavior on opacity{
            NumberAnimation{id: nao; duration: 1000}
        }
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
            visible:  !app.ev
            parent: xSaveRects
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJson()
                }
            }
        }
        Rectangle{
            id: circuloSaveEV
            width: app.fs*0.5
            height: width
            //radius: width*0.5
            color: saved?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            y:(parent.height-height)/2
            visible:  app.ev// && app.tipo!=='rs' && app.tipo!=='sin'
            parent: xSaveRects
            property bool saved: false
            Timer{
                id: tCheckBackIsSaved
                running: parent.visible
                repeat: true
                interval: 1000
                onTriggered: {
                    //app.fileData===app.currentData
                    let json=JSON.parse(app.fileData)
                    if(!json.paramsBack){
                        parent.saved=false
                    }else{
                        parent.saved=true
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    JS.saveJsonBack()
                }
            }
        }


        Row{
            id: rowData
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
            onWidthChanged: {
                xLoading.visible=true
                xLoading.opacity=1.0
            }
            Repeater{
                id: rep
                Rectangle{
                    z: modelData==='@'?-100:index
                    visible: txtRow.text.indexOf(':</b>-1')<0||txtRow.text.indexOf(':</b>0')<0
                    width: modelData==='@'?txtRow.contentWidth+r.fs:(txtRow.text.indexOf(':</b>-1')>=0||txtRow.text.indexOf(':</b>0')>=0?1:txtRow.contentWidth+app.fs*0.3)
                    height: txtRow.contentHeight+app.fs*0.3
                    color: apps.backgroundColor
                    border.width: modelData==='@'?0:1
                    border.color: apps.fontColor
                    radius: app.fs*0.1
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea{
                        anchors.fill: parent
                        //enabled: app.titleData!==app.currentData
                        onClicked: {
                            if(index===0){
                                nomEditor.visible=true
                            }
                            if(index===6||index===7){
                                latLonEditor.visible=true
                            }
                        }
                    }
                    Row{
                        z:parent.z-1
                        anchors.centerIn: parent
                        visible: modelData==='@'
                        Rectangle{
                            width: r.width*2
                            height: r.height
                            color: apps.houseColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: r.width*2
                            height: r.height
                            color: apps.houseColorBack
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Text{
                        id: txtRow
                        text: modelData==='@'?r.stringMiddleSeparator:modelData//.replace(/_/g, ' ')
                        font.pixelSize: modelData==='@'?r.fs*1.5:r.fs
                        color: apps.fontColor
                        //visible: modelData!=='@' && parent.width>2
                        anchors.centerIn: parent
//                        Timer{
//                            running: true
//                            repeat: true
//                            interval: 3000
//                            onTriggered: {
//                                log.ls('['+txtRow.text+']', 0, xApp.width*0.2)
//                            }
//                        }
                    }
                    //Component.onCompleted: r.height=height+height*0.2
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColor
                        visible: false
                        //visible: modelData==='@'&&index===0
                        //visible: modelData==='@'//&&index===6
                        //visible: modelData!=='@'&&index===7
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.right: parent.right
                        anchors.left: parent.right
                        anchors.leftMargin: 0-r.width
                    }
                    Rectangle{
                        width: r.width*2
                        height: r.height
                        color: apps.houseColorBack
                        visible: false
                        //visible: modelData==='@'&&index!==0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.right
                    }
                    Component.onCompleted: {
                        if(index===tLoadAt.nAt.length){
                            tResizeText.start()
                        }
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
        visible:  !app.ev
    }

    Rectangle{
        id: xLoading
        anchors.fill: parent
        color: apps.backgroundColor
        Behavior on opacity{NumberAnimation{id: numAn1; duration:1500;}}
        Text{
            text:  '<b>Cargando</b>'
            font.pixelSize: parent.height*0.6
            anchors.centerIn: parent
            color: apps.fontColor
        }
    }

    //Editor Nombre
    Rectangle{
        id: nomEditor
        anchors.fill: r
        color: apps.backgroundColor
        visible: false
        onVisibleChanged: {
            if(visible){
                tiNom.t.text=app.currentNom
                tiNom.t.focus=true
                tiNom.t.selectAll()
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.centerIn: parent
            Text{
                text: '<b>Nombre de Archivo: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiNom
                t.font.pixelSize: app.fs*0.65
                t.text: 'Nombre'
                width: app.fs*10
                onPressed: saveNom()
                anchors.verticalCenter: parent.verticalCenter
            }
            Button{
                text:'Cancelar'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: nomEditor.visible=false
            }
            Button{
                text:'Cambiar Nombre'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    saveNom()
                }
                Timer{
                    running: nomEditor.visible
                    repeat: true
                    interval: 250
                    onTriggered: {
                        if(apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json' !== apps.url){
                            parent.visible=true
                        }else{
                            parent.visible=false
                        }
                    }
                }
            }
        }
    }

    //Editor Nombre
    Rectangle{
        id: latLonEditor
        anchors.fill: r
        color: apps.backgroundColor
        visible: false
        onVisibleChanged: {
            if(visible){
                tiLat.t.text=app.currentLat
                tiLon.t.text=app.currentLon
                tiLat.t.focus=true
                tiLat.t.selectAll()
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.centerIn: parent
            Text{
                text: '<b>Latitud: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiLat
                t.font.pixelSize: app.fs*0.65
                t.text: 'lat...?'
                width: app.fs*5
                onPressed: saveLatLon()
                anchors.verticalCenter: parent.verticalCenter
            }
            Text{
                text: '<b>Longitud: </b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            Comps.XTextInput{
                id: tiLon
                t.font.pixelSize: app.fs*0.65
                t.text: 'lon...?'
                width: app.fs*5
                onPressed: saveLatLon()
                anchors.verticalCenter: parent.verticalCenter
            }
            Button{
                text:'Cancelar'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: latLonEditor.visible=false
            }
            Button{
                text:'Cambiar Coordenadas'
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    saveLatLon()
                }
                Timer{
                    running: nomEditor.visible
                    repeat: true
                    interval: 250
                    onTriggered: {
//                        if(apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json' !== apps.url){
//                            parent.visible=true
//                        }else{
//                            parent.visible=false
//                        }
                    }
                }
            }
        }
    }

    function saveNom(){
        let fn=apps.url
        let nfn=apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json'
        let json = app.currentData
        let jsonData=JSON.parse(app.currentData)
        jsonData.params.n=tiNom.t.text
        app.currentData=JSON.stringify(jsonData)
        //log.l('Actual url: '+apps.url)
        //log.l('Nueva url: '+nfn)
        //log.l('documentsPath: '+documentsPath)
        //log.l('apps.jsonsFolder: '+apps.jsonsFolder)
        //log.visible=true
        JS.saveJsonAs(nfn)
        nomEditor.visible=false
    }
    function saveLatLon(){
        //let fn=apps.url
        //let nfn=apps.jsonsFolder+'/'+tiNom.t.text.replace(/ /g, '_')+'.json'
        //let json = app.currentData
        let jsonData=JSON.parse(app.currentData)
        jsonData.params.lat=tiLat.t.text
        jsonData.params.lon=tiLon.t.text
        app.currentData=JSON.stringify(jsonData)
        //log.l('Actual url: '+apps.url)
        //log.l('Nueva url: '+nfn)
        //log.l('documentsPath: '+documentsPath)
        //log.l('apps.jsonsFolder: '+apps.jsonsFolder)
        //log.visible=true
        JS.saveJson()
        latLonEditor.visible=false
    }
}
