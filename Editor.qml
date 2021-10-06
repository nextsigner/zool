import QtQuick 2.0
import QtQuick.Controls 2.0
import "./editor" as Editor
Rectangle{
    id: r
    visible: false
    width: xApp.width*0.2
    height: parent.height
    color: apps.backgroundColor
    clip: true
    property alias l: labelEditorTitle
    property alias e: editor
    property bool editing: false
    onVisibleChanged: {
        if(editing)editor.e.textEdit.focus=visible
    }
    onEditingChanged: {
        if(editing)editor.e.textEdit.focus=r.visible
    }
    MouseArea{
        anchors.fill: r
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
            fs:apps.editorFs
            wordWrap: true
            visible: r.editing
            onEscaped: r.focus=true
            //text: r.data
        }
        Flickable{
            width: xEditor.width
            height: xEditor.height-xEditorTit.height-xEditorTools.height
            contentWidth: dataResult.contentWidth
            contentHeight: dataResult.contentHeight+apps.editorFs*2
            visible: !r.editing
            Text{
                id: dataResult
                font.pixelSize: apps.editorFs
                width: parent.width
                wrapMode: Text.WrapAnywhere
                color: apps.fontColor
                //textFormat: TextEdit.MarkdownText
                text: xEditor.e.text
                textFormat: Text.MarkdownText
                anchors.horizontalCenter: parent.horizontalCenter
            }
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
                    id: botEdit
                    width: app.fs*1.1
                    text:  ''
                    onClicked: {
                        r.editing=!editing
                        if(r.editing)xEditor.e.textEdit.focus=true
                    }
                    Text{
                        text:  !r.editing?'\uf044':'\uf06e'
                        color: apps.backgroundColor
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
                Item{
                    width: app.fs*1.1
                    height: 1
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
    function showInfo(){
        let json=JSON.parse(app.fileData)
        let data=''
        if(json.params.data){
            data=json.params.data
        }
        r.e.text=data
        r.l.text='Información de '+json.params.n.replace(/_/g, ' ')
        r.editing=false
        r.visible=true
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
