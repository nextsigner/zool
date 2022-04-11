import QtQuick 2.12
import QtMultimedia 5.12
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
    property string currentPSH: ''
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            //tF.restart()
        }else{
            //tF.stop()
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
            audioPlayer.source='file://'+uAudioFile
            audioPlayer.play()
        }
        //onStarted: botRec.isRec=true
    }
    MediaPlayer{
        id: audioPlayer
        autoPlay: true
        onPositionChanged:{
            if(position>duration-3000&&duration>=1000){
                //trans.opacity=1.0
                //                audioPlayer.stop()
                //                tPlayTrans.start()
            }
        }
        playlist: Playlist{
            id: playList
            onCurrentIndexChanged: {

            }
        }
        onPlaybackStateChanged: {
            if(audioPlayer.playbackState===MediaPlayer.PlayingState){

            }
            if(audioPlayer.playbackState===MediaPlayer.StoppedState){
                lv.currentIndex++
            }
        }
    }
    GridView{
        id: lv
        //spacing: app.fs*0.5
        width: r.width-app.fs*0.5
        height: r.height
        cellWidth: r.width
        cellHeight: r.height
        delegate: comp
        model: lm
        clip: false
        displayMarginEnd: height*3
        anchors.horizontalCenter: parent.horizontalCenter
        ListModel{
            id: lm
            function addItem(data){
                return {
                    d: data
                }
            }
        }
        Component{
            id: comp
            Rectangle{
                id: xItemData
                width: lv.width
                height: !isSubTit?txtData.contentHeight+app.fs*0.5:txtData.contentHeight+app.fs*0.25
                color: !isTit?'black':'white'
                border.width: selected?2:0
                border.color: 'white'
                visible: selected
                property bool selected: index===lv.currentIndex
                property bool isTit: false//d.indexOf('GENERALI')>=0
                property bool isSubTit: false
                property string stringUrlEncoded: 'Continuamos.'
                onSelectedChanged: {
                    //lv.contentY=xItemData.y
                    //if(selected&&isTit)lv.currentIndex++
                    //if(selected)lv.contentY=xItemData.y
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(audioPlayer.playbackState===MediaPlayer.PlayingState){
                            let f=(''+audioPlayer.source).replace('file://', '')
                            unik.deleteFile(f)
                            audioPlayer.pause()
                            lv.currentIndex=index
                        }else{
                            audioPlayer.stop()
                            audioPlayer.source=''
                            lv.currentIndex--
                        }
                    }
                }
                Text{
                    id: txtData
                    text: d
                    color: !isTit?'white':'black'
                    font.pixelSize: !parent.isTit?(selected?apps.iwFs*1.5:apps.iwFs):apps.iwFs
                    width: parent.width-app.fs*0.5
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: !xItemData.isSubTit?0:app.fs
                    //anchors.centerIn: parent
                    Rectangle{
                        width: parent.width
                        height: 3
                        color: 'red'
                        anchors.bottom: parent.bottom
                        visible: xItemData.isSubTit
                    }
                }
                Timer{
                    running: xItemData.selected
                    repeat: false
                    interval: 1000
                    onTriggered: {
                        //log.ls('DatoToVoice: '+stringUrlEncoded, 0, 500)
                        let audioFilePath='/tmp/'+r.currentPSH+'_'+index+'.mp3'
                        if(!unik.fileExist(audioFilePath)){
                            let cl='curl --output '+audioFilePath+' "https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+stringUrlEncoded+'&voice=es-ES_EnriqueVoice&download=true&accept=audio%2Fmp3"'
                            uqp.uAudioFile=audioFilePath
                            uqp.run(cl)
                            console.log('Audio: '+audioFilePath)
                        }else{
                            audioPlayer.source='file://'+audioFilePath
                            audioPlayer.play()
                        }
                    }
                }
                Component.onCompleted: {
                    stringUrlEncoded=d.replace(/<[^>]*>/g, '');
                    stringUrlEncoded=stringUrlEncoded.replace(/\n/g, '')
                    stringUrlEncoded=encodeURI(stringUrlEncoded)
                    stringUrlEncoded=stringUrlEncoded.replace(/ /g, '%20')
                    //log.ls('SD:['+stringUrlEncoded+']', 0, 500)
                    if(d.indexOf('<h2>')>=0){
                        isTit=true
                    }
                    if(d.indexOf('POSITIVO:')>=0){
                        isSubTit=true
                    }
                    if(d.indexOf('NEGATIVO:')>=0){
                        isSubTit=true
                    }
                    if(d.indexOf('GENERALIDADES:')>=0){
                        isSubTit=true
                    }
                    if(d.indexOf('MEJORAR:')>=0){
                        isSubTit=true
                    }
                    if(d.indexOf('PALABRAS CLAVES:')>=0){
                        isSubTit=true
                    }
                    if(d.indexOf(':')>=0){
                        isSubTit=true
                    }
                    if(isSubTit){
                        d='<b>'+d+'</b>'
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: b?3:0
        border.color: 'red'
        property bool b: false
        Timer{
            running: true
            repeat: true
            interval: 1000
            //onTriggered: parent.b=!parent.b
        }
    }


    Component.onCompleted: {
        sv.currentIndex=9
        loadData(0, 1, 0)
    }
    function loadData(p, s, h){
        let dl = getData(p, s, h)
        lm.clear()
        for(var i=0;i<dl.length;i++){
            lm.append(lm.addItem(dl[i]))
            //log.ls('Data '+i+': '+dl[i], 0, 500)
        }
        lv.currentIndex=0
        r. currentPSH=''+p+'_'+s+'_'+h
    }
    function getData(p, s, h) {
        let fileData=unik.getFile(apps.jsonsFolder+'/../zool_docs/zool_data/'+app.planetasArchivos[p]+'_s'+s+'.txt')
        //log.ls('Data: '+fileData, 0, 500)
        let dataLines=fileData.split('|')
        let dataList=[]
        dataList.push('<h2>'+app.planetas[p]+' en  '+app.signos[s]+'</h2>')
        for(var i=0;i<dataLines.length;i++){
            dataList.push(dataLines[i])
        }
        return dataList
    }
}
