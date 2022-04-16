import QtQuick 2.12
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import unik.UnikQProcess 1.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    property string currentPSH: ''+currentP+'_'+currentS+'_'+currentH
    property int currentP: -1
    property int currentS: -1
    property int currentH: -1
    property int currentCmdCompleted: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            //tF.restart()
        }else{
            //tF.stop()
        }
    }
    onCurrentPChanged: {
        tLoadPSH.restart()
    }
    onCurrentSChanged: {
        tLoadPSH.restart()
    }
    onCurrentHChanged: {
        tLoadPSH.restart()
    }
    Timer{
        id: tLoadPSH
        running: false
        repeat: false
        interval: 1000
        onTriggered: {
            loadData(r.currentP, r.currentS, r.currentH)
        }
    }

    UnikQProcess{
        id: uqp
        property string uAudioFile: ''
        onLogDataChanged: {
            //log.ls('LogData: '+logData, 300, 500)
        }
        onFinished: {
            //log.ls('Finalizado!', 0, 500)
            //audioPlayer.source='file://'+uAudioFile
            audioPlayer.playlist.addItem('file://'+uAudioFile)
            r.currentCmdCompleted++
            runCmd()
            //audioPlayer.play()
        }
        //onStarted: botRec.isRec=true
    }

    MediaPlayer{
        id: audioPlayer
        autoPlay: true
        onSourceChanged: {
            //txtCurrentText.text='E: '+getDataIndex(r.currentP, r.currentS, r.currentH, playList.currentIndex - 1)
        }
        onPositionChanged:{
            if(position>duration-3000&&duration>=1000){
                              tPlayTrans.start()
            }
        }
        playlist: Playlist{
            id: playList
            onCurrentIndexChanged: {
                txtCurrentText.text=''+getDataIndex(r.currentP, r.currentS, r.currentH, currentIndex)
            }
        }
    }
    Rectangle{
        id: xCurrentText
        anchors.fill: parent
        color: apps.backgroundColor
        Text{
            id: txtCurrentText
            text: 'Seleccionar Datos'
            font.pixelSize: app.fs*0.65
            width: parent.width-app.fs*0.5
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            color: apps.fontColor
            visible: text!=='undefined'
        }
    }


    ListView{
        id: lvCmd
        width: r.width
        height: r.height-xControls.height
        model: lmCmd
        delegate: compCmd
        //anchors.centerIn: parent
        clip: true
        visible: false
        Component{
            id: compCmd
            Rectangle{
                width: r.width
                height: col100.height+app.fs
                border.width: 2
                border.color: 'red'
                Column{
                    id: col100
                    spacing: app.fs*0.5
                    anchors.centerIn: parent
                    Text{
                        text: fileName
                        font.pixelSize: app.fs*0.35
                    }
                    Text{
                        text: url
                        font.pixelSize: app.fs*0.35
                        width: lvCmd.width-app.fs
                        wrapMode: Text.WrapAnywhere
                    }
                }
                //Component.onCompleted: xLatIzq.z=xMed.z+1
            }
        }
        ListModel{
            id: lmCmd
//            ListElement{
//                fileName: "sdfafasdfsafsdf"
//                url: "sdfsadfsad3f 2sa3f22"
//            }
            function addItem(fn, u){
                return {
                    fileName: fn,
                    url: u
                }
            }
        }
    }
    MouseArea{
        width: r.width
        height: xControls.height
        anchors.bottom: parent.bottom
        hoverEnabled: true
        onPositionChanged: tHideXControls.restart()
        onEntered: {
            xControls.opacity=1.0
        }
        onExited: tHideXControls.restart()
        Timer{
            id: tHideXControls
            interval: 5000
            onTriggered: xControls.opacity=0.0
        }
    }
    Rectangle{
        id: xControls
        width: r.width
        height: colBtns.height+app.fs
        color: 'transparent'
        border.width: 1
        border.color: 'white'
        radius: app.fs*0.5
        opacity: 0.0
        anchors.bottom: parent.bottom
        property int currentP: -1
        property int currentS: -1
        property int currentH: -1
        Behavior on opacity{NumberAnimation{duration: 250}}
        Column{
            id: colBtns
            spacing: app.fs*0.5
            anchors.centerIn: parent
            Rectangle{
                id: xControlsPSH
                width: r.width
                height: colBtnsPSH.height+app.fs*0.5
                color: 'transparent'
                //border.width: 3
                //border.color: 'red'
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colBtnsPSH
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: r.currentP===-1&&r.currentS===-1&&r.currentH===-1?'Seleccionar':''+app.planetas[r.currentP]+' en '+app.signos[r.currentS]+' en casa '+parseInt(r.currentH + 1)
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        //Cambiar P
                        ButtonIcon{
                            text: '\uf04a'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentP>0){
                                    xControls.currentP--
                                }else{
                                    xControls.currentP=11
                                }

                            }
                        }
                        Text{
                            text: app.planetas[xControls.currentP]
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ButtonIcon{
                            text: '\uf04e'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentP<11){
                                    xControls.currentP++
                                }else{
                                    xControls.currentP=0
                                }
                            }
                        }

                        //Cambiar S
                        ButtonIcon{
                            text: '\uf04a'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentS<0){
                                    xControls.currentS--
                                }else{
                                    xControls.currentS=11
                                }
                            }
                        }
                        Text{
                            text: app.signos[xControls.currentS]
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ButtonIcon{
                            text: '\uf04e'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentS<11){
                                    xControls.currentS++
                                }else{
                                    xControls.currentS=0
                                }
                            }
                        }

                        //Cambiar H
                        ButtonIcon{
                            text: '\uf04a'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentH<0){
                                    xControls.currentH--
                                }else{
                                    xControls.currentH=11
                                }
                            }
                        }
                        Text{
                            text: 'c '+parseInt(xControls.currentH)
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ButtonIcon{
                            text: '\uf04e'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(xControls.currentH<11){
                                    xControls.currentH++
                                }else{
                                    xControls.currentH=0
                                }
                            }
                        }



                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ButtonIcon{
                            text: '\uf093'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                r.currentP=xControls.currentP
                                r.currentS=xControls.currentS
                                r.currentH=xControls.currentH
                            }
                        }
                        ButtonIcon{
                            text: '\uf114'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                folderDialog.visible=true
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xControlsAP
                width: r.width
                height: colBtnsAP.height+app.fs*0.5
                color: 'transparent'
                //border.width: 3
                //border.color: 'red'
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colBtnsAP
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: 'Reproductor de Audio'
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: playList.currentIndex<0?'Seleccionar audio':'Audio '+playList.currentIndex+' de '+playList.itemCount
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
//                    Text{
//                        text:'Cantidad pl: '+playList.itemCount+' Cant lv: '//+lv.count
//                        font.pixelSize: app.fs*0.5
//                        color: 'white'
//                        anchors.horizontalCenter: parent.horizontalCenter
//                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ButtonIcon{
                            text: '\uf049'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                audioPlayer.stop()
                                playList.currentIndex=0
                            }
                        }
                        ButtonIcon{
                            text: '\uf04a'
                            width: apps.botSize*0.6
                            height: width
                            enabled: playList.currentIndex!==0
                            onClicked: {
                                audioPlayer.stop()
                                if(playList.currentIndex>0){
                                    playList.currentIndex--
                                }
                            }
                        }
                        ButtonIcon{
                            text: audioPlayer.playbackState!==MediaPlayer.PlayingState?'\uf04b':'\uf04c'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                if(audioPlayer.playbackState!==MediaPlayer.PlayingState){
                                    audioPlayer.play()
                                }else{
                                    audioPlayer.pause()
                                }
                            }
                        }
                        ButtonIcon{
                            text: '\uf04d'
                            width: apps.botSize*0.6
                            height: width
                            onClicked: {
                                audioPlayer.stop()
                            }
                        }
                        ButtonIcon{
                            text: '\uf04e'
                            width: apps.botSize*0.6
                            height: width
                            enabled: playList.currentIndex<playList.itemCount-1
                            onClicked: {

                            }
                        }

