import QtQuick 2.7
import QtQuick.Controls 2.12
import "Funcs.js" as JS
import "./comps" as Comps

Item {
    id: r
    width: parent.height-app.fs*3
    height: width
    anchors.centerIn: parent
    //anchors.fill: parent
    opacity: 0.0
    //anchors.centerIn: parent
    //anchors.verticalCenterOffset: verticalOffSet
    property int  verticalOffSet: xDataBar.state==='show'?sweg.fs*1.25:0
    property int fs: r.objectName==='sweg'?apps.sweFs:apps.sweFs*2
    property int w: fs
    property bool v: false
    property alias expand: planetsCircle.expand
    property alias objAspsCircle: aspsCircle
    property alias objPlanetsCircle: planetsCircle
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objSignsCircle: signCircle
    property alias objAscMcCircle: ascMcCircle
    property alias objEclipseCircle: eclipseCircle
    property int speedRotation: 1000
    property var aStates: ['ps', 'pc', 'pa']
    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property string currentHsys: apps.currentHsys

    state: apps.swegMod//aStates[0]
    states: [
        State {//PS
            name: aStates[0]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PC
            name: aStates[1]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(15 +6):r.fs*(15 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*6:sweg.width-sweg.fs*6-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PA
            name: aStates[2]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        }
    ]

    onStateChanged: {
        swegz.sweg.state=state
        apps.swegMod=state
    }
    Behavior on opacity{NumberAnimation{duration: 1500}}
    Behavior on verticalOffSet{NumberAnimation{duration: app.msDesDuration}}
    Item{id: xuqp}
    Flickable{
        id: flick
        anchors.fill: parent
        //clip: true
        // Map
        Rectangle {
            id: rect
            border.width: 2
            width: Math.max(xSweg.width, flick.width)
            height: Math.max(xSweg.height, flick.height)
            color: 'transparent'
            //visible: !apps.showLupa
            transform: Scale {
                id: scaler
                origin.x: pinchArea.m_x2
                origin.y: pinchArea.m_y2
                xScale: pinchArea.m_zoom2
                yScale: pinchArea.m_zoom2
            }
            PinchArea {
                id: pinchArea
                anchors.fill: parent
                enabled: !apps.showLupa
                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 1.0
                property real m_zoom2: 1.0
                property real m_max: 6
                property real m_min: 1.0

                onPinchStarted: {
                    console.log("Pinch Started")
                    m_x1 = scaler.origin.x
                    m_y1 = scaler.origin.y
                    m_x2 = pinch.startCenter.x
                    m_y2 = pinch.startCenter.y
                    rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                    rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                }
                onPinchUpdated: {
                    console.log("Pinch Updated")
                    m_zoom1 = scaler.xScale
                    var dz = pinch.scale-pinch.previousScale
                    var newZoom = m_zoom1+dz
                    if (newZoom <= m_max && newZoom >= m_min) {
                        m_zoom2 = newZoom
                    }
                }
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: rect
                    drag.filterChildren: true
                    enabled: !apps.showLupa

                    onWheel: {
                        console.log("Wheel Scrolled")
                        pinchArea.m_x1 = scaler.origin.x
                        pinchArea.m_y1 = scaler.origin.y
                        pinchArea.m_zoom1 = scaler.xScale
                        pinchArea.m_x2 = mouseX
                        pinchArea.m_y2 = mouseY

                        var newZoom
                        if (wheel.angleDelta.y > 0) {
                            newZoom = pinchArea.m_zoom1+0.1
                            if (newZoom <= pinchArea.m_max) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_max
                            }
                        } else {
                            newZoom = pinchArea.m_zoom1-0.1
                            if (newZoom >= pinchArea.m_min) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_min
                            }
                        }
                        rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                        rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)

                        console.debug(rect.width+" -- "+rect.height+"--"+rect.scale)

                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Click in child")
                    }
                }
            }
            Item{
                id: xSweg
                width: r.width*0.5
                height: width
                anchors.centerIn: parent
                //anchors.centerIn: parent
                MouseArea{
                    enabled: false
                    width: r.width*3
                    height: width
                    anchors.centerIn: parent
                    drag.target: xSweg
                    drag.axis: Drag.XAndYAxis
                    onDoubleClicked: {
                        xSweg.scale=1.0
                        //flkSweg.contentX=0-flkSweg.contentWidth*0.5
                        //flkSweg.contentY=0-flkSweg.contentHeight*0.5
                    }
                    onWheel: {
                        //apps.enableFullAnimation=false
                        if(wheel.modifiers == Qt.ControlModifier){
                            if(wheel.angleDelta.y>=0){
                                if(xSweg.scale<6.0){
                                    xSweg.scale+=0.1
                                }else{
                                    //xSweg.scale=1.0
                                }
                            }else{
                                if(xSweg.scale>1.0){
                                    xSweg.scale-=0.1
                                }else{
                                    //xSweg.scale=6.0
                                }
                            }
                            let pcW=wheel.x/xSweg.width*100
                            let pcH=wheel.y/xSweg.width*100
                            //log.l('pcw: '+pcW)
                            //log.visible=true
                            //log.width=xApp.width*0.2
                            //flkSweg.contentX=(xSweg.width*xSweg.scale)/100/pcW///flkSweg.contentWidth*100
                            //flkSweg.contentY=((flkSweg.contentWidth*0.25)/(pcH)*100)
                            //log.l('flkSweg.contentX: '+flkSweg.contentX)
                            //log.l('flkSweg.contentY: '+flkSweg.contentY)
                            //flkSweg.contentY=flkSweg.contentHeight/100*pcH
                        }
                    }
                }
                Rectangle{
                    id: bg
                    width: parent.width*10
                    height: width
                    color: backgroundColor
                    visible: signCircle.v
                }
                BackgroundImages{id: backgroundImages}
                Comps.HouseCircleBack{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircleBack
                    height: width
                    anchors.centerIn: signCircle
                    w: r.fs*6
                    widthAspCircle: aspsCircle.width
                    visible: app.ev
                    //visible: planetsCircleBack.visible
                }
                Comps.HouseCircle{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircle
                    height: width
                    anchors.centerIn: signCircle
                    w: r.fs*6
                    widthAspCircle: aspsCircle.width
                    visible: r.v
                }
                AxisCircle{id: axisCircle}
                NumberLines{}
                Comps.SignCircle{
                    id:signCircle
                    //width: planetsCircle.expand?r.width-r.fs*6+r.fs*2:r.width-r.fs*6
                    anchors.centerIn: parent
                    showBorder: true
                    v:r.v
                    w: r.w
                    onRotChanged: housesCircle.rotation=rot
                    //onShowDecChanged: Qt.quit()
                }
                AspCircle{
                    id: aspsCircle
                    rotation: signCircle.rot - 90 + 1
                }
                PlanetsCircle{
                    id:planetsCircle
                    height: width
                    anchors.centerIn: parent
                    //showBorder: true
                    //v:r.v
                }
                PlanetsCircleBack{
                    id:planetsCircleBack
                    height: width
                    anchors.centerIn: parent
                    visible: app.ev
                }
                AscMcCircle{id: ascMcCircle}
                EclipseCircle{
                    id: eclipseCircle
                    width: housesCircle.width
                    height: width
                }
            }
        }
    }


    PanelAspects{
        id: panelAspects
        anchors.bottom: parent.bottom
        anchors.bottomMargin: verticalOffSet
        anchors.left: parent.left
        anchors.leftMargin: 0-((xApp.width-r.width)/2)+swegz.width
        visible: r.objectName==='sweg'
        //Rectangle{anchors.fill: parent; color: 'red';border.width: 1;border.color: 'white'}
    }
    PanelAspectsBack{
        id: panelAspectsBack
        anchors.top: parent.top
        anchors.topMargin: xDataBar.state==='hide'?verticalOffSet*0.5:verticalOffSet*0.5-app.fs*0.25
        anchors.left: parent.left
        anchors.leftMargin: 0-((xApp.width-r.width)/2)+swegz.width+width
        transform: Scale{ xScale: -1 }
        rotation: 180
        visible: r.objectName==='sweg'&&planetsCircleBack.visible
    }
    //    Rectangle{
    //        color: 'red'
    //        border.color: 'blue'
    //        border.width: 10
    //        anchors.fill: parent
    //    }
    Rectangle{
        //Este esta en el centro
        visible: false
        opacity: 0.5
        width: r.fs*2//planetsCircle.children[0].fs*0.85+4
        height: width
        color: 'red'
        radius: width*0.5
        border.width: 2
        border.color: 'white'
        anchors.centerIn: parent
    }
    Timer{
        id: tLoadSin
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            let j=JSON.parse(app.fileData)
            //app.fileDataBack=JSON.stringify(j.paramsBack)
            let njson=JSON.parse('{}')
            njson.params=j.paramsBack
            JS.loadJsonFromParamsBack(njson)
            //loadSweJsonBack(j)
            //log.l(JSON.stringify(j.paramsBack))
            //log.visible=true
            //loadBack(current)
        }
    }
    Timer{
        id: tFirtShow
        running: false
        repeat: false
        interval: 2000
        onTriggered: r.opacity=1.0
    }
    //    Rectangle{
    //        width: app.fs*6
    //        height: width
    //        anchors.centerIn: parent
    //        Text{
    //            id: ihr
    //            font.pixelSize: app.fs*2
    //            anchors.centerIn: parent
    //        }
    //    }
    function loadSign(j){
        aspsCircle.clear()
        console.log('Ejecutando SweGraphic.loadSign()...')
        //unik.speak('load sign')
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(3000)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData).replace(/\\n/g, \'\')\n'
        c+='        app.currentJsonSignData=JSON.parse(json)\n'
        c+='        panelControlsSign.loadJson(app.currentJsonSignData)\n'
        c+='        app.mod="pl"\n'
        //c+='        if(panelZonaMes.state===\'show\')panelZonaMes.play()\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        //console.log(\'python3 /home/ns/nsp/uda/astrologica/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+'\')\n'
        c+='        run(\''+app.pythonLocation+' '+app.mainLocation+'/py/astrologica_swe_search_asc_aries.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodesign')
    }
    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //console.log(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        swegz.sweg.loadSweJson(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'sweg.load() python3 /media/ns/ZONA-A1/zool/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+'\')\n'
        c+='        run(\''+app.pythonLocation+' '+app.mainLocation+'/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        swegz.sweg.loadSweJsonBack(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'sweg.loadBack() python3 /media/ns/ZONA-A1/zool/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+'\')\n'
        c+='        run(\''+app.pythonLocation+' '+app.mainLocation+'/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        panelRsList.clear()
        //planetsCircleBack.visible=false
        //app.ev=false
        panelAspectsBack.visible=false
        sweg.objHousesCircle.currentHouse=-1
        swegz.sweg.objHousesCircle.currentHouse=-1
        app.currentPlanetIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)
        app.currentJson=j
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        ascMcCircle.loadJson(j)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        //planetsCircleBack.loadJson(j)
        panelAspects.load(j)
        panelDataBodies.loadJson(j)
        aspsCircle.load(j)
        panelElements.load(j)
        eclipseCircle.arrayWg=housesCircle.arrayWg
        eclipseCircle.isEclipse=-1
        //if(app.mod!=='rs'&&app.mod!=='pl'&&panelZonaMes.state!=='show')panelRsList.setRsList(61)
        r.v=true
        //apps.enableFullAnimation=true
        //let j=JSON.parse(app.fileData)
        if(j.params.tipo==='sin'){
            tLoadSin.start()
        }
        tFirtShow.start()
        panelSabianos.numSign=app.currentJson.ph.h1.is
        panelSabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        panelSabianos.loadData()
        if(apps.autoShow){
            panelSabianos.state='show'
        }
        panelAspTransList.state='hide'
        //        } catch(e) {
        //            //alert(e); // error in the above string (in this case, yes)!
        //            JS.showMsgDialog('Error de carga', 'Hay un error en la carga de los datos.', 'Error SweGraphic::loadSweJson(json)')
        //        }
    }
    function loadSweJsonBack(json){
        //console.log('JSON::: '+json)
        app.currentJsonBack=JSON.parse(json)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            panelElementsBack.load(j)
        }
        housesCircleBack.loadHouses(j)
        planetsCircleBack.loadJson(j)
        panelDataBodies.loadJsonBack(j)
        //planetsCircleBack.visible=true
        app.ev=true
    }
    function nextState(){
        let currentIndexState=r.aStates.indexOf(r.state)
        if(currentIndexState<r.aStates.length-1){
            currentIndexState++
        }else{
            currentIndexState=0
        }
        r.state=r.aStates[currentIndexState]
        swegz.sweg.state=r.state
    }
    function restoreZoom(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 1.0
        pinchArea.m_zoom2 = 1.0
        rect.x = 0
        rect.y = 0
    }
}
