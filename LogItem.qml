import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id: r
    width: app.fs*20
    height: xApp.height-(xApp.height-xBottomBar.y)
    color: 'black'
    visible: apps.showLog
    border.width: 2
    border.color: 'white'
    clip: true
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
        TextArea{
            id: taLog
            width: r.width-app.fs*0.5
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: app.fs*0.5
            color: 'white'
            background: Rectangle{color: 'black'}
        }
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        Text{text: 'X';anchors.centerIn: parent}
        MouseArea{
            anchors.fill: parent
            onClicked: apps.showLog=false
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