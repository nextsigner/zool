import QtQuick 2.12
import QtQuick.Controls 2.0
import "../Funcs.js" as JS

Column{
    id: r
    width: !app.ev?parent.width:parent.width*0.5
    opacity: 0.0
    property bool isBack: false
    property bool isLatFocus: false
    Behavior on opacity{NumberAnimation{id:numAn1;duration:10}}
    Rectangle{
        id: headerLv
        width: r.width
        height: app.fs*0.85
        color: r.isBack?apps.houseColorBack:apps.houseColor//apps.fontColor
        border.width: 1
        border.color: apps.fontColor
        Item{
            width: r.width
            height: txtTit.contentHeight
            anchors.centerIn: parent
            Text {
                id: txtTit
                text: 'Lista de Cuerpos'
                font.pixelSize: app.fs*0.4
                width: parent.width-app.fs*0.2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: r.isBack?apps.xAsColorBack:apps.xAsColor
                anchors.centerIn: parent
            }
        }
    }
    ListView{
        id: lv
        spacing: app.fs*0.25
        width: r.width-app.fs*0.25//r.parent.width-r.border.width*2
        height: xLatDer.height-headerLv.height
        delegate: compItemList
        model: lm
        cacheBuffer: 60
        displayMarginBeginning: lv.height*2
        displayMarginEnd: lv.height*2
        clip: true
        ScrollBar.vertical: ScrollBar {}
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListModel{
        id: lm
        function addItem(indexSign, indexHouse, grado, minuto, segundo, stringData){
            return {
                is: indexSign,
                ih: indexHouse,
                gdeg:grado,
                mdeg: minuto,
                sdeg: segundo,
                sd: stringData
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xItem
            width: lv.width
            height: !app.ev?txtData.contentHeight+app.fs*0.1:colTxtEV.height+app.fs*0.1//app.fs*0.6//txtData.contentHeight+app.fs*0.1
            color: !r.isBack?(index===app.currentPlanetIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.fontColor:apps.backgroundColor):(index===app.currentPlanetIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.fontColor:apps.backgroundColor)
            border.width: 1
            border.color: !r.isBack?apps.houseColor:apps.houseColorBack
            visible: !app.ev?txtData.width<xItem.width:true
            //anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity{NumberAnimation{duration: 250}}
            property bool textSized: false
            onTextSizedChanged: {}
            Rectangle{
                anchors.fill: parent
                color: !r.isBack?apps.houseColor:apps.houseColorBack
                opacity: 0.5
            }
            Text {
                id: txtData
                //text: sd
                font.pixelSize: app.fs
                textFormat: Text.RichText
                color: !r.isBack?(index===app.currentPlanetIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===app.currentPlanetIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                visible: !app.ev
                onVisibleChanged: {
                    if(!visible){
                        //font.pixelSize=app.fs
                    }
                }
                Timer{
                    running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                    repeat: true
                    interval: 50
                    onTriggered: {
                        tShow.restart()
                        parent.font.pixelSize-=1
                    }
                }
            }
            Column{
                id: colTxtEV
                anchors.centerIn: parent
                Text {
                    id: txtDataEV
                    font.pixelSize: app.fs//*0.4
                    //width: lv.width-app.fs*0.1
                    //wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: !r.isBack?(index===app.currentPlanetIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===app.currentPlanetIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
                Text {
                    id: txtDataEV2
                    font.pixelSize: app.fs//*0.4
                    textFormat: Text.RichText
                    color: !r.isBack?(index===app.currentPlanetIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===app.currentPlanetIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    anchors.horizontalCenter: parent.horizontalCenter
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(index>16){
                        if(!r.isBack){
                            sweg.objHousesCircle.currentHouse=index-16
                        }else{
                            sweg.objHousesCircleBack.currentHouse=index-16
                        }
                    }else{
                        if(!r.isBack){
                            if(app.currentPlanetIndex!==index){
                                app.currentPlanetIndex=index
                            }else{
                                app.currentPlanetIndex=-1
                            }
                        }else{
                            if(app.currentPlanetIndexBack!==index){
                                app.currentPlanetIndexBack=index
                            }else{
                                app.currentPlanetIndexBack=-1
                            }
                        }
                    }
                }
                onDoubleClicked: {
                    if(index<=16){
                        JS.showIW()
                    }
                }
            }
            //            Rectangle{
            //                width: 50
            //                height: 50
            //                color: 'red'
            //                visible: index>16
            //            }
            Component.onCompleted: {
                txtData.text=sd.replace(/ @ /g, ' ')
                let m0=sd.split(' @ ')
                txtDataEV.text=m0[0]//sd.replace(/ @ /g, '<br />')
                if(m0[1]){
                    txtDataEV2.text=m0[1]
                }else{
                    log.ls('sd: '+sd, 0, 500)
                }

                //cantTextSized++
                //log.ls('cantTextSized: '+index, 0, 500)
                //                log.l('sd: '+sd)
                //                log.l('xItem.width: '+xItem.width)
                //                log.l('xItem.height: '+xItem.height)
                //                log.visible=true
            }
        }
    }
    Timer{
        id: tShow
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            numAn1.duration=250
            r.opacity=1.0
        }
    }
    function loadJson(json){
        numAn1.duration=1
        r.opacity=0.0
        lm.clear()
        let jo
        let o
        var ih
        for(var i=0;i<15;i++){
            jo=json.pc['c'+i]
            ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            var s = '<b>'+jo.nom+'</b> en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' <b>Casa:</b> ' +ih
            if(jo.retro===0&&i!==10&&i!==11)s+=' <b>R</b>'
            //console.log('--->'+s)
            lm.append(lm.addItem(jo.is, ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
            //            if(i===0){
            //                houseSun=ih
            //            }
        }
        let o1=json.ph['h1']
        //s = 'Ascendente °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        s = '<b>Ascendente</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 1'
        lm.append(lm.addItem(o1.is, 1, o1.rsgdeg, o1.mdeg, o1.sdeg,  s))
        o1=json.ph['h10']
        //s = 'Medio Cielo °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        s = '<b>Medio Cielo</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 10'
        lm.append(lm.addItem(o1.is, 10, o1.rsgdeg, o1.mdeg, o1.sdeg, s))
        //log.ls('o1.is: '+o1.is, 0, 500)

        //Load Houses
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            //s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            s = '<b>Casa</b> '+i+' en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ''
            lm.append(lm.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
            //lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }


        //Load Houses
        /*lm2.clear()
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }*/

        //if(app.mod!=='rs'&&app.mod!=='pl')r.state='show'
    }
}
