import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    state: 'hide'
    property alias listModel: lm
    property alias currentIndex: lv.currentIndex
    property int currentIndexSign: -1
    property var uJson
    //Behavior on height{NumberAnimation{duration:app.msDesDuration;easing.type: Easing.InOutQuad}}
    onCurrentIndexChanged: {
        if(!r.enabled)return
        sweg.objHousesCircle.currentHouse=currentIndex
        swegz.sweg.objHousesCircle.currentHouse=currentIndex
    }
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
    onStateChanged: {
        if(state==='hide')return
        JS.raiseItem(r)
        //xApp.focus=true
    }
    onXChanged: {
        if(x===0){
            //txtDataSearch.selectAll()
            //txtDataSearch.focus=true
        }
    }
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: app.fs*0.25
        Rectangle{
            width: lv.width
            height: app.fs
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            XText {
                text: '<b>Zool v'+version+' by @nextsigner</b>'
                font.pixelSize: app.fs*0.5
                width: contentWidth
                anchors.centerIn: parent
            }
        }
        ListView{
            id: lv
            width: r.width-r.border.width*2
            height: r.height*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            //currentIndex: app.currentPlanetIndex
            clip: true
            visible: lmBack.count<=0//!housesCircleBack.visible
            header: Rectangle{
                width: r.width
                height: app.fs
                color: 'red'
            }
            onCurrentIndexChanged: {
                //console.log('panelbodies currentIndex: '+currentIndex)
                //let item=lm.get(currentIndex)
                //app.uSon='_'+app.objSignsNames[item.is]+'_1'
                if(!r.enabled)return
                //r.currentIndexSign=lm.get(currentIndex).is
            }
        }
        ListView{
            id: lvBack
            width: r.width-r.border.width*2
            height: r.height*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemListBack
            model: lmBack
            //currentIndex: app.currentPlanetIndex
            clip: true
            visible: housesCircleBack.visible
            header: Rectangle{
                id: headerLvBack
                width: lv.width//txtTitBack.contentHeight+app.fs*0.1
                height: app.fs
                color: apps.fontColor
                border.width: 1
                border.color: apps.fontColor
                Row{
                    Repeater{
                        model: ['Interior', 'Exterior']
                        Item{
                            width: lv.width*0.5
                            height: headerLvBack.height
                            XText {
                                id: txtTitBack
                                text: modelData
                                font.pixelSize: app.fs*0.4
                                width: parent.width-app.fs*0.2
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                                color: apps.backgroundColor
                                anchors.centerIn: parent
                            }
                            Rectangle{
                                width: 2
                                height: parent.height
                                color: apps.backgroundColor
                                x:-1
                                visible: index===1
                            }
                        }
                    }
                }
//                Rectangle{
//                    width: parent.width
//                    height: 1
//                    color: apps.fontColor
//                    anchors.bottom: parent.bottom
//                }
            }
            onCurrentIndexChanged: {

            }
        }
        ListView{
            id: lv2
            width: r.width-r.border.width*2
            height: r.height*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList2
            model: lm2
            //currentIndex: app.currentPlanetIndex
            clip: true
            onCurrentIndexChanged: {
                //console.log('panelbodies currentIndex: '+currentIndex)
                //let item=lm.get(currentIndex)
                //app.uSon='_'+app.objSignsNames[item.is]+'_1'
                if(!r.enabled)return
                //r.currentIndexSign=lm.get(currentIndex).is
            }
        }
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
    ListModel{
        id: lmBack

        function addItem(indexSign, indexHouse, grado, minuto, segundo, stringData, indexSignBack, indexHouseBack, gradoBack, minutoBack, segundoBack, stringDataBack){
            return {
                is: indexSign,
                ih: indexHouse,
                gdeg:grado,
                mdeg: minuto,
                sdeg: segundo,
                sd: stringData,
                isBack: indexSignBack,
                ihBack: indexHouseBack,
                gdegBack:gradoBack,
                mdegBack: minutoBack,
                sdegBack: segundoBack,
                sdBack: stringDataBack
            }
        }
    }
    ListModel{
        id: lm2
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
            width: lv.width
            height: txtData.contentHeight+app.fs*0.1
            color: index===app.currentPlanetIndex?apps.fontColor:apps.backgroundColor
            border.width: index===app.currentPlanetIndex?2:0
            border.color: apps.fontColor
            XText {
                id: txtData
                text: sd
                font.pixelSize: app.fs*0.4
                width: parent.width-app.fs*0.2
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                color: index===app.currentPlanetIndex?apps.backgroundColor:apps.fontColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    app.currentPlanetIndex=index
                }
                Rectangle{
                    anchors.fill: parent
                    color: 'red'
                    visible: false
                }
            }
        }
    }
    Component{
        id: compItemListBack
        Rectangle{
            width: lv.width
            height: txtData.contentHeight+app.fs*0.1
            Row{
                Rectangle{
                    width: lv.width*0.5
                    height: txtData.contentHeight+app.fs*0.1
                    color: index===app.currentPlanetIndex?apps.fontColor:apps.backgroundColor
                    border.width: index===app.currentPlanetIndex?2:0
                    border.color: apps.fontColor
                    XText {
                        id: txtDataBack
                        text: sdBack
                        font.pixelSize: app.fs*0.4
                        width: parent.width-app.fs*0.2
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        //textFormat: Text.RichText
                        color: index===app.currentPlanetIndex?apps.backgroundColor:apps.fontColor
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            app.currentPlanetIndex=index
                        }
                        Rectangle{
                            anchors.fill: parent
                            color: 'red'
                            visible: false
                        }
                    }
                    Rectangle{height: 1; width: parent.parent.width;color: apps.fontColor;anchors.bottom: parent.bottom}
                }
                Rectangle{width: 1; height: parent.parent.height;color: apps.fontColor}
                Rectangle{
                    width: lv.width*0.5
                    height: txtData.contentHeight+app.fs*0.1
                    color: index===app.currentPlanetIndexBack?apps.fontColor:apps.backgroundColor
                    border.width: index===app.currentPlanetIndexBack?2:0
                    border.color: apps.fontColor
                    XText {
                        id: txtData
                        text: sd
                        font.pixelSize: app.fs*0.4
                        width: parent.width-app.fs*0.2
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        //textFormat: Text.RichText
                        color: index===app.currentPlanetIndexBack?apps.backgroundColor:apps.fontColor
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            app.currentPlanetIndexBack=index
                        }
                        Rectangle{
                            anchors.fill: parent
                            color: 'red'
                            visible: false
                        }
                    }
                    Rectangle{height: 1; width: parent.parent.width;color: apps.fontColor;anchors.bottom: parent.bottom}
                }
            }
        }
    }
    Component{
        id: compItemList2
        Rectangle{
            width: lv.width
            height: txtData.contentHeight+app.fs*0.1
            color: index+1===sweg.objHousesCircle.currentHouse?apps.fontColor:apps.backgroundColor
            border.width: index+1===sweg.objHousesCircle.currentHouse?2:0
            border.color: apps.fontColor
            XText {
                id: txtData
                text: sd
                font.pixelSize: app.fs*0.4
                width: parent.width-app.fs*0.2
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                color: index+1===sweg.objHousesCircle.currentHouse?apps.backgroundColor:apps.fontColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sweg.objHousesCircle.currentHouse=index+1
                }
                Rectangle{
                    anchors.fill: parent
                    color: 'red'
                    visible: false
                }
            }
        }
    }
    function loadJson(json){
        r.uJson=json
        lm.clear()
        lmBack.clear()
        let jo
        let o

        for(var i=0;i<15;i++){
            jo=json.pc['c'+i]
            var s = jo.nom+ ' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]+ '  - Casa ' +jo.ih
            //console.log('--->'+s)
            lm.append(lm.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
            //            if(i===0){
            //                houseSun=jo.ih
            //            }
        }
        let o1=json.ph['h1']
        s = 'Ascendente °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        lm.append(lm.addItem(o1.is, 1, o1.rsgdeg, o1.mdeg, o1.sdeg,  s))
        o1=json.ph['h10']
        s = 'Medio Cielo °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        lm.append(lm.addItem(o1.is, 10, o1.rsgdeg, o1.mdeg, o1.sdeg, s))

        //Load Houses
        lm2.clear()
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }

        if(app.mod!=='rs'&&app.mod!=='pl')r.state='show'
    }
    function loadJsonBack(json){
        lmBack.clear()
        let jo
        let joBack
        let o
        let oBack
        for(var i=0;i<15;i++){
            jo=json.pc['c'+i]
            joBack=uJson.pc['c'+i]
            var s = jo.nom+ ' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ '\n' +app.signos[jo.is]+ '  - Casa ' +jo.ih
            var sBack = joBack.nom+ ' °' +joBack.rsgdeg+ '\'' +joBack.mdeg+ '\'\'' +joBack.sdeg+ '\n' +app.signos[joBack.is]+ '  - Casa ' +joBack.ih
            //console.log('--->'+s)
            lmBack.append(lmBack.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s, joBack.is, joBack.ih, joBack.rsgdeg, joBack.mdeg, joBack.sdeg, sBack))

        }
        let o1=json.ph['h1']
        s = 'Ascendente °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        lmBack.append(lmBack.addItem(o1.is, 1, o1.rsgdeg, o1.mdeg, o1.sdeg,  s))
        o1=json.ph['h10']
        s = 'Medio Cielo °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        lmBack.append(lmBack.addItem(o1.is, 10, o1.rsgdeg, o1.mdeg, o1.sdeg, s))


        //Load Houses
        lm2.clear()
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }

        if(app.mod!=='rs'&&app.mod!=='pl')r.state='show'
    }
}
