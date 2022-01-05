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
                    onTriggered: {
                        //txtAboutZool.text=txtAboutZool.aData[v]
                        if(v<txtAboutZool.aData.length-1){
                            v++
                        }else{
                            v=0
                        }
                        txtAboutZool.opacity=0.0
                        running=false
                    }
                }
                Component.onCompleted: {
                    let appArgs=Qt.application.arguments
                    let fp
                    let data
                    fp='./resources/zooltext.txt'
                    if(appArgs.indexOf('tempzooltext')>=0){
                        fp=unik.getPath(7)+'/tempzooltext'
                        if(unik.fileExist(fp)){
                            data=unik.getFile(fp)
                        }
                    }else{
                        data=unik.getFile(fp)
                    }
                    aData=data.split('---')
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
}
