import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    visible: false
    border.width: 2
    border.color: apps.fontColor
    clip: true
    property alias flk: flLog
    property alias text: taLog.text
    property bool ww: true
    MouseArea{
        anchors.fill: parent
        onClicked: r.visible=false
    }
    Flickable{
        id: flLog
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: taLog.contentHeight
        clip: true
        TextEdit{
            id: taLog
            width: r.width-app.fs//*0.5
            //wrapMode: r.ww?Text.WordWrap:Text.WrapAnywhere
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            //background: Rectangle{color: 'transparent'}
            //enabled: false
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
                r.visible=false
                r.visible=apps.showLog
            }
        }
    }
    function l(d){
        taLog.text+=d+'\n'
        flLog.contentY=taLog.contentHeight-r.height
    }
    function clear(){
        taLog.text=''
        //taLog.clear()
    }
    function cp(){
        taLog.selectAll()
        taLog.copy()
    }
}