//                        ButtonIcon{
//                            text: '\uf114'
//                            width: apps.botSize*0.6
//                            height: width
//                            onClicked: {

//                            }
//                        }
//                        ButtonIcon{
//                            text: '\uf0ca'
//                            width: apps.botSize*0.6
//                            height: width
//                            onClicked: {

//                            }
//                        }

                    }
                }
            }
        }
    }
    FileDialog {
        id: folderDialog
        title: "Seleccionar Carpeta"
        folder: apps.repAudioTAVCurrentFolder
        selectFolder: true
        selectMultiple: false
        onAccepted: {
            let u=folderDialog.fileUrls
            apps.repAudioTAVCurrentFolder=u[0]
        }
        onRejected: {
            console.log("Canceled")
        }
    }
    Component.onCompleted: {
        //sv.currentIndex=9
        //log.ls('Folder TAV: '+apps.repAudioTAVCurrentFolder, 0, 500)
        let f=(''+apps.repAudioTAVCurrentFolder).replace('file://', '')
        if(!unik.folderExist(documentsPath)){
            unik.mkdir(documentsPath)
        }
        if(!unik.folderExist(f)){
            unik.mkdir(f)
        }
    }
    function loadData(p, s, h){
        playList.clear()
        r.currentP=p
        r.currentS=s
        r.currentH=h
        getData(p, s, h)
        //log.ls('Load: '+r.currentPSH, 0, 500)
    }
    function getData(p, s, h) {
        lmCmd.clear()
        let fileDataPath=apps.jsonsFolder+'/../zool_docs/zool_data/'+app.planetasArchivos[p]+'_s'+parseInt(s + 1)+'.txt'
        //log.ls('FilePath: '+fileDataPath, 0, 500)
        if(!unik.fileExist(fileDataPath))return
        let fileData=unik.getFile(fileDataPath)
        //log.ls('Data: '+fileData, 0, 500)
        let fileDataClasific=fileData.split('|INFORMACIÓN DESCLASIFICADA:')[0]
        let dataLines=fileDataClasific.split('|')
        let dataList=[]
        //log.ls('SD:['+dataLines+']', 0, 500)
        //lmCmd.append(lmCmd.addItem("-->"+dataLines.length+"sdfs", "a3sd213a12s"))
        for(var i=0;i<dataLines.length;i++){
            let dl=(''+dataLines[i]).replace(/\n/g, '')
            //lmCmd.append(lmCmd.addItem("-->"+i+"sdfs", "a3sd213a12s"))

            //return
            let stringUrlEncoded=dl.replace(/<[^>]*>/g, '');
            stringUrlEncoded=stringUrlEncoded.replace(/\n/g, '')
            stringUrlEncoded=encodeURI(stringUrlEncoded)
            stringUrlEncoded=stringUrlEncoded.replace(/ /g, '%20')
            let audioFilePath=(''+apps.repAudioTAVCurrentFolder).replace('file://', '')+'/'+r.currentPSH+'_'+i+'.mp3'
            //let audioFilePath='/tmp/'+r.currentPSH+'_'+i+'.mp3'
            let url='"https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+stringUrlEncoded+'&voice=es-ES_EnriqueVoice&download=true&accept=audio%2Fmp3"'
            lmCmd.append(lmCmd.addItem(audioFilePath, url))
            //log.ls('SD:['+stringUrlEncoded+']', 0, 500)
        }
        r.currentCmdCompleted=0
        runCmd()
        //return dataList
    }
    function getDataIndex(p, s, h, i) {
        let fileDataPath=apps.jsonsFolder+'/../zool_docs/zool_data/'+app.planetasArchivos[p]+'_s'+parseInt(s + 1)+'.txt'
        if(!unik.fileExist(fileDataPath))return
        let fileData=unik.getFile(fileDataPath)
        let dataLines=fileData.split('|')
        let dataList=[]
        return (''+dataLines[i]).replace(/\n/g, '')
    }
    function runCmd(){
        let fileName=lmCmd.get(r.currentCmdCompleted).fileName
        let url=lmCmd.get(r.currentCmdCompleted).url
        //log.ls('Check fileName: '+fileName, 0,500)
        if(!unik.fileExist(fileName)){
            let cl='curl --output '+fileName+' "'+url+'"'
            uqp.uAudioFile=fileName
            uqp.run(cl)
        }else{
            playList.addItem('file://'+fileName)
            r.currentCmdCompleted++
            runCmd()
        }
        //currentCmdCompleted
    }

    //Funciones del Reproductor
    function tooglePlayPause(){
        if(audioPlayer.playbackState===MediaPlayer.PlayingState){
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }
}
