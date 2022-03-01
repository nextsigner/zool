import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: app
    visible: true
    width: app.fs*10
    height: Screen.desktopAvailableHeight-app.fs*3
    x: (Screen.width-app.width)/2+xOffSet
    y: app.fs*2.5
    color: 'black'
    property int xOffSet: 0
    property int fs: Screen.width*0.02
    property string textData: '?'
    property var dataList: []
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: 'transparent'
            border.width: b?3:0
            border.color: 'red'
            property bool b: false
            Timer{
                running: true
                repeat: true
                interval: 1000
                onTriggered: parent.b=!parent.b
            }
        }
        Flickable{
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: data.contentHeight+app.fs*2
            Text{
                id: data
                font.pixelSize: apps.iwFs
                color: 'white'
                width: xApp.width-app.fs
                anchors.top: parent.top
                anchors.topMargin: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
            }
            ListView{
                id: lv
                width: app.width
                height: app.height
                delegate: comp
                model: lm
                ListModel{
                    id: lm
                    function addItem(data){
                        return {
                            d: data
                        }
                    }
                }
                Component{
                    id: comp
                    Rectangle{
                        width: lv.width
                        height: txtData.contentHeight+app.fs*0.5
                        color: !isTit?(selected?'white':'black'):'red'
                        property bool selected: index===lv.currentIndex
                        property bool isTit: false//d.indexOf('GENERALI')>=0
                        onSelectedChanged: {
                            //if(selected&&isTit)lv.currentIndex++
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: lv.currentIndex=index
                        }
                        Text{
                            id: txtData
                            text: d
                            color: !selected?'white':'black'
                            font.pixelSize: !parent.isTit?(selected?apps.iwFs*1.5:apps.iwFs):apps.iwFs
                            width: parent.width-app.fs*0.5
                            wrapMode: Text.WordWrap
                            anchors.centerIn: parent
                        }
                        Component.onCompleted: {
                            if(d.indexOf('<h2>')>=0){
                                isTit=true
                            }
                        }
                    }
                }
            }
        }
//        MouseArea{
//            anchors.fill: parent
//            onDoubleClicked: app.close()
//        }

    }
    Shortcut{
        sequence: 'Esc'
        onActivated: app.close()
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(lv.currentIndex<lm.count-1){
                lv.currentIndex++
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(lv.currentIndex>0){
                lv.currentIndex--
            }
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(apps.iwFs>app.fs*0.5){
                apps.iwFs-=1
            }
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(apps.iwFs<app.fs*2){
                apps.iwFs+=1
            }
        }
    }

    Component.onCompleted: {
        //let txt='Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo Este es un texto de ejemplo '
        data.text=app.textData

        for(var i=0;i<dataList.length;i++){
            lm.append(lm.addItem(dataList[i]))
        }

        raise();
        forceActiveFocus();
        requestActivate();
    }
}
