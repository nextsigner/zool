import QtQuick 2.12

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    Column{
        id: col0
        anchors.centerIn: parent
        Rectangle{
            id: xTxtAboutZool
            width: r.width
            height: r.height-cameraArea.height
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        tTxtAboutZool.running=false
                        if(tTxtAboutZool.v<txtAboutZool.aData.length-1){
                            tTxtAboutZool.v++
                        }else{
                            tTxtAboutZool.v=0
                        }
                        txtAboutZool.text=txtAboutZool.aData[tTxtAboutZool.v]
                    }else{
                        tTxtAboutZool.running=!tTxtAboutZool.running
                    }
                }
            }
            Text{
                id: txtAboutZool
                text: aData[0]
                font.pixelSize: app.fs*0.75
                color: 'white'
                width: r.width-app.fs
                anchors.centerIn: parent
                textFormat: Text.MarkdownText
                wrapMode: Text.WordWrap
                //onLinkActivated: Qt.openUrlExternally(link)
                property var aData: []
                Behavior on opacity{NumberAnimation{duration: 1500}}
                onOpacityChanged: {
                    if(opacity===0.0){
                        txtAboutZool.text=txtAboutZool.aData[tTxtAboutZool.v]
                        tTxtAboutZool.running=true
                        txtAboutZool.opacity=1.0
                    }
                }
                Timer{
                    id: tTxtAboutZool
                    running: sv.currentIndex===0
                    repeat: true
                    interval: 12000
                    property int v: 1
                    property var aTimes: [3000, 10000]
                    onTriggered: {
                        //txtAboutZool.text=txtAboutZool.aData[v]
                        if(v<txtAboutZool.aData.length-1){
                            v++
                        }else{
                            loadZoolText()
                            v=0
                        }
                        if(aTimes.length>0){
                            interval=aTimes[v]
                        }else{
                            interval=12000
                        }
                        txtAboutZool.opacity=0.0
                        running=false
                    }
                }
                Component.onCompleted: {
                    loadZoolText()
                }
            }
        }

        Rectangle{
            id: cameraArea
            width: r.width
            height: app.fs*6
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
        }
    }
    function loadZoolText(){
        let appArgs=Qt.application.arguments
        let fp
        let data
        fp='./resources/zooltext.txt'
        let arg=''
        for(var i=0;i<appArgs.length;i++){
            let a=appArgs[i]
            if(a.indexOf('tempzooltext')>=0){
                let ma=a.split('=')
                if(ma.length>1){
                    arg=ma[1]
                }
            }
        }
        if(arg!==''){
            fp=arg
            if(unik.fileExist(fp)){
                data=unik.getFile(fp)
            }
        }else{
            data=unik.getFile(fp)
        }
        var aD=[]
        var aT=[]
        var aS=data.split('---')
        for(i=0;i<aS.length;i++){
            let dato=aS[i]
            if(dato.indexOf('time=')<0&&dato.indexOf('qml=')<0){
                aD.push(aS[i])
            }else if(dato.indexOf('qml=')>=0){
                let code=''
                let mAC=aS[i].split('qml=')
                if(mAC.length>1){
                    code=mAC[1]
                    let comp=Qt.createQmlObject(code, app, 'qmlcodearg')
                }else{
                    log.l('Error en carga de código qml en archivo '+arg)
                    log.visible=true
                }
            }else{
                let mAT=aS[i].split('=')
                if(mAT.length>1){
                    aT.push(parseInt(mAT[1]))
                }else{
                    aT.push(12000)
                }
            }
        }
        //txtAboutZool.aData=data.split('---')
        //log.l('aD: '+aD.toString())
        //log.l('aT: '+aT.toString())
        //log.visible=true
        txtAboutZool.aData=aD
        tTxtAboutZool.aTimes=aT
    }
}
