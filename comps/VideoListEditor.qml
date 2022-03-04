import QtQuick 2.0
import QtQuick.Controls 2.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2

Rectangle {
    id: r
    width: xApp.width*0.8
    height: xApp.height
    color: 'black'
    anchors.right: parent.right
    visible: false
    ListView{
        id: lv
        width: r.width
        height: r.height
        model: lm
        delegate: comp
    }
    ListModel{
        id: lm
        function addItem(fn, ip, im){
            return{
                fileName: fn,
                indexPlanet: ip,
                isMirror: im
            }
        }
    }
    Component{
        id: comp
        Rectangle{
            id: xItem
            width: lv.width-app.fs
            height: app.fs*6
            color: 'black'
            border.width: 1
            border.color: 'white'
            MediaPlayer{
                id: videoPlayer
                autoPlay: false
                source: fileName.indexOf('file://')<0?'file://'+fileName:fileName
            }
            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*0.5
                Rectangle{
                    width: app.fs*6
                    height: width*0.75
                    color: 'transparent'
                    border.width: 1
                    border.color: 'white'
                    anchors.verticalCenter: parent.verticalCenter
                    VideoOutput{
                        id: videoPlayerOutPut
                        source: videoPlayer
                        width: app.fs*6
                        height: width*0.75
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: !isMirror?0:width
                        anchors.verticalCenter: parent.verticalCenter
                        transform: Scale{ xScale: isMirror?-1:1 }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(videoPlayer.playbackState===MediaPlayer.PlayingState){
                                videoPlayer.stop()
                            }else{
                                videoPlayer.play()
                            }
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text: '<b>Mostrar Cuerpo: </b>'+indexPlanet
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Row{
                            ButtonIcon{
                                text:'\uf0ab'
                                width: apps.botSize
                                height: width
                                visible: index!==lm.count-1
                                onClicked: {
                                    setIndexPlanet(index, indexPlanet, false)
                                    indexPlanet-=1
                                }
                            }
                            ButtonIcon{
                                text:'\uf0aa'
                                width: apps.botSize
                                height: width
                                visible: index!==0
                                onClicked: {
                                    setIndexPlanet(index, indexPlanet, true)
                                    indexPlanet+=1
                                }
                            }
                        }
                        Item{width: app.fs*2;height: 1}
                        Text{
                            text: '<b>Volteado: </b>'+(isMirror?'SI':'NO')
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ButtonIcon{
                            text:'\uf0ec'
                            width: apps.botSize
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                setMirror(index, isMirror)
                                isMirror=!isMirror
                            }
                        }
                        Item{width: app.fs*2;height: 1}
                        Text{
                            text: '<b>Eliminar</b>'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ButtonIcon{
                            text:'\uf00d'
                            width: apps.botSize
                            height: width
                            onClicked: {
                                deleteItem(index)
                            }
                        }
                        Item{width: app.fs*2;height: 1}
                        Text{
                            text: '<b>Bajar</b>'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            anchors.verticalCenter: parent.verticalCenter
                            visible: index!==lm.count-1
                        }
                        ButtonIcon{
                            text:'\uf0ab'
                            width: apps.botSize
                            height: width
                            visible: index!==lm.count-1
                            onClicked: {
                                lm.move(index, index+1, 1)
                                saveFileList()
                            }
                        }
                        Text{
                            text: '<b>Subir</b>'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            anchors.verticalCenter: parent.verticalCenter
                            visible: index!==0
                        }
                        ButtonIcon{
                            text:'\uf0aa'
                            width: apps.botSize
                            height: width
                            visible: index!==0
                            onClicked: {
                                lm.move(index, index-1, 1)
                                saveFileList()
                            }
                        }
                    }
                    Text{
                        id: txtData
                        text: fileName
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        width: xItem.width-videoPlayerOutPut.width-app.fs*3
                        wrapMode: Text.WrapAnywhere
                    }
                }

            }
        }
    }
    ButtonIcon{
        text:'+'
        width: apps.botSize*2
        height: width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: app.fs*0.5
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.5
        onClicked: {
            fileDialog.open()
        }
    }
    FileDialog {
        id: fileDialog
        title: "Seleccionar Videos"
        folder: apps.repLectCurrentFolder
        selectFolder: false
        nameFilters: ["*.mkv", "*.mp4"]
        selectMultiple: true
        onAccepted: {
            //console.log("You chose: " + fileDialog.fileUrls)
            let u=fileDialog.fileUrls
            for(var i=0;i<u.length;i++){
                addFileList(u[i])
                //log.ls('Video '+i+': '+u[i], 0, 500)
                //log.ls('json Video '+i+': '+addFileList(u[i]), 0, 500)

            }
            updateList()
        }
        onRejected: {
            console.log("Canceled")
        }
        //Component.onCompleted: visible = true
    }
    Component.onCompleted: {
        //updateList()
    }
    function setIndexPlanet(index, indexPlanet, sube){
        let jsonData=''
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        if(!unik.fileExist(jsonFile)){
            return
        }
        jsonData=unik.getFile(jsonFile)
        let json=JSON.parse(jsonData)
        json['item'+index].indexPlanet=sube?indexPlanet+1:indexPlanet-1
        panelVideLectura.uJson=json
        unik.setFile(jsonFile,JSON.stringify(json))
    }
    function setMirror(index, isMirror){
        let jsonData=''
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        if(!unik.fileExist(jsonFile)){
            return
        }
        jsonData=unik.getFile(jsonFile)
        let json=JSON.parse(jsonData)
        json['item'+index].isMirror=!isMirror
        panelVideLectura.uJson=json
        unik.setFile(jsonFile,JSON.stringify(json))
    }
    function addFileList(file){
        let jsonData=''
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        if(!unik.fileExist(jsonFile)){
            return
        }
        jsonData=unik.getFile(jsonFile)
        let json=JSON.parse(jsonData)
        let e=false
        for(var i=0;i<Object.keys(json).length;i++){
            if(file===json['item'+i].fileName){
                e=true
                break
            }
        }
        if(!e){
            //log.ls('Nuevo item: '+'item'+parseInt(Object.keys(json).length), 300, 500)
            let obj={}

            obj.fileName=file
            obj.indexPlanet=-2
            obj.isMirror=false
            json['item'+parseInt(Object.keys(json).length)]=obj
            //log.ls('jsonFile add item: '+JSON.stringify(json), 300, 500)
            unik.setFile(jsonFile,JSON.stringify(json))
        }
    }
    function deleteItem(index){
        let jsonData=''
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        if(!unik.fileExist(jsonFile)){
            return
        }
        jsonData=unik.getFile(jsonFile)
        let json=JSON.parse(jsonData)
        delete json['item'+index]
        let nJson={}
        for(var i=0;i<Object.keys(json).length;i++){
            let obj=json[Object.keys(json)[i]]
            nJson["item"+i]=obj
        }
        panelVideLectura.uJson=nJson
        unik.setFile(jsonFile,JSON.stringify(nJson))
        updateList()
    }
    function updateList(){
        r.visible=true
        lm.clear()
        let jsonData=''
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        //log.ls('jsonFile: '+jsonFile, 300, 500)
        if(!unik.fileExist(jsonFile)){
            jsonData='{"item0":{"fileName":"/home/ns/Documentos/gd/zool_videos/intro_vn.mkv", "indexPlanet": -1, "isMirror": false},"item1":{"fileName":"/home/ns/Documentos/gd/zool_videos/close_vn.mkv", "indexPlanet": -1, "isMirror": false}}'
            unik.setFile(jsonFile,jsonData)

        }
        jsonData=unik.getFile(jsonFile)
        let json=JSON.parse(jsonData)
        panelVideLectura.uJson=json
        for(var i=0;i<Object.keys(json).length;i++){
            //log.ls('jsonItem: '+json['item'+i].fileName, 300, 500)
            //log.ls('jsonItem: '+json['item'+i].indexPlanet, 300, 500)
            //log.ls('jsonItem: '+json['item'+i].isMirror, 300, 500)
            lm.append(lm.addItem(json['item'+i].fileName, json['item'+i].indexPlanet, json['item'+i].isMirror))
        }
    }
    function saveFileList(){
        let json={}
        for(var i=0;i<lm.count;i++){
            let obj=lm.get(i)
            json['item'+i]=obj
        }
        panelVideLectura.uJson=json
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        unik.setFile(jsonFile,JSON.stringify(json))
    }
}
