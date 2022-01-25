import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1
import "../"
import "../Funcs.js" as JS
import "../Extra.js" as EXTRA

Rectangle{
    id: r
    width: r.parent.width
    height: r.parent.height
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    anchors.centerIn: parent
    //property alias objPanelSabianos: panelSabianos
    //property string parentState: panelRemoto
    //    onParentStateChanged: {
    //        if(panelRemoto.state==='show')prs.state='show'
    //    }
    Settings{
        id: prs
        fileName: unik.getPath(4)+'/panleRemoto.cfg'
        property string state: 'show'
        property int currentViewIndex: 0
        onStateChanged: panelRemoto.state=state
    }
    SwipeView{
        id: view
        currentIndex: prs.currentViewIndex
        onCurrentIndexChanged: prs.currentViewIndex=currentIndex
        anchors.fill: parent
        //Información
        Item{
            id:xShowIW
            width: r.width
            height: r.height
            Column{
                id: col
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Button{
                    text: apps.chat?'No Chatear con el Programador':'Chatear con el Programador'
                    //width: implicitContentWidth+app.fs*0.5
                    height: app.fs*0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        apps.chat=!apps.chat
                    }
                }
                Button{
                    text: chat.onTop?'Chat detras de todo':'Chat encima de todo'
                    //width: implicitContentWidth+app.fs*0.5
                    height: app.fs*0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: apps.chat
                    onClicked: {
                        chat.onTop=!chat.onTop
                    }
                }

                Text{
                    text: '<b>Repositorio Quirón</b>'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    width: r.width-app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                }
                Text{
                    text: 'De momento solo hay información de Plutón, Saturno y otros incompletos.\nPodes colaborar enviando información al correo nextsigner@gmail.com'
                    font.pixelSize: app.fs*0.35
                    color: 'white'
                    width: r.width-app.fs
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox{
                    id: cbPlanetas
                    model: app.planetas
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox{
                    id: cbSign
                    model: app.signos
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox{
                    id: cbCasas
                    model: ['Casa 1', 'Casa 2', 'Casa 3', 'Casa 4', 'Casa 5', 'Casa 6', 'Casa 7', 'Casa 8', 'Casa 9', 'Casa 10', 'Casa 11', 'Casa 12']
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Button{
                    text: 'Obtener Información'
                    width: implicitContentWidth+app.fs*0.5
                    height: app.fs*0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        let s1=app.planetasRes[cbPlanetas.currentIndex]
                        let s2=app.objSignsNames[cbSign.currentIndex]
                        let s3=cbCasas.currentIndex+1
                        app.uSon=s1+'_'+s2+'_'+s3
                        console.log('uSon: '+app.uSon)
                        JS.showIW()
                    }
                }

                //Clonar para comparar DEV rueda Ext y rueda Int
                Button{
                    text: 'Cargar Clon Exterior'
                    font.pixelSize: app.fs*0.35
                    //width: app.fs*1.5
                    height: app.fs*0.6
                    visible: false
                    onClicked: {
                        let j=JSON.parse(app.currentData)
                        let p=j.params
                        JS.loadFromArgsBack(p.d, p.m, p.a, p.h, p.min, p.gmt, p.lat, p.lon, p.alt?p.alt:0, p.nom, p.ciudad, 'trans', false)
                    }
                }
                Button{
                    text: 'Cargar Tránsitos Absolutos'
                    font.pixelSize: app.fs*0.35
                    //width: app.fs*1.5
                    height: app.fs*0.6
                    onClicked: {
                        JS.loadTransNow()
                    }
                }


            }
        }

        //Controles
        Item{
            width: r.width
            height: r.height
            Flickable{
                width: r.width
                height: r.height
                contentHeight: col2.height+app.fs*3
                Column{
                    id: col2
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.5
                    Item{width: 1;height: app.fs}
                    Text{
                        text: '<b>Controles</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.width-app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    //Ver animación de plenetas.
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Destello de planetas';font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                        CheckBox{
                            checked: apps.anColorXAs
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckStateChanged: apps.anColorXAs=checked
                        }
                    }
                    //Ver Lineas de Grados
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Ver Lineas de Grados';font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                        CheckBox{
                            checked: apps.showNumberLines
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckStateChanged: apps.showNumberLines=checked
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Ver Ejes de Casas';font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                        CheckBox{
                            checked: apps.showHousesAxis
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckStateChanged: apps.showHousesAxis=checked
                        }
                    }
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Ancho del Ejes de Casas';font.pixelSize: app.fs*0.5;anchors.horizontalCenter: parent.horizontalCenter}
                        SpinBox{
                            stepSize: 2.0
                            value: apps.widthHousesAxis
                            onValueChanged: {
                                if(value<3||value>12){
                                    apps.widthHousesAxis=1.0
                                }else{
                                    apps.widthHousesAxis=value
                                }
                            }
                        }
                    }
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Ancho del Circulo signos';font.pixelSize: app.fs*0.5;anchors.horizontalCenter: parent.horizontalCenter}
                        SpinBox{
                            stepSize: app.fs*0.1
                            value: apps.sweFs
                            onValueChanged: {
                                if(value<app.fs*0.5||value>app.fs*2){
                                    apps.sweFs=app.fs
                                }else{
                                    apps.sweFs=value
                                }
                            }
                        }
                    }
                    Column{
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text:'Sistema de Casas por defecto'; color: apps.fontColor;font.pixelSize: app.fs*0.5}
                        ComboBox{
                            id: cbHsys
                            width: r.width-app.fs
                            height: app.fs*0.75
                            model: app.ahysNames
                            currentIndex: app.ahys.indexOf(apps.defaultHsys)
                            anchors.horizontalCenter: parent.horizontalCenter
                            //anchors.bottom: parent.bottom
                            onCurrentIndexChanged: {
                                if(currentIndex===app.ahys.indexOf(apps.defaultHsys))return
                                apps.defaultHsys=app.ahys[currentIndex]
                                JS.showMsgDialog('Zool Informa', 'El sistema de casas por defecto ha sido cambiado.', 'Se ha seleccionado el sistema de casas '+app.ahysNames[currentIndex]+'. Este sistema de casas será utilizado cada vez que se crea una carta.')
                            }
                        }
                    }

                    //Tamaño de PanelElementos
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Tamaño de Lista de Elementos';font.pixelSize: app.fs*0.5;anchors.horizontalCenter: parent.horizontalCenter}
                        SpinBox{
                            stepSize: 1.0
                            value: 50
                            onValueChanged: {
                                let fs=apps.elementsFs
                                let v=fs/100*(100-value)
                                //                                log.l('app.fs: '+app.fs)
                                //                                log.l('fs: '+fs)
                                //                                log.l('v: '+v)
                                apps.elementsFs=app.fs+(app.fs-v)
                                //                                log.l('apps.elementsFs: '+apps.elementsFs)
                                //                                log.l('\n')
                                //log.x+=10
                                if(apps.elementsFs<app.fs||apps.elementsFs>app.fs*2){
                                    apps.elementsFs=app.fs
                                }
                                panelElements.update()

                                //                                if(apps.elementsFs>app.fs&&apps.elementsFs<app.fs*2){
                                //                                    apps.elementsFs+=0.2
                                //                                }else{
                                //                                    apps.elementsFs=app.fs
                                //                                }
                            }
                        }
                    }
                    //Tamaño de Botones
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Tamaño de Botones';font.pixelSize: app.fs*0.5;anchors.horizontalCenter: parent.horizontalCenter}
                        SpinBox{
                            stepSize: 1.0
                            value: apps.botSizeSpinBoxValue
                            onValueChanged: {
                                let nv=parseInt(app.fs*0.5+value*0.25)
                                apps.botSize=nv
                                apps.botSizeSpinBoxValue=value
                            }
                        }
                    }
                }
            }
        }

        //Controles Adicionales
        Item{
            width: r.width
            height: r.height
            Flickable{
                width: r.width
                height: r.height
                contentHeight: colControlesAd.height+app.fs*3
                Column{
                    id: colControlesAd
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.5
                    Item{width: 1;height: app.fs}
                    Text{
                        text: '<b>Controles Adicionales</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.width-app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    //Crear Carta Mundial de Ahora
                    Button{
                        text: 'Crear Mapa Mundial de Ahora'
                        height: app.fs*0.6
                        onClicked: {
                            var offset = new Date().getTimezoneOffset();
                            //console.log('Zool GMT Client: '+offset);
                            let date0=new Date(Date.now())
                            date0=date0.setMinutes(date0.getMinutes()+offset)
                            //let d1=new Date.UTC(2021,7,20,11,34,0)
                            var date = new Date(date0);
                            var now_utc =  Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(),
                                                    date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds());

                            let d1=new Date(now_utc);
                            //console.log('Zool United KIngston Hour: '+d1.toString());
                            JS.loadFromArgs(d1.getDate(), parseInt(d1.getMonth() +1),d1.getFullYear(), d1.getHours(), d1.getMinutes(), 0.0,53.4543314,-2.113293483429562,6, "United Kingston "+d1.getDate()+"-"+parseInt(d1.getMonth() +1)+"-"+d1.getFullYear(), "United Kingston England", "vn", true)
                        }
                    }


                    //Mostrar plenetas automáticamente.
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{text: 'Mostrar Automático'; font.pixelSize: app.fs*0.5; color:apps.fontColor; anchors.verticalCenter: parent.verticalCenter}
                        CheckBox{
                            checked: tAutoMaticPlanets.running
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckStateChanged: {
                                tAutoMaticPlanets.currentJsonData=app.currentData
                                tAutoMaticPlanets.running=checked
                                if(checked)app.currentPlanetIndex=0
                            }
                            Timer{
                                id: tAutoMaticPlanets
                                running: false
                                repeat: true
                                interval: 10000
                                property string currentJsonData: ''
                                onTriggered: {
                                    if(tAutoMaticPlanets.currentJsonData!==app.currentData){
                                        tAutoMaticPlanets.stop()
                                        return
                                    }
                                    if(app.currentPlanetIndex<16){
                                        app.currentPlanetIndex++
                                    }else{
                                        app.currentPlanetIndex=-1
                                    }
                                }
                            }
                        }
                    }

                    //Información General de Astromedicina.
                    Button{
                        text: 'Ver Información Astromedicina'
                        height: app.fs*0.6
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            xInfoData.loadData('./resources/astromedicina.html')
                        }
                    }
                    Button{
                        text: 'Mostrar Información de Archivo'
                        width: implicitContentWidth+app.fs*0.5
                        height: app.fs*0.6
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            let s=''
                            s+='Nombre del archivo actual: '+apps.url+'\n\n'
                            s+='Json Data: '+app.fileData
                            log.l(s)
                            log.visible=true
                        }
                    }
                }
            }
        }

        //Colores
        Item{
            width: r.width
            height: r.height
            Flickable{
                width: r.width
                height: r.height
                contentHeight: colColores.height+app.fs*3
                Column{
                    id: colColores
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.5
                    Item{width: 1;height: app.fs}
                    Text{
                        text: '<b>Colores</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        width: parent.width-app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text: 'Tema Claro'
                            onClicked: {
                                apps.fontColor='#000000'
                                apps.backgroundColor='#ffffff'
                                apps.lupaColor='#000000'
                                apps.xAsColor='black'
                                apps.xAsColorBack='white'
                                apps.xAsBackgroundColorBack='black'
                                apps.houseLineColor='blue'
                                apps.houseLineColorBack='red'
                            }
                        }
                        Button{
                            text: 'Tema Oscuro'
                            onClicked: {
                                apps.fontColor='#ffffff'
                                apps.backgroundColor='#000000'
                                apps.lupaColor='#ffffff'
                                apps.xAsColor='white'
                                apps.xAsColorBack='black'
                                apps.xAsBackgroundColorBack='white'
                                apps.houseLineColor='white'
                                apps.houseLineColorBack='red'
                            }
                        }
                        Button{
                            text: 'Tema Verde Negro'
                            onClicked: {
                                apps.fontColor='#71FC30'
                                apps.backgroundColor='#000000'
                                apps.lupaColor='#71FC30'
                                apps.xAsColor='#71FC30'
                                apps.xAsColorBack='#000000'
                                apps.xAsBackgroundColorBack='#71FC30'
                                apps.houseLineColor='white'
                                apps.houseLineColorBack='gray'
                            }
                        }
                    }

                    //Seleccionar colores de Casas
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Seleccionar color de casa'
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                        }
                        Rectangle{
                            width: app.fs
                            height: width
                            border.width: 1
                            border.color: apps.fontColor
                            color: apps.houseColor
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                text: 'Interior'
                                font.pixelSize: app.fs*0.25
                                color: apps.fontColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    rep.model=EXTRA.getArrayColors()
                                    xColorSelector.mod=0
                                    xColorSelector.parent=colSelectHouses
                                    xColorSelector.visible=true
                                }
                            }
                        }
                        Rectangle{
                            width: app.fs
                            height: width
                            border.width: 1
                            border.color: apps.fontColor
                            color: apps.houseColorBack
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                text: 'Exterior'
                                font.pixelSize: app.fs*0.25
                                color: apps.fontColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    rep.model=EXTRA.getArrayColors()
                                    xColorSelector.mod=1
                                    xColorSelector.parent=colSelectHouses
                                    xColorSelector.visible=true
                                }
                            }
                        }
                    }
                    Column{id: colSelectHouses}

                    //Seleccionar color de linea de casas exterior
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'Seleccionar color de\nlinea de casa exterior'
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: app.fs
                            height: width
                            border.width: 1
                            border.color: apps.fontColor
                            color: apps.houseLineColor
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                text: 'Interior'
                                font.pixelSize: app.fs*0.25
                                color: apps.fontColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    rep.model=EXTRA.getArrayColors()
                                    xColorSelector.mod=2
                                    xColorSelector.parent=colSelectLineHouses
                                    xColorSelector.visible=true
                                }
                            }
                        }
                        Rectangle{
                            width: app.fs
                            height: width
                            border.width: 1
                            border.color: apps.fontColor
                            color: apps.houseLineColorBack
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                text: 'Exterior'
                                font.pixelSize: app.fs*0.25
                                color: apps.fontColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    rep.model=EXTRA.getArrayColors()
                                    xColorSelector.mod=3
                                    xColorSelector.parent=colSelectLineHouses
                                    xColorSelector.visible=true
                                }
                            }
                        }
                    }
                    Column{id: colSelectLineHouses}
                }
            }
        }

        //Informacion / Hacer Aportes / Apoyar proyecto
        Item{
            id:xShowIW2
            width: r.width
            height: r.height
            Flickable{
                width: r.width
                height: r.height
                contentHeight: txt.contentHeight
                Text{
                    id: txt
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    width: parent.width-app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }

        //Aviso del Programador
        Item{
            width: r.width
            height: r.height
            Flickable{
                width: r.width
                height: r.height
                contentHeight: txt2.contentHeight
                Text{
                    id: txt2
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    width: parent.width-app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Row{
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.15
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.15
        spacing:app.fs*0.15
        Repeater{
            model: 3
            Rectangle{
                visible: index===0&&view.currentIndex>0||index===2&&view.currentIndex<view.count-1
                width: index!==1?app.fs*0.5:r.width-app.fs
                height: index!==1?width:app.fs*0.5
                radius: width*0.15
                border.width: 1
                //opacity: index!==1?0.5:1.0
                anchors.verticalCenter: parent.verticalCenter
                Text{text: index===0?'<':'>';font.pixelSize: parent.width*0.8;anchors.centerIn: parent}
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(index===0){
                            view.currentIndex--
                        }else{
                            view.currentIndex++
                        }
                    }
                }
            }
        }
    }
    Timer{
        running: panelRemoto.state==='show'
        repeat: true
        interval: 1000
        onTriggered: prs.state=panelRemoto.state
    }
    Rectangle{
        id: xColorSelector
        width: r.width-app.fs
        height: ((r.width-app.fs)/16)*16
        border.width: 2
        border.color: apps.fontColor
        visible: false
        property int mod: -1
        Grid{
            id: griColors
            width: r.width-app.fs
            height: ((r.width-app.fs)/16)*16
            columns: 16
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: rep
                Rectangle{
                    width: (r.width-app.fs)/16
                    height: width
                    color: modelData
                    border.width: 1
                    border.color: apps.fontColor
                    Timer{
                        id: tSetHouseColor1
                        running: false
                        repeat: false
                        interval: 2000
                        onTriggered: sweg.objHousesCircle.loadHouses(app.currentJson)
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(xColorSelector.mod===0){
                                apps.houseColor=modelData
                                xColorSelector.visible=false
                                tSetHouseColor1.start()
                                //JS.loadJson(apps.url)
                            }
                            if(xColorSelector.mod===1){
                                apps.houseColorBack=modelData
                                xColorSelector.visible=false
                                sweg.objHousesCircleBack.loadHouses(app.currentJsonBack)
                                //JS.loadJson(apps.url)
                            }
                            if(xColorSelector.mod===2){
                                apps.houseLineColor=modelData
                                xColorSelector.visible=false
                                sweg.objHousesCircleBack.loadHouses(app.currentJsonBack)
                                //JS.loadJson(apps.url)
                            }
                            if(xColorSelector.mod===3){
                                apps.houseLineColorBack=modelData
                                xColorSelector.visible=false
                                sweg.objHousesCircleBack.loadHouses(app.currentJsonBack)
                                //JS.loadJson(apps.url)
                            }
                        }
                    }
                }
            }
            //Component.onCompleted: rep.model=EXTRA.getArrayColors()
        }
    }

    Component.onCompleted: {
        //console.log('PanelRemoto Cfg path: '+unik.getPath(4))
        panelRemoto.z=panelSabianos.z-1
        panelRemoto.state=prs.state

        let t='<br/>
<h2>Tengo una idea para aportar, ¿Cómo solicito su implementación?</h2>
<p>Si tenés alguna idea sobre alguna herramienta, comando, función o característica para agregar a este panel y a la aplicación, comunicate directamente con el programador de la aplicación.</p>
<p>Para comunicarte con el programador, estas son las vías de comunicación:</p>
<ul>
    <li><b>Grupo de Facebook: </b> <a href="https://www.facebook.com/groups/386512166139820" style="color: '+apps.fontColor+';">Aplicación Astrológica Zool</a></li>
    <li><b>Correo Electrónico: </b> <a href="mailto:nextsigner@gmail.com" style="color: '+apps.fontColor+';">nextsigner@gmail.com</a></li>
    <li><b>Whatsapp: </b> +54 11 3802 4370</li>
</ul>

<br/><br/>
<h2>¿Cómo puedo apoyar  este proyecto?</h2>
<p>Si queres apoyar el desarrollo de esta aplicación, tenés, aquí tenés una lista de opciones.</p>
<ul>
    <li><b>Utilizando y Probando esta aplicación: </b> <a href="https://www.facebook.com/groups/386512166139820" style="color: '+apps.fontColor+';">Avisar sobre un error o comentar</a></li>
    <li><b>Aportando información al Repositorio Quirón: </b> <a href="https://github.com/nextsigner/quiron" style="color: '+apps.fontColor+';">Ir al Repositorio Quirón</a></li>
    <li><b>Enviar dinero por PapPal: </b> <a href="https://paypal.me/lucentrica" style="color: '+apps.fontColor+';">https://paypal.me/lucentrica</a></li>
    <li><b>Enviar dinero por Ualá MasterCard: </b> CVU: Alias NEXTSIGNER.UALA</li>
</ul>
<br/><br/>
'
        txt.text=t

        t='<br/>
<h1>Aviso del Programador</h1>
<h2>¿Qué estoy progrmando en la aplicación actualmente?</h2>
<ul>
    <li>Optimizando el script Python para calcular las velocidades de los planetas y así poder identificar o detectar cual está retrógrado.</li>
<li>Estoy agregando una rueda zodiacal extra para mostrar las revoluciones solares conjuntamente con la carta natal.</li>
<li>Agregando información sobre el porcentáje de los elementos fuego, tierra, aire y agua en la GUI o Interfaz Gráfica de Usuario.</li>
</ul>
<h2>¿Que se agregará a esta aplicación?</h2>
<p>Actualmente usted está utilizando Zool en su versión '+version+'. Las modificaciones mencionadas serán agregadas a la versión 0.4</p>
<h2>¿Ha encontrado alguna falla o desea aportar alguna idea?</h2>
<p>Puede comunicarse directamente conmigo a las siguientes vías de comunicación.</p>
<ul>
    <li><b>Grupo de Facebook: </b> <a href="https://www.facebook.com/groups/386512166139820" style="color: '+apps.fontColor+';">Aplicación Astrológica Zool</a></li>
    <li><b>Correo Electrónico: </b> <a href="mailto:nextsigner@gmail.com" style="color: '+apps.fontColor+';">nextsigner@gmail.com</a></li>
    <li><b>Whatsapp: </b> +54 11 3802 4370</li>
</ul>
<br/><br/>
'
        txt2.text=t
    }
}
