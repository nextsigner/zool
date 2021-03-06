import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.12
import ZoolButton 1.0
import "../../Funcs.js" as JS

Rectangle {
    id: r
    width: xLatIzq.width
    height: xLatIzq.height-xPanelesTits.height-app.fs*0.5
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias ti: txtDataSearch
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm
    property string currentFile: ''
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
//    visible: itemIndex===sv.currentIndex
//    onSvIndexChanged: {
//        if(svIndex===itemIndex){
//            tF.restart()
//        }else{
//            tF.stop()
//        }
//    }
    Timer{
        id: tF
        running: r.visible
        repeat: false
        interval: 1500
        onTriggered: {
            txtDataSearch.focus=true
            txtDataSearch.selectAll()
        }
    }
    FolderListModel{
        id: flm
        folder: 'file:'+apps.jsonsFolder
        showDirs: false
        showFiles: true
        showHidden: false
        nameFilters: [ "*.json" ]
        sortReversed: true
        sortField: FolderListModel.Time
        onCountChanged: {
            updateList()
        }
    }
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id:xTit
            width: lv.width
            height: app.fs*1.5
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor//txtDataSearch.focus?'red':'white'
            anchors.horizontalCenter: parent.horizontalCenter
            TextInput {
                id: txtDataSearch
                //text: 'Archivos svIndex: '+r.svIndex+' itemIndex: '+r.itemIndex+' focus:'+focus
                text: 'Archivos'
                font.pixelSize: app.fs*0.5
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                color: apps.fontColor
                focus: r.itemIndex===r.svIndex
                anchors.centerIn: parent
                Keys.onReturnPressed: {
                    JS.loadJson(lm.get(lv.currentIndex).fileName)
                    r.state='hide'
                }
                Keys.onRightPressed: {
                    //JS.loadJsonNow(lm.get(lv.currentIndex).fileName)
                    //r.state='hide'
                }
                Keys.onDownPressed: {
                    //Qt.quit()
                    //focus=false
                    //xApp.focus=true
                }
                onTextChanged: {
                    updateList()
                }
                onFocusChanged: {
                    if(focus){
                        apps.zFocus='xLatIzq'
                        selectAll()
                    }

                }
                Rectangle{
                    width: parent.width+app.fs
                    height: parent.height+app.fs
                    color: 'transparent'
                    //border.width: 2
                    //border.color: 'white'
                    z: parent.z-1
                    anchors.centerIn: parent
                }
            }
        }
        Item{
            id:xTitInf
            width: lv.width
            height: txtTitInfo.contentHeight+app.fs*0.25
            //color: apps.backgroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: txtTitInfo
                //text: '<b>Cantidad Total:</b> '+flm.count+' <b>Encontrados:</b> '+lm.count+'<br><b>Carpeta: </b>'+(''+flm.folder).replace('file://', '')
                font.pixelSize: app.fs*0.35
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
        ListView{
            id: lv
            width: r.width
            height: r.height-xTit.height-xTitInf.height
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            clip: true
            onCurrentIndexChanged: r.currentFile=lm.get(currentIndex).fileName
        }
    }
    ListModel{
        id: lm
        function addItem(vFileName, vData, vTipo){
            return {
                fileName: vFileName,
                dato: vData,
                tipo: vTipo
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xDatos
            width: lv.width
            height: colDatos.height+app.fs
            color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            border.width: index===lv.currentIndex?4:2
            border.color: 'white'
            property bool selected: index===lv.currentIndex
            MouseArea{
                anchors.fill: parent
                onClicked: lv.currentIndex=index
                onDoubleClicked: {
                    JS.loadJson(fileName)
                    r.state='hide'
                }
            }
            Column{
                id: colDatos
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Text {
                    id: txtData
                    //text: dato
                    font.pixelSize: app.fs*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataExtra
                    font.pixelSize: app.fs*0.35
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: xDatos.selected
                    //anchors.centerIn: parent
                }
                ZoolButton{
                    id: btnLoadExt
                    text:'Cargar como Sinastr??a'
                    anchors.right: parent.right
                    anchors.rightMargin: app.fs*0.1
                    visible: index===lv.currentIndex && tipo !== 'rs'  && tipo !== 'sin'
                    colorInverted: true
                    onClicked: {
                        //let fromTipo='vn'
                        let tipo=JSON.parse(app.currentData).params.tipo
                        if(tipo==='vn'){
                            xDataBar.stringMiddleSeparator='Sinastr??a'
                            app.mod='sin'
                            JSON.parse(app.currentData).params.tipo='sin'
                        }
                        JS.loadJsonBack(fileName)
                        r.state='hide'
                    }
                }
            }
            Rectangle{
                width: txtDelete.contentWidth+app.fs*0.35
                height: width
                radius: app.fs*0.3
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.3
                anchors.top: parent.top
                anchors.topMargin: app.fs*0.3
                color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                visible: index===lv.currentIndex
                Text {
                    id: txtDelete
                    text: 'X'
                    font.pixelSize: app.fs*0.25
                    anchors.centerIn: parent
                    color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
                }
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked: deleteVnData(fileName)
                }
            }
            Component.onCompleted: {
                let m0=dato.split('<!-- extra -->')
                txtData.text=m0[0]
                txtDataExtra.text=m0[1]
            }
        }
    }
    function deleteVnData(fileName){
        unik.deleteFile(fileName)
        let fn=fileName.replace('cap_', '').replace('.png', '')
        let jsonFileName=fn+'.json'
        unik.deleteFile(jsonFileName)
        updateList()
    }
    function getEdad(dateString) {
        let hoy = new Date()
        let fechaNacimiento = new Date(dateString)
        let edad = hoy.getFullYear() - fechaNacimiento.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento.getMonth()
        if (
                diferenciaMeses < 0 ||
                (diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento.getDate())
                ) {
            edad--
        }
        return edad
    }
    function updateList(){
        lv.currentIndex=-1
        lm.clear()
        for(var i=0;i<flm.count;i++){
            //let file='/home/ns/nsp/uda/astrologica/jsons/'+flm.get(i, 'fileName')
            //let file=app.mainLocation+'/jsons/'+flm.get(i, 'fileName')
            let file=apps.jsonsFolder+'/'+flm.get(i, 'fileName')
            let fn=file//.replace('cap_', '').replace('.png', '')
            let jsonFileName=fn
            //console.log('FileName: '+jsonFileName)

            let jsonFileData=unik.getFile(jsonFileName)
            jsonFileData=jsonFileData.replace(/\n/g, '')
            //console.log(jsonFileData)
            if(jsonFileData.indexOf(':NaN,')>=0)continue
            let jsonData
            try {
                jsonData=JSON.parse(jsonFileData)
                let nom=''+jsonData.params.n.replace(/_/g, ' ')
                if((jsonData.params.tipo==='rs' && jsonData.paramsBack) || (jsonData.params.tipo==='sin' && jsonData.paramsBack)){
                    nom=''+jsonData.paramsBack.n.replace(/_/g, ' ')
                }
                if(nom.toLowerCase().indexOf(txtDataSearch.text.toLowerCase())>=0){
                    if(jsonData.asp){
                        //console.log('Aspectos: '+JSON.stringify(jsonData.asp))
                    }
                    let vd=jsonData.params.d
                    let vm=jsonData.params.m
                    let va=jsonData.params.a
                    let vh=jsonData.params.h
                    let vmin=jsonData.params.min
                    let vgmt=jsonData.params.gmt
                    let vlon=jsonData.params.lon
                    let vlat=jsonData.params.lat
                    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
                    let edad=' <b>Edad:</b> '+getEdad(""+va+"/"+vm+"/"+vd+" "+vh+":"+vmin+":00")
                    let stringEdad=edad.indexOf('NaN')<0?edad:''

                    //Date of Make File
                    let d=new Date(jsonData.params.ms)
                    let dia=d.getDate()
                    let mes=d.getMonth() + 1
                    let anio=d.getFullYear()
                    let hora=d.getHours()
                    let minuto=d.getMinutes()
                    let sMkFile='<b>Creado: </b>'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto+'hs'
                    let sModFile='<b>Modificado:</b> Nunca'
                    if(jsonData.params.msmod){
                        d=new Date(jsonData.params.ms)
                        dia=d.getDate()
                        mes=d.getMonth() + 1
                        anio=d.getFullYear()
                        hora=d.getHours()
                        minuto=d.getMinutes()
                        sModFile='<b>Modificado: </b>'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto+'hs'
                    }
                    let sDataFile='<b>Tiene informaci??n:</b> No'
                    if(jsonData.params.data){
                        sDataFile='<b>Tiene informaci??n:</b> Si'
                    }
                    let stipo=''
                    if(jsonData.params.tipo==='vn'){
                        stipo='Carta Natal'
                    }else if(jsonData.params.tipo==='sin'){
                        stipo='Sinastr??a'
                    }else if(jsonData.params.tipo==='rs'){
                        stipo='Revoluci??n Solar'
                    }else if(jsonData.params.tipo==='trans'){
                        stipo='Tr??nsitos'
                    }else{
                        stipo='Desconocido'
                    }

                    let textData=''
                        +'<b>'+nom+'</b>'
                        +'<p style="font-size:'+parseInt(app.fs*0.5)+'px;">'+vd+'/'+vm+'/'+va+' '+vh+':'+vmin+'hs GMT '+vgmt+stringEdad+'</p>'
                        +'<p style="font-size:20px;"><b> '+vCiudad+'</b></p>'
                        +'<!-- extra -->'
                        +'<b>Tipo: </b>'+stipo
                        +'<p style="font-size:'+parseInt(app.fs*0.35)+'px;"> <b>long:</b> '+vlon+' <b>lat:</b> '+vlat+'</p>'
                        +sMkFile+'<br>'
                        +sModFile+'<br>'
                        +sDataFile+'<br>'
                        +'<b>Archivo: </b>'+file
                    //xNombre.nom=textData
                    lm.append(lm.addItem(file,textData, jsonData.params.tipo))
                }
                if(r.itemIndex===r.svIndex)txtDataSearch.focus=true
                //txtDataSearch.selectAll()
            } catch (e) {
                console.log('Error Json panelFileLoader: '+jsonFileData)
                return false;
            }
        }
    }
    function enter(){
        JS.loadJson(r.currentFile)
        r.currentIndex=-1
        //r.state='hide'
    }
}
