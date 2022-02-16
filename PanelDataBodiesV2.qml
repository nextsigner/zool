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
    //property alias listModel: lm
    //property alias currentIndex: lv.currentIndex
    //property int currentIndexSign: -1
    property var uJson
    //property bool showBack: false
    //Behavior on height{NumberAnimation{duration:app.msDesDuration;easing.type: Easing.InOutQuad}}
//    onCurrentIndexChanged: {
//        if(!r.enabled)return
//        sweg.objHousesCircle.currentHouse=currentIndex
//        //swegz.sweg.objHousesCircle.currentHouse=currentIndex
//    }
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                //x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                //x:r.parent.width
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
    function loadJson(json){
        xBodiesInt.loadJson(json)
    }
    function loadJsonBack(json){
        xBodiesExt.loadJson(json)
    }
}
