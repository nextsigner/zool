import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id: r
    width: app.fs*20
    height: xApp.height-(xApp.height-xBottomBar.y)
    color: apps.backgroundColor
    visible: apps.showLog
    border.width: 2
    border.color: apps.fontColor
    clip: true
    property alias text: taLog.text
    property bool ww: true
    MouseArea{
        anchors.fill: parent
        onClicked: apps.showLog=false
    }
    Flickable{
        id: flLog
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: taLog.contentHeight
        clip: true
        TextArea{
            id: taLog
            width: r.width-app.fs//*0.5
            wrapMode: r.ww?Text.WordWrap:Text.WrapAnywhere
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            background: Rectangle{color: 'transparent'}
        }
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        color: apps.fontColor
        Text{text: 'X';anchors.centerIn: parent;color: apps.backgroundColor}
        MouseArea{
            anchors.fill: parent
            onClicked: {
                apps.showLog=false
                r.visible=apps.showLog
            }
        }
    }
    function l(d){
        taLog.text+=d+'\n'
        flLog.contentY=taLog.contentHeight-r.height
    }
    function clear(){
        taLog.clear()
    }
}
