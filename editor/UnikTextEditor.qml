import QtQuick 2.5
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
Item{
    id:r
    //focus: te.focus
    property alias fl: flTE

    readonly property real lineHeight: (te.implicitHeight - 2 * te.textMargin) / te.lineCount
    readonly property alias lineCount: te.lineCount

    property bool showNumberLines: false
    property bool wordWrap: true
    property alias text: te.text
    property int modo: 1

    property int fs: 16
    property color color:apps.fontColor
    property color backgroundColor:'black'
    property string text:''
    property bool modificado: false

    property int col: 0
    property int lin: 0

    signal sendCode(string code)
    signal escaped()
    Settings{
        id: eSettings
        fileName: unik.getPath(4)+'/editor.cfg'
        //category: 'conf-unikeditor'

        property int fs
        property string currentFilePath
        property bool wordWrap
    }

    onWidthChanged: te.setPos()
    Rectangle{
        anchors.fill: parent
        color: apps.backgroundColor
    }
    Flickable{
        id:flTE
        width: r.width
        height:r.height
        contentWidth: r.width//te.contentWidth//*1.5
        contentHeight: te.contentHeight+r.fs//*1.5
        //x:((''+te.lineCount).length)*r.fs
        enabled: r.modo===1
        Row{
            spacing: app.fs*0.1
            anchors.left: parent.left
            anchors.leftMargin: app.fs*0.1
            Rectangle{
                id:xColNLI
                color:r.backgroundColor
                width: ((''+te.lineCount).length)*r.fs
                height: colNLI.height
                y:xTE.y
                visible: r.showNumberLines
                //anchors.right: xTE.left
                Rectangle{
                    width: 1
                    height: xTE.height
                    anchors.right: parent.right
                    color: r.color
                }

                Column{
                    id:colNLI
                    width: parent.width-2
                    Repeater{
                        model:te.lineCount
                        Item{
                            id:xNlI
                            width:(nli.text.length-8)*r.fs
                            height: r.lineHeight//r.fs*1.1
                            anchors.right: parent.right
                            Text {
                                id:nli
                                text: '<b>'+parseInt(index+1)+'.</b>'
                                font.pixelSize: parent.height*0.8
                                anchors.bottom:parent.bottom
                                anchors.right: parent.right
                                color: 'white'
                            }
                            //Component.onCompleted: colNL.width=nl.contentWidth
                        }
                    }
                }
            }
            Item{
                id:xTE
                //width:te.text===''?1:te.contentWidth
                width: r.showNumberLines?r.width-(xColNL.width-1)-app.fs*0.25-parent.spacing:r.width-app.fs*0.25-parent.spacing
                height: te.contentHeight
                //x:r.width*0.5
                TextEdit{
                    id:te
                    property bool ins: false
                    property string ccl: '.'
                    property string ccl2: '.'
                    text:r.text
                    font.pixelSize: r.fs
                    color: r.color
                    width: parent.width//r.width
                    height: r.height//r.fs*1.2
                    //wrapMode: eSettings.wordWrap?Text.WordWrap:Text.Normal
                    wrapMode: Text.WrapAnywhere//WordWrap
                    cursorDelegate: Rectangle{
                        id:teCursor
                        width: tec.width;
                        height: r.fs
                        radius: width*0.5
                        color:'transparent'
                        Rectangle{
                            id:tec
                            width: cc.contentWidth;
                            height: r.fs
                            border.width: 2
                            border.color: 'red'
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.left
                            color:'transparent'
                            visible:te.ccl!=='\n'
                            Text{
                                id:cc
                                text:te.ccl!==''&&te.ccl!=='\n'?te.ccl:' '
                                font.pixelSize: te.font.pixelSize
                                color: 'red'
                                anchors.centerIn: parent
                            }
                            Rectangle{
                                id:tecDer
                                width: ccDer.contentWidth;
                                height: r.fs
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.right
                                color: 'transparent'
                                border.color:te.color
                                border.width:v?1:0
                                property bool v: true
                                Timer{
                                    running: true
                                    repeat: true
                                    interval: 500
                                    onTriggered:tecDer.v=!tecDer.v
                                }
                                Text{
                                    id:ccDer
                                    text:te.ccl2!==''&&te.ccl2!=='\n'?te.ccl2:' '
                                    font.pixelSize: te.font.pixelSize
                                    color: 'red'
                                    anchors.centerIn: parent
                                }
                            }

                        }
                        Item{
                            id:tecinit
                            width: ccinit.contentWidth;
                            height: r.fs
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: tec.right
                            visible:te.ccl==='\n'
                            Text{
                                id:ccinit
                                text:'\uf061'
                                font.family: 'FontAwesome'
                                font.pixelSize: te.font.pixelSize
                                color: 'red'
                                anchors.centerIn: parent
                            }
                        }
                        SequentialAnimation{
                            id:san1
                            running: te.ins
                            onStopped: te.ins=false
                            NumberAnimation {
                                target: cc
                                property: "opacity"
                                from:1.0
                                to:0.0
                                duration: 1000
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                    property int vpe: 0
                    Keys.onEscapePressed: {
                        r.escaped()
                        //r.parent.close()
                        //Qt.quit()
                        //r.parent.close()
                        //r.parent.parent.focus=true
                    }
//                    Shortcut{
//                        sequence: 'Esc'
//                        onActivated: Qt.quit()
//                    }

                    Timer{
                        id:tvpe
                        running: false
                        repeat: false
                        interval: 250
                        onTriggered: {
                            if(te.vpe===2){
                                te.insert(te.cursorPosition, '\n')
                            }else{
                                r.modo=0
                                //app.focus=true
                            }
                            te.vpe=0
                        }
                    }
                    onTextChanged: {
                        te.ins=true
                        te.setPos()
                        r.modificado=true
                    }
                    onCursorPositionChanged: te.setPos()
                    function setPos(){
                        //console.log('LLLLL:-'+te.text.substring(te.cursorPosition-1,te.cursorPosition)+'-')
                        te.ccl=te.text.substring(te.cursorPosition-1,te.cursorPosition)
                        te.ccl2=te.text.substring(te.cursorPosition,te.cursorPosition+1)
                        if(r.parent.centrado){
                            flTE.contentX=(te.cursorRectangle.x)+r.fs+r.fs*0.5+te.cursorRectangle.width
                            flTE.contentY=(te.cursorRectangle.y-r.height/2)+r.fs*0.5+flTE.y
                            r.lin=parseInt(te.cursorRectangle.y/te.cursorRectangle.height)
                        }else{
                            flTE.contentX=0//r.width*0.5//(te.cursorRectangle.x)+r.fs+r.fs*0.5+te.cursorRectangle.width
                            if(te.contentHeight<r.height){
                                flTE.contentY=0//(te.cursorRectangle.y-r.height/2)+r.fs*0.5+flTE.y
                            }else{
                                flTE.contentY=(te.cursorRectangle.y-r.height)+r.fs*2//0.5//+flTE.y
                            }
                            r.lin=parseInt(te.cursorRectangle.y/te.cursorRectangle.height)
                        }
                    }
                }

            }
        }
    }

    Rectangle{
        id:xColNL
        color:r.backgroundColor
        width: ((''+te.lineCount).length)*r.fs
        height: colNL.height
        y:0-flTE.contentY
        visible:flTE.contentX>r.width/2
        Rectangle{
            width: 1
            height: r.height
            anchors.right: parent.right
            color: r.color
        }

        Column{
            id:colNL
            width: parent.width-2
            Repeater{
                model:te.lineCount
                Item{
                    id:xNl
                    width:(nl.text.length-8)*r.fs
                    height: r.fs*1.2
                    anchors.right: parent.right
                    Text {
                        id:nl
                        text: '<b>'+parseInt(index+1)+'.</b>'
                        font.pixelSize: parent.height*0.8
                        anchors.bottom:parent.bottom
                        anchors.right: parent.right
                        color: 'white'
                    }
                    //Component.onCompleted: colNL.width=nl.contentWidth
                }
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: apps.fontColor
    }

    Timer{
        id:timerSave
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            te.cursorPosition=0
            eSettings.currentFilePath=tf.text
            unik.setFile(eSettings.currentFilePath, te.text)
            r.text=te.text
            xTF.confirmar=0
            xTF.visible=false
            r.modo=1
            r.modificado=false
            te.focus=true
            te.setPos()
            ub.running=false
        }
    }

    Component.onCompleted: {
        //r.text=//unik.getFile(eSettings.currentFilePath)
        //te.focus=true
        te.cursorPosition=1
        te.setPos()
    }


}
/*
    Modos
    1=Insertar
    2=Abrir
*/
