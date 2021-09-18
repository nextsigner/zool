import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "comps" as Comps
import "Funcs.js" as JS
Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: 'black'
    border.width: 2
    border.color: 'white'
    x:0-r.width
    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uFileNameLoaded: ''

    state: 'hide'
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:0
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:0-r.width
            }
        }
    ]
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    onStateChanged: {
        if(state==='show')tiNombre.t.focus=true
        //JS.raiseItem(r)
        //xApp.focus=true
    }
    onXChanged: {
        if(x===0){
            //txtDataSearch.selectAll()
            //txtDataSearch.focus=true
        }
    }
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs
        Text{
            text: '<b>Crear nueva carta natal</b>'
            font.pixelSize: app.fs*0.65
            color: 'white'
        }

        Comps.XTextInput{
            id: tiNombre
            width: r.width-app.fs*0.5
            t.font.pixelSize: app.fs*0.65
            anchors.horizontalCenter: parent.horizontalCenter
            KeyNavigation.tab: tiFecha1.t
            t.maximumLength: 30
            onPressed: {
                tiFecha1.t.focus=true
                tiFecha1.t.selectAll()
            }
            Text {
                text: 'Nombre'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }

        Row{
            spacing: app.fs*0.1
            anchors.horizontalCenter: parent.horizontalCenter
            Comps.XText{text:'Fecha:'; t.font.pixelSize: app.fs*0.35;height: app.fs*0.8}
            Comps.XTextInput{
                id: tiFecha1;
                width: app.fs;
                t.font.pixelSize: app.fs*0.65;
                c: true
                KeyNavigation.tab: tiFecha2.t
                t.inputMask: "00"
                t.width: width
                onPressed: {
                    tiFecha2.t.focus=true
                    tiFecha2.t.selectAll()
                }
                Text {
                    text: 'Día'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }
            Text {
                text: '/'
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Comps.XTextInput{
                id: tiFecha2;
                width: app.fs;
                t.font.pixelSize: app.fs*0.65;
                c: true
                KeyNavigation.tab: tiFecha3.t
                t.inputMask: "00"
                t.width: width
                onPressed: {
                    tiFecha3.t.focus=true
                    tiFecha3.t.selectAll()
                }
                Text {
                    text: 'Mes'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }
            Text {
                text: '/'
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Comps.XTextInput{
                id: tiFecha3;
                width: app.fs*2;
                t.font.pixelSize: app.fs*0.65;
                c: true
                KeyNavigation.tab: tiHora1.t
                t.inputMask: "0000"
                t.width: width
                Text {
                    text: 'Año'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }
        }
        Row{
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Comps.XText{text:'Hora:'; t.font.pixelSize: app.fs*0.35;height: app.fs*0.8}
            Comps.XTextInput{
                id: tiHora1;
                width: app.fs;
                t.font.pixelSize: app.fs*0.65;
                c: true
                KeyNavigation.tab: tiHora2.t
                t.inputMask: "00"
                t.width: width
                //t.color: valid?'white':'red'
                t.color: 'white'
                property   bool valid: false
                onTextChanged: {
                    //                        let s=text.split(':')
                    //                        if(s[0].length<2||s[1].length<2){
                    //                            valid=false
                    //                        }else{
                    //                            valid=true
                    //                        }
                }
                Text {
                    text: 'Hora'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }
            Text {
                text: ':'
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Comps.XTextInput{
                id: tiHora2;
                width: app.fs;
                t.font.pixelSize: app.fs*0.65;
                c: true
                KeyNavigation.tab: tiCiudad.t
                t.inputMask: "00"
                t.width: width
                //t.color: valid?'white':'red'
                t.color: 'white'
                property   bool valid: false
                onTextChanged: {
                    //                        let s=text.split(':')
                    //                        if(s[0].length<2||s[1].length<2){
                    //                            valid=false
                    //                        }else{
                    //                            valid=true
                    //                        }
                }
                Text {
                    text: 'Minuto'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }

        }
        Comps.XTextInput{
            id: tiCiudad
            width: tiNombre.width
            t.font.pixelSize: app.fs*0.65;
            KeyNavigation.tab: tiGMT.t
            t.maximumLength: 50
            onTextChanged: {
                tSearch.restart()
                t.color='white'
            }
            Text {
                text: 'Lugar'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }
        Column{
            id: colLatLon
            anchors.horizontalCenter: parent.horizontalCenter
            visible: r.lat===r.ulat&&r.lon===r.ulon
            //height: !visible?0:app.fs*3
            Text{
                text: 'Lat:'+r.lat
                font.pixelSize: app.fs*0.5
                color: 'white'
                opacity: r.lat!==-100.00?1.0:0.0
            }
            Text{
                text: 'Lon:'+r.lon
                font.pixelSize: app.fs*0.5
                color: 'white'
                opacity: r.lon!==-100.00?1.0:0.0
            }
        }
        Column{
            visible: !colLatLon.visible
            //height: !visible?0:app.fs*3
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: 'Error: Corregir el nombre de ubicación'
                font.pixelSize: app.fs*0.25
                color: 'white'
                visible: r.ulat===-1&&r.ulon===-1
            }
            Text{
                text: 'Lat:'+r.ulat
                font.pixelSize: app.fs*0.5
                color: 'white'
                opacity: r.ulat!==-100.00?1.0:0.0
            }
            Text{
                text: 'Lon:'+r.ulon
                font.pixelSize: app.fs*0.5
                color: 'white'
                opacity: r.ulon!==-100.00?1.0:0.0
            }
        }
        Row{
            spacing: app.fs*0.5
            Comps.XText{text:'GMT:'; t.font.pixelSize: app.fs*0.35;height: app.fs*0.8}
            Comps.XTextInput{
                id: tiGMT;
                width: app.fs*2;
                t.font.pixelSize: app.fs*0.65;
                t.width: width
                c: true
                KeyNavigation.tab: botCrear
                t.validator: IntValidator {
                    bottom: parseInt(-11)
                    top: parseInt(12)
                }
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                id: botClear
                text: 'Limpiar'
                font.pixelSize: app.fs*0.5
                opacity:  r.lat!==-100.00||r.lon!==-100.00||tiNombre.text!==''||tiFecha1.text!==''||tiFecha2.text!==''||tiFecha3.text!==''||tiHora1.text!==''||tiHora2.text!==''||tiGMT.text!==''||tiCiudad.text!==''?1.0:0.0
                enabled: opacity===1.0
                onClicked: {
                    clear()
                }
            }
            Button{
                id: botCrear
                text: 'Crear'
                font.pixelSize: app.fs*0.5
                KeyNavigation.tab: tiNombre.t
                visible: r.ulat!==-1&&r.ulon!==-1&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''
                onClicked: {
                    searchGeoLoc(true)
                }
                Timer{
                    running: r.state==='show'
                    repeat: true
                    interval: 1000
                    onTriggered: {
                        let nom=tiNombre.t.text.replace(/ /g, '_')
                        let fileName=apps.jsonsFolder+'/'+nom+'.json'
                        if(unik.fileExist(fileName)){
                            r.uFileNameLoaded=tiNombre.text
                            let jsonFileData=unik.getFile(fileName)
                            let j=JSON.parse(jsonFileData)
                            if(tiFecha1.text.replace(/ /g, '')===''&&tiFecha2.text.replace(/ /g, '')===''&&tiFecha3.text.replace(/ /g, '')===''){
                                //unik.speak('set file')
                                let dia=''+j.params.d
                                if(parseInt(dia)<=9){
                                    dia='0'+dia
                                }
                                let mes=''+j.params.m
                                if(parseInt(mes)<=9){
                                    mes='0'+mes
                                }
                                //tiFecha.text=dia+'/'+mes+'/'+j.params.a
                                tiFecha1.text=dia
                                tiFecha2.text=mes
                                tiFecha3.text=j.params.a
                            }
                            if(tiHora1.text.replace(/ /g, '')===''){
                                //unik.speak('set file')
                                let hora=''+j.params.h
                                if(parseInt(hora)<=9){
                                    hora='0'+hora
                                }
                                let minuto=''+j.params.min
                                if(parseInt(minuto)<=9){
                                    minuto='0'+minuto
                                }
                                //tiHora.text=hora+':'+minuto
                                tiHora1.text=hora
                                tiHora2.text=minuto
                            }
                            if(tiGMT.text.replace(/ /g, '')===''){
                                tiGMT.text=j.params.gmt
                            }
                            if(tiCiudad.text.replace(/ /g, '')===''){
                                tiCiudad.text=j.params.ciudad
                            }
                            r.lat=j.params.lat
                            r.lon=j.params.lon
                            r.ulat=j.params.lat
                            r.ulon=j.params.lon
                            //let m0=tiFecha.t.text.split('/')
                            //if(m0.length!==3)return
                            let vd=parseInt(tiFecha1.t.text)
                            let vm=parseInt(tiFecha2.t.text)
                            //let va=parseInt(tiFecha3.t.text)
                            //m0=tiHora.t.text.split(':')
                            let vh=parseInt(tiHora1.t.text)
                            let vmin=parseInt(tiHora2.t.text)
                            let vgmt=tiGMT.t.text
                            let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
                            if(j.params.d!==vd||j.params.m!==vm||j.params.a!==va||j.params.h!==vh||j.params.min!==vmin||r.lat!==r.ulat||r.lon!==r.ulon){
                                botCrear.text='Modificar'
                            }else{
                                botCrear.text='[Crear]'
                            }
                        }else{
                            botCrear.text='Crear'
                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tSearch
        running: false
        repeat: false
        interval: 2000
        onTriggered: searchGeoLoc(false)
    }
    Item{id: xuqp}
    function searchGeoLoc(crear){
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='            console.log(logData)\n'
        c+='        let result=(\'\'+logData).replace(/\\n/g, \'\')\n'
        c+='        let json=JSON.parse(result)\n'
        c+='        if(json){\n'
        //c+='            console.log(JSON.stringify(json))\n'

        c+='                if(r.lat===-1&&r.lon===-1){\n'
        c+='                   tiCiudad.t.color="red"\n'
        c+='                }else{\n'
        c+='                   tiCiudad.t.color="white"\n'
        if(crear){
            c+='                r.lat=json.coords.lat\n'
            c+='                r.lon=json.coords.lon\n'
            c+='                    setNewJsonFileData()\n'
            c+='                    r.state=\'hide\'\n'
        }else{
            c+='                r.ulat=json.coords.lat\n'
            c+='                r.ulon=json.coords.lon\n'
            c+='                if(tiGMT.t.text===""){\n'
            c+='                    tiGMT.t.text=parseFloat(r.ulat / 10).toFixed(1)\n'
            c+='                }\n'
        }
        c+='                }\n'
        c+='        }else{\n'
        c+='            console.log(\'No se encontraron las cordenadas.\')\n'
        c+='        }\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        //c+='        console.log(\''+app.pythonLocation+' '+app.mainLocation+'/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+'\')\n'
        c+='        run(\''+app.pythonLocation+' '+app.mainLocation+'/py/geoloc.py "'+tiCiudad.t.text+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodenewvn')
    }
    function setNewJsonFileData(){
        console.log('setNewJsonFileData...')
        let unom=r.uFileNameLoaded.replace(/ /g, '_')
        let fileName=apps.jsonsFolder+'/'+unom+'.json'
        console.log('setNewJsonFileData() fileName: '+fileName)
        if(unik.fileExist(fileName)){
            unik.deleteFile(fileName)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let nom=tiNombre.t.text.replace(/ /g, '_')

        //let m0=tiFecha.t.text.split('/')
        //if(m0.length!==3)return
        let vd=parseInt(tiFecha1.t.text)
        let vm=parseInt(tiFecha2.t.text)
        let va=parseInt(tiFecha3.t.text)

        //m0=tiHora.t.text.split(':')
        let vh=parseInt(tiHora1.t.text)
        let vmin=parseInt(tiHora2.t.text)

        let vgmt=tiGMT.t.text
        let vlon=r.lon
        let vlat=r.lat
        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
        let j='{'
        j+='"params":{'
        j+='"tipo":"vn",'
        j+='"ms":'+ms+','
        j+='"n":"'+nom+'",'
        j+='"d":'+vd+','
        j+='"m":'+vm+','
        j+='"a":'+va+','
        j+='"h":'+vh+','
        j+='"min":'+vmin+','
        j+='"gmt":'+vgmt+','
        j+='"lat":'+vlat+','
        j+='"lon":'+vlon+','
        j+='"ciudad":"'+vCiudad+'"'
        j+='}'
        j+='}'
        app.currentData=j
        nom=tiNombre.t.text.replace(/ /g, '_')
        unik.setFile(apps.jsonsFolder+'/'+nom+'.json', app.currentData)
        //apps.url=app.mainLocation+'/jsons/'+nom+'.json'
        JS.loadJson(apps.jsonsFolder+'/'+nom+'.json')
        //runJsonTemp()
    }
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            searchGeoLoc(true)
        }
    }
    function clear(){
        r.ulat=-100
        r.ulon=-100
        tiNombre.t.text=''
        tiFecha1.t.text=''
        tiFecha2.t.text=''
        tiFecha3.t.text=''
        tiHora1.t.text=''
        tiHora2.t.text=''
        tiCiudad.t.text=''
        tiGMT.t.text=''
    }
}
