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
        ListView{
            id: lv
            spacing: app.fs*0.5
            width: app.width-app.fs*0.5
            height: app.height*0.5
            delegate: comp
            model: lm
            clip: false
            displayMarginEnd: height*3
            anchors.horizontalCenter: parent.horizontalCenter
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
                    id: xItemData
                    width: lv.width
                    height: !isSubTit?txtData.contentHeight+app.fs*0.5:txtData.contentHeight+app.fs*2
                    color: !isTit?'black':'white'
                    border.width: selected?2:0
                    border.color: 'white'
                    property bool selected: index===lv.currentIndex
                    property bool isTit: false//d.indexOf('GENERALI')>=0
                    property bool isSubTit: false
                    onSelectedChanged: {
                        //if(selected&&isTit)lv.currentIndex++
                        //if(selected)lv.contentY=xItemData.y
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: lv.currentIndex=index
                    }
                    Text{
                        id: txtData
                        text: d
                        color: !isTit?'white':'black'
                        font.pixelSize: !parent.isTit?(selected?apps.iwFs*1.5:apps.iwFs):apps.iwFs
                        width: parent.width-app.fs*0.5
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: !xItemData.isSubTit?0:app.fs
                        //anchors.centerIn: parent
                        Rectangle{
                            width: parent.width
                            height: 3
                            color: 'red'
                            anchors.bottom: parent.bottom
                            visible: xItemData.isSubTit
                        }
                    }
                    Component.onCompleted: {
                        if(d.indexOf('<h2>')>=0){
                            isTit=true
                        }
                        if(d.indexOf('POSITIVO:')>=0){
                            isSubTit=true
                        }
                        if(d.indexOf('NEGATIVO:')>=0){
                            isSubTit=true
                        }
                        if(d.indexOf('GENERALIDADES:')>=0){
                            isSubTit=true
                        }
                        if(d.indexOf('MEJORAR:')>=0){
                            isSubTit=true
                        }
                        if(d.indexOf('PALABRAS CLAVES:')>=0){
                            isSubTit=true
                        }
                    }
                }
            }
        }
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
        for(var i=0;i<dataList.length;i++){
            lm.append(lm.addItem(dataList[i]))
        }

        raise();
        forceActiveFocus();
        requestActivate();
    }
}
