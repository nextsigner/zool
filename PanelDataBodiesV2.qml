import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "Funcs.js" as JS
import "./comps" as Comps

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    state: 'show'
    property var uJson
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.parent.width
            }
        }
    ]
    Behavior on x{NumberAnimation{duration: app.msDesDuration}}
    Row{
        width: parent.width-r.border.width*2
        anchors.horizontalCenter: parent.horizontalCenter
        Comps.XBodies{id: xBodiesInt; isBack: false}
        Comps.XBodies{id: xBodiesExt; isBack: true}
    }
    Rectangle{
        width: labelCargando.contentWidth+app.fs*0.25
        height: labelCargando.contentHeight+app.fs*0.25
        radius: app.fs*0.25
        border.width: 2
        border.color: apps.fontColor
        color: apps.backgroundColor
        opacity: !app.ev?(xBodiesInt.opacity===1.0?0.0:1.0):(xBodiesInt.opacity===1.0&&xBodiesExt.opacity===1.0?0.0:1.0)
        anchors.centerIn: parent
        Text{
            id: labelCargando
            text: 'Cargando'
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    function loadJson(json){
        xBodiesInt.loadJson(json)
    }
    function loadJsonBack(json){
        xBodiesExt.loadJson(json)
    }
}
