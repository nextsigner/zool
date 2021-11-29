﻿import QtQuick 2.12
//import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import Qt.labs.folderlistmodel 2.12
import Qt.labs.settings 1.1

import unik.UnikQProcess 1.0

import "Funcs.js" as JS
//import "Extra.js" as EXTRA
import "./comps" as Comps
import "./comps/num" as Num

AppWin {
    id: app
    visible: true
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    title: 'Zool '+version
    property bool dev: false
    property string mainLocation: ''
    property string pythonLocation: Qt.platform.os==='windows'?'./Python/python.exe':'python3'
    property int fs: Qt.platform.os==='linux'?width*0.02:width*0.02
    property string url
    property string mod: 'mi'

    property bool enableAn: false
    property int msDesDuration: 500
    //property var api: [panelNewVNA, panelFileLoader]


    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''

    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1
    property int currentSignIndex: 0

    property date currentDate
    property string currentNom: ''
    property string currentFecha: ''
    property string currentLugar: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentGradoSolar: -1
    property int currentMinutoSolar: -1
    property int currentSegundoSolar: -1
    property real currentGmt: 0
    property real currentLon: 0.0
    property real currentLat: 0.0

    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false
    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    //property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Gauquelin', 'Morinus']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']
    /*
                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus
*/

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1
    property string stringRes: "Res"+Screen.width+"x"+Screen.height

    property bool ev: false //Exterior Visible

    property bool sspEnabled: false

    onCurrentPlanetIndexChanged: {
        if(sspEnabled){
            if(currentPlanetIndex>=-1&&currentPlanetIndex<10){
                app.ip.opacity=1.0
                app.ip.children[0].ssp.setPlanet(currentPlanetIndex)
            }else{
                app.ip.opacity=0.0
            }
        }
        panelDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>14){
            /*if(currentPlanetIndex===15){
                sweg.objHousesCircle.currentHouse=1
                swegz.sweg.objHousesCircle.currentHouse=1
            }
            if(currentPlanetIndex===16){
                sweg.objHousesCircle.currentHouse=10
                swegz.sweg.objHousesCircle.currentHouse=10
            }*/
        }
    }
    onCurrentGmtChanged: {
        if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        //tReload.restart()
    }
    onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        //tReloadBack.restart()
    }
    onCurrentDateChanged: {
        if(app.currentData===''||app.setFromFile)return
        xDataBar.state='show'
        let a=currentDate.getFullYear()
        let m=currentDate.getMonth()
        let d=currentDate.getDate()
        let h=currentDate.getHours()
        let min=currentDate.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    onCurrentDateBackChanged: {
        //if(app.currentDataBack===''||app.setFromFile)return
        //if(app.currentDataBack===''||app.setFromFile)return
        if(app.mod==='trans'){
            JS.loadTransFromTime(app.currentDateBack)
            //return
        }
        xDataBar.state='show'
        let a=currentDateBack.getFullYear()
        let m=currentDateBack.getMonth()
        let d=currentDateBack.getDate()
        let h=currentDateBack.getHours()
        let min=currentDateBack.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        tReloadBack.restart()
    }
    FontLoader {name: "FontAwesome";source: "qrc:/resources/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "qrc:/resources/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "qrc:/resources/typewriter.ttf";}
    Settings{
        id: apps
        fileName:documentsPath+'/zool_'+Qt.platform.os+'.cfg'
        property string host: 'http://localhost'
        property bool newClosed: false

        property string url: ''
        property string urlBack: ''
        property bool showTimes: false
        property bool showLupa: false
        property bool showSWEZ: true
        property bool showDec: false

        //Houses
        property string defaultHsys: 'T'
        property string currentHsys: 'T'
        property string houseColor: "#2CB5F9"
        property string houseColorBack: 'red'
        property bool showHousesAxis: false
        property int widthHousesAxis: 3.0
        property string houseLineColor: 'white'
        property string houseLineColorBack: 'red'

        //XAs
        property color xAsColor: 'white'
        property color xAsColorBack: 'black'
        property color xAsBackgroundColorBack: 'white'
        property real xAsBackgroundOpacityBack: 0.5
        property bool anColorXAs: false

        //Asp
        property int aspLineWidth: 3

        //Swe
        property string swegMod: 'ps'
        property bool showNumberLines: true
        property int sweFs: Screen.width*0.02
        property bool showAspCircle: true
        property bool showAspCircleBack: true

        //GUI
        property bool showLog: false
        property bool showMenuBar: true
        property bool enableBackgroundColor: false
        property string backgroundColor: "black"
        property string fontFamily: "ArialMdm"
        property string fontColor: "white"
        property int fontSize: app.fs*0.5
        property int botSize: app.fs*0.5
        property int botSizeSpinBoxValue: 50
        property real elementsFs: Screen.width*0.02

        property int lupaMod: 2
        property int lupaBorderWidth: 3
        property string lupaColor: "white"
        property real lupaOpacity: 0.5
        property int lupaRot: 0
        property int lupaX: Screen.width*0.5
        property int lupaY: Screen.height*0.5
        property int lupaAxisWidth: 1
        property int lupaCenterWidth: 20

        property int editorFs: Screen.width*0.01
        property bool editorShowNumberLines: false
        property int editorTextFormat: 0

        //Panel Sabianos
        property real panelSabianosFz: 1.0
        //Panel AspTrans
        property int currentIndexP1: 0
        property int currentIndexP2: 0
        property int currentIndexAsp: 0
        property int currentAspCantAniosSearch: 20
        property bool autoShow: false

        property bool chat: false

        property bool backgroundImagesVisible: false
        property bool lt:false
        property bool enableFullAnimation: false

        property string jsonsFolder: documentsPath
        onShowLupaChanged: sweg.restoreZoom()
        onEnableBackgroundColorChanged: {
            if(enableBackgroundColor){
                ip.hideSS()
            }else{
                ip.showSS()
            }
        }
    }
    menuBar: Comps.XMenuBar {
        id: menuBar
    }
    Timer{
        id: tReload
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            JS.setNewTimeJsonFileData(app.currentDate)
            JS.runJsonTemp()
        }
    }
    Timer{
        id: tReloadBack
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            JS.setNewTimeJsonFileDataBack(app.currentDateBack)
            JS.runJsonTempBack()
        }
    }
    Item{
        id: xApp
        anchors.fill: parent
        Item{
            id: xSwe1
            width: xApp.width-xLatIzq.width-xLatDer.width
            height: xLatIzq.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            SweGraphicV2{id: sweg;objectName: 'sweg'}
        }
        Rectangle{
            id: xMsgProcDatos
            width: txtPD.contentWidth+app.fs
            height: app.fs*4
            color: 'black'
            border.width: 2
            border.color: 'white'
            visible: false
            anchors.centerIn: parent
            XText {
                id: txtPD
                text: 'Procesando datos...'
                //font.pixelSize: app.fs
                //color: 'white'
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: parent.visible=false
            }
        }
    }
    Item{
        id: capa101
        anchors.fill: xApp
        XDataBar{id: xDataBar}
        Row{
            //anchors.centerIn: parent
            anchors.top: xDataBar.bottom
            anchors.bottom: xBottomBar.top
            Item{
                id: xLatIzq
                width: xApp.width*0.2
                height: parent.height
                Item{
                    //anchors.fill: parent
                    width: parent.width
                    height: panelRemoto.state==='show'?parent.height*0.5:parent.height
                    SweGraphicZoom{id: swegz; visible:apps.showSWEZ&&apps.showLupa}
                }
                Item{
                    anchors.fill: parent
                    PanelSabianos{id: panelSabianos; state: 'show'}
                    PanelRemoto{
                        id: panelRemoto;
                        state: 'show'
                    }
                    //PanelZonaMes{id: panelZonaMes;}
                    PanelAspTransList{id: panelAspTransList}
                    PanelRsList{id: panelRsList}
                    PanelFileLoader{id: panelFileLoader}
                    PanelNewVNA{id: panelNewVNA}

                }
                Rectangle{
                    width: app.fs*0.5
                    height: width
                    radius: width*0.15
                    border.width: 1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: app.fs*0.25
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs*0.25
                    opacity: panelRemoto.x!==0?1.0:0.0
                    Behavior on opacity{NumberAnimation{duration: 500}}
                    Text{text: '>';font.pixelSize: parent.width*0.8;anchors.centerIn: parent}
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            panelRemoto.state='show'
                        }
                    }
                }
            }
            Item{
                id: xMed
                width: xApp.width-xLatIzq.width-xLatDer.width
                height: parent.height
                Comps.PanelElements{id: panelElements}
                Comps.PanelElementsBack{id: panelElementsBack}
                Item{
                    id: xControlsTime
                    width: controlsTime.width
                    height: controlsTime.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTime.showCT=!xControlsTime.showCT
                    }
                    Item{
                        id:xIconClock
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        anchors.right: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTime.showCT=!xControlsTime.showCT
                                xControlsTimeBack.showCT=false
                            }
                        }
                        Text{
                            id:ccinit
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColor
                            anchors.centerIn: parent
                        }
                    }
                    Comps.ControlsTime{
                        id: controlsTime
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }
                }
                Item{
                    id: xControlsTimeBack
                    width: controlsTimeBack.width
                    height: controlsTimeBack.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                    }
                    Item{
                        id:xIconClockBack
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.horizontalCenterOffset: width+app.fs*0.5
                        anchors.left: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                                xControlsTime.showCT=false
                            }
                        }
                        Text{
                            id:ccinitBack
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColorBack//apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                    Comps.ControlsTime{
                        id: controlsTimeBack
                        isBack: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }
                }
            }
            Item{
                id: xLatDer
                width: xApp.width*0.2
                height: parent.height

                //Chat{id: chat; z: onTop?panelPronEdit.z+1:panelControlsSign.z-1}
                PanelControlsSign{id: panelControlsSign}
                PanelDataBodies{id: panelDataBodies}
                PanelPronEdit{id: panelPronEdit;}

            }
        }
        XLupa{
            id: xLupa;
            visible: apps.showLupa
            onXChanged: setGui()
            onYChanged: setGui()
            function setGui(){
                if(panelRsList.state==='show'){
                    panelRsList.state='hide'
                }
                if(panelFileLoader.state==='show'){
                    panelFileLoader.state='hide'
                }
                if(panelNewVNA.state==='show'){
                    panelNewVNA.state='hide'
                }
                if(xBottomBar.state==='show'){
                    xBottomBar.state='hide'
                }
                apps.lupaX=x
                apps.lupaY=y
            }
        }
        XLupaMan{}
        Comps.XLayerTouch{id: xLayerTouch}
        XTools{
            id: xTools
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: app.width*0.2
        }
        XBottomBar{id: xBottomBar}
        XSabianos{id: xSabianos}
        XInfoData{id: xInfoData}
        Editor{id: xEditor}
        Num.NumCiclosVida{id: ncv; anchors.fill: parent}
    }
    //XSweZoom{id: xSweZoom}
    Init{longAppName: 'Zool'; folderName: 'zool'}
    Comps.XSelectColor{
        id: xSelectColor
        width: app.fs*8
        height: app.fs*8
        c: 'backgroundColor'
    }
    QtObject{
        id: setHost
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let h=(''+data).replace(/\n/g, '')
                apps.host=h
                let ms=new Date(Date.now()).getTime()
                if(!apps.newClosed){
                    JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/windowstart/main.qml?r='+ms, setZoolStart)
                }
            }else{
                console.log('Data '+isData+': '+data)
                JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    QtObject{
        id: setZoolStart
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let comp=Qt.createQmlObject(data, app, 'xzoolstart')
            }else{
                console.log('setXZoolStart Data '+isData+': '+data)
                JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    LogItem{id: log}
    //    Text{
    //        text: '->'+menuBar.expanded
    //        font.pixelSize: app.fs*3
    //        color: 'red'
    //    }
    Comps.MenuPlanets{id: menuPlanets}
    Component.onCompleted: {
        //log.visible=true
        //log.l('--------->'+EXTRA.getColor(10))
        //        for(let i=0;i<256;i++){
        //            log.l('--------->'+i+': '+EXTRA.getArrayColor()[i]+'\n')
        //        }
        if(Qt.application.arguments.indexOf('-dev')>=0){
            app.dev=true
        }
        JS.setFs()
        app.mainLocation=unik.getPath(5)
        if(Qt.platform.os==='windows'){
            app.mainLocation="\""+app.mainLocation+"\""
        }
        console.log('app.mainLocation: '+app.mainLocation)
        console.log('documentsPath: '+documentsPath)
        console.log('Init app.url: '+app.url)
        if(apps.url!==''){
            console.log('Cargando al iniciar: '+apps.url)
            JS.loadJson(apps.url)
        }else{
            console.log('Loading United Kingston now...')
            let d=new Date(Date.now())
            JS.loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), 0.0,53.4543314,-2.113293483429562,6, "United Kingston", "United Kingston England", "pron", true)
        }
        //JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/zool', setHost)
    }
}
