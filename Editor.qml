import QtQuick 2.0
import QtQuick.Controls 2.0
import "./editor" as Editor
Rectangle{
    id: r
    visible: false
    width: xApp.width*0.2
    height: parent.height
    clip: true
    property alias l: labelEditorTitle
    property alias e: editor
    onVisibleChanged: {
        editor.e.focus=visible
    }
    Column{
        anchors.centerIn: parent
        Rectangle{
            id: xEditorTit
            width: r.width
            height: labelEditorTitle.contentHeight+app.fs*0.5
            color: apps.fontColor
            Text{
                id: labelEditorTitle
                text: 'Editando Información'
                width: parent.width-app.fs*0.5
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
            }
        }
        Editor.UnikTextEditor{
            id:editor
            width: xEditor.width
            height: xEditor.height-xEditorTit.height-xEditorTools.height
            fs:app.fs*0.5
            wordWrap: true
            onEscaped: r.focus=true
            //text: r.data
        }
        Rectangle{
            id: xEditorTools
            width: r.width
            height: app.fs*1.2
            color: apps.fontColor
            Row{
                anchors.centerIn: parent
                spacing: app.fs*0.1
                Button{
                    id: botSave
                    width: app.fs*1.1
                    text:  ''
                    enabled: !diff
                    opacity: diff?0.5:1.0
                    property bool diff: false
                    onClicked: {
                        save()
                    }
                    Text{
                        text:  '\uf0c7'
                        color: botSave.diff?apps.backgroundColor:'blue'
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                    Timer{
                        running: r.visible
                        repeat: true
                        interval: 250
                        onTriggered: {
                            let json=JSON.parse(app.fileData)
                            let d0=''
                            if(json.params.data)d0=json.params.data
                            let d1=editor.text
                            botSave.diff=d1===d0
                        }
                    }
                }
                Button{
                    id: botClose
                    width: app.fs*1.1
                    text:  ''
                    onClicked: {
                        r.visible=false
                    }
                    Text{
                        text:  '\uf00d'
                        color: botSave.diff?apps.backgroundColor:'blue'
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
    function enter(){
        //Qt.quit()
    }
    function save(){
        let json=JSON.parse(app.fileData)
        json.params.data=editor.text
        let njson=JSON.stringify(json)
        app.fileData=njson
        unik.setFile(apps.url.replace('file://', ''), app.fileData)
    }
    function close(){
       r.visible=false
    }
}
