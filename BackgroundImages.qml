import QtQuick 2.0

Item {
    id: r
    width: sweg.width
    height: width
    anchors.centerIn: parent
    Rectangle{
        width: sweg.width
        height: width
        anchors.top: parent.verticalCenter
        color: '#ff8833'
        Rectangle{
            width: parent.width
            height: sweg.fs*0.75*0.5+housesCircle.wb
            color: 'red'
            anchors.bottom: parent.top
            anchors.topMargin: 4
        }
    }
}
