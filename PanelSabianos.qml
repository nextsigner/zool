import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "./comps" as Comps
Rectangle {
    id: r
    color: 'white'
    width: parent.width
    height: parent.height//panelRemoto.state==='hide'?parent.height:parent.height-panelRemoto.height
    clip: true
    property string htmlFolder: ''
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property int numSign: 0
    property int numDegree: 0
    property int fs: width*0.025
    property real factorZoomByRes: 1.5
    property int currentInterpreter: 0

    property string uSAM: ''

    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex

    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: rowTit.height+app.fs*3
        Behavior on contentY{NumberAnimation{duration: 250}}
        Column{
            id: rowTit
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: currentSign
                text: '<b>Simbología de los Sabianos</b>'
                width: r.width-app.fs
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs*0.75*apps.panelSabianosFz
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.verticalCenter: parent.verticalCenter
            }
            Row{
                spacing: app.fs*0.5
                Text {
                    text:'<b>'+r.signos[r.numSign]+'</b>'
                    font.pixelSize: app.fs*0.75*apps.panelSabianosFz
                    anchors.verticalCenter: parent.verticalCenter
                }
                Item {
                    id: xSigno
                    width: app.fs*apps.panelSabianosFz
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        anchors.fill: xSigno
                        radius: app.fs*0.25
                        color: 'white'
                        border.width: 2
                        border.color: 'black'
                        Image {
                            id: sign
                            source: "./resources/imgs/signos/"+r.numSign+".svg"
                            width: xSigno.width*0.8
                            fillMode: Image.PreserveAspectFit
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Text{
                id: data
                width: r.width-app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: rowTit.bottom
                //anchors.topMargin: app.fs*0.5
                text: '<h1>Los Sabianos</h1>'
                font.pixelSize: app.fs*0.5*apps.panelSabianosFz
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
            }
        }
    }
    XText {
        id: currentDegree
        property string sd: '?'
        text: '<b>'+sd+'</b>'//+' ci:'+r.currentInterpreter+' ad:'+r.numDegree+' cs:'+r.numSign
        font.pixelSize: r.fs*2
        //color: 'white'
        anchors.bottom: parent.bottom
        visible: false
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onMouseXChanged: {
            rowBtns.opacity=1.0
            tHideRowBtns.restart()
        }
        onMouseYChanged: {
            rowBtns.opacity=1.0
            tHideRowBtns.restart()
        }
        onEntered: rowBtns.opacity=1.0
        onDoubleClicked: {
            xSabianos.numSign=r.numSign
            xSabianos.numDegree=r.numDegree
            xSabianos.visible=true
            xSabianos.loadData()
        }
    }
    Rectangle{
        width: app.fs*0.5
        height: width
        color: 'black'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        MouseArea{
            anchors.fill: parent
            onClicked: r.state='hide'
        }
        Text {
            text: 'X'
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width*0.6
            color: 'white'
            anchors.centerIn: parent
        }
    }
    Row{
        id: rowBtns
        spacing: app.fs*0.25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        opacity: 0.0
        Timer{
            id: tHideRowBtns
            running: rowBtns.opacity===1.0
            repeat: false
            interval: 5000
            onTriggered: parent.opacity=0.0
        }
        Behavior on opacity{NumberAnimation{duration: 500}}
        Button{
            text: 'Copiar HTML'
            onClicked: {
                let d = '<!DOCTYPE html><html>'
                d+='<head>Simbología de los Sabianos<title></title><meta charset="utf-8"></head>'
                d+='<body>'
                d += '<h1>Simbología de los Sabianos</h1>'
                d+='<b>'+r.signos[r.numSign]+'</b><br />'
                d+=getData()
                d+='<br /><h3>Fuente: Universidad Norbert Wiener - Perú</h3><br />'
                d+='</body></html>'
                clipboard.setText(d)
                tHideRowBtns.restart()
            }
        }
        Button{
            text: 'Copiar Texto'
            onClicked: {
                let d = '<!DOCTYPE html><html>'
                d+='<body>'
                d += '<h1>Simbología de los Sabianos</h1>'
                d+='<b>'+r.signos[r.numSign]+'</b><br />'
                d+=getData()
                d+='<br /><h3>Fuente: Universidad Norbert Wiener - Perú</h3><br />'
                d+='</body></html>'
                d=d.replace(/<\/p>/g, '\n')
                d=d.replace(/<br \/>/g, '\n')
                d=d.replace(/<\/h1>/g, '</h1>\n')
                d=d.replace(/<[^>]*>/g, '')
                clipboard.setText(d)
                tHideRowBtns.restart()
            }
        }
        Comps.ButtonIcon{
            text: '\uf010'
            width: apps.botSize
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(apps.panelSabianosFz>0.5)apps.panelSabianosFz-=0.1
                rowBtns.opacity=1.0
                tHideRowBtns.restart()
            }
        }
        Comps.ButtonIcon{
            text: '\uf00e'
            width: apps.botSize
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(apps.panelSabianosFz<2.0)apps.panelSabianosFz+=0.1
                rowBtns.opacity=1.0
                tHideRowBtns.restart()
            }
        }
        Comps.ButtonIcon{
            text: '\uf06e'
            width: apps.botSize*2
            height: width
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                apps.sabianosAutoShow=!apps.sabianosAutoShow
                tHideRowBtns.restart()
            }
            Text{
                text:apps.sabianosAutoShow?'\uf023':'\uf13e'
                font.pixelSize: parent.width*0.5
                anchors.right:parent.right
            }
        }
    }
    function ctrlDown(){
        if(r.numSign<11){
            r.numSign++
        }else{
            r.numSign=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function ctrlUp(){
        if(r.numSign>0){
            r.numSign--
        }else{
            r.numSign=11
            r.currentInterpreter=0
        }
        loadData()
    }
    function todown(){
        if(r.numDegree<30){
            r.numDegree++
        }else{
            r.numDegree=0
            r.currentInterpreter=0
        }
        loadData()
    }
    function toup(){
        if(r.numDegree>0){
            r.numDegree--
        }else{
            r.numDegree=30
            r.currentInterpreter=0
        }
        loadData()
    }
    function toleft(){
        if(r.currentInterpreter>0){
            r.currentInterpreter--
        }else{
            r.currentInterpreter=2
            if(r.numDegree>0){
                r.numDegree--
            }else{
                r.numDegree=29
                r.currentInterpreter=2
                if(r.numSign>0){
                    r.numSign--
                }else{
                    r.numSign=11
                }
            }
        }
        loadData()
    }
    function toright(){
        if(r.currentInterpreter<2){
            r.currentInterpreter++
        }else{
            r.currentInterpreter=0
            if(r.numDegree<29){
                r.numDegree++
            }else{
                r.numDegree=0
                r.currentInterpreter=0
                if(r.numSign<11){
                    r.numSign++
                }else{
                    r.numSign=0
                }
            }
        }
        loadData()
    }
    function loadData(){
        //data.font.pixelSize=app.fs*0.5*apps.panelSabianosFz
        let df=r.numDegree
        let sf=r.numSign
        if(r.numDegree===-1){
            df=29
            r.numDegree=df
            sf--
            r.numSign--
            if(r.numSign<0){
                sf=0
                r.numSign=11
            }
        }
        let fileUrl=app.mainLocation+'/resources/sab'+r.numSign+'.json'
        fileUrl=fileUrl.replace(/\"/g, '')
        let fileData=''+unik.getFile(fileUrl)
        let json=JSON.parse(fileData.replace(/\n/g, ''))
        //console.log('df:'+df)
        //console.log('sf:'+sf)
        data.text=json['g'+df]['p1'].text
        data.text+=json['g'+df]['p2'].text
        data.text+=json['g'+df]['p3'].text
        flk.contentY=0
    }
    function getData(){
        let df=r.numDegree
        let sf=r.numSign
        if(r.numDegree===-1){
            df=29
            r.numDegree=df
            sf--
            r.numSign--
            if(r.numSign<0){
                sf=0
                r.numSign=11
            }
        }
        let fileUrl=app.mainLocation+'/resources/sab'+r.numSign+'.json'
        fileUrl=fileUrl.replace(/\"/g, '')
        let fileData=''+unik.getFile(fileUrl)
        let json=JSON.parse(fileData.replace(/\n/g, ''))
        let rd=json['g'+df]['p1'].text
        rd+=json['g'+df]['p2'].text
        rd+=json['g'+df]['p3'].text
        return rd
    }
    function getHtmlData(s, g, item){
        let fileData=''+unik.getFile('360.html')
        let dataSign=fileData.split('---')
        let stringSplit=''
        if(g<=8){
            stringSplit='0'+parseInt(g+1)+'°:'
        }else{
            stringSplit=''+parseInt(g+1)+'°:'
        }
        let signData=''+dataSign[s+1]
        //console.log('\n\n\nAries---->>'+signData+'\n\n\n')
        let dataDegree=signData.split('<p ')
        let htmlPrevio=''
        let cp=0
        currentDegree.sd=stringSplit
        for(var i=0;i<dataDegree.length;i++){
            //console.log('\n\n\n\n'+stringSplit+'----------->>'+dataDegree[i])
            if(dataDegree[i].indexOf(stringSplit)>0){
                htmlPrevio+='<p '+dataDegree[i]
                cp++
                //console.log('\n\n----------->>'+htmlPrevio)
            }
        }
        let mapHtmlDegree=htmlPrevio.split('<p ')
        let dataFinal=item===0?'<h3> Grado °'+parseInt(g + 1)+' de '+r.signos[s]+'</h3>\n':''
        dataFinal+='<p '+mapHtmlDegree[item + 1]
        if(rs.bgColor!=='#ffffff'){
            if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color:')<0&&dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><span>strong style="color:')<0){
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><strong>')
                dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><span ','<p class="entry-excerpt" style="text-align: left;color:#ffffff"><span ')
                dataFinal=dataFinal.replace('style="color: rgb(0, 0, 255);','style="color: rgb(255, 255, 255);')
            }else{
                if(dataFinal.indexOf('<p class="entry-excerpt" style="text-align: left;"><strong><span style="color: rgb(255, 0, 0);">'>=0)){
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:red"><strong>')
                }else{
                    dataFinal=dataFinal.replace('<p class="entry-excerpt" style="text-align: left;"><strong>','<p class="entry-excerpt" style="text-align: left;color:green"><strong>')
                }
            }
        }
        return dataFinal.replace(/style=\"text-align: justify;\"/g,'').replace(/&nbsp; /g, ' ')
    }
    function setHtml(html, nom){
        let htmlFinal='<DOCTYPE html>
<html>
<head>
    <title>'+nom+'</title>
</head>
    <body style="background-color:#ffffff;">
        <h1>Ajustando hora de nacimiento de '+nom+'</h1>
        <p>En esta página hay 3 grupos con 3 textos. Tenés que avisar cuál de todos estos grupos te parece que tiene más que ver con tu vida o tu forma de ser.</p>
        <p>Los textos que vas a leer a continuación, son como descripciones de imágenes que simbolizan una escena de algo que se puede presentar en tu vida de algn modo parecido o similar.</p>
        <p><b>Aviso: </b>Los textos en color rojo son algo negativos. Tantos los textos azules o rojos puede ser que aún no se hayan producido.</p>
        <br/>
        <h2>¿Cuál de los siguientes grupos de textos pensas que hablan de cosas más parecidas a tu vida o forma de ser?</h2>
        <br/>\n'
+html+
'<br />
         <br />
    </body>
</html>'
        unik.setFile('/home/ns/nsp/uda/nextsigner.github.io/sabianos/'+nom+'.html', htmlFinal)
    }
    function setJsonZoom(numSign, numDegree, numItem, zoom){
        let jsonFile='./sabianosJsonZoom.json'
        let existe=unik.fileExist(jsonFile)
        let jsonString=''
        let newJsonString=''
        if(existe){
            jsonString=unik.getFile(jsonFile)
        }
        let arrayLines=jsonString.split('\n')
        let nomItem='pos_'+numSign+'_'+numDegree+'_'+numItem
        let e=false
        for(var i=0;i<arrayLines.length;i++){
            if(arrayLines[i].indexOf(nomItem)<0&&arrayLines[i].indexOf('pos_')>=0){
                newJsonString+=arrayLines[i]+'\n'
            }
        }
        //if(!e){
        newJsonString+=nomItem+'='+zoom+'\n'
        //}
        unik.setFile(jsonFile, newJsonString)
    }
    function getJsonZoom(numSign, numDegree, numItem){
        let jsonFile='./sabianosJsonZoom.json'
        let existe=unik.fileExist(jsonFile)
        let jsonString=''
        if(existe){
            jsonString=unik.getFile(jsonFile)
        }
        let arrayLines=jsonString.split('\n')
        let nomItem='pos_'+numSign+'_'+numDegree+'_'+numItem
        let zoom="1.0"
        for(var i=0;i<arrayLines.length;i++){
            if(arrayLines[i].indexOf(nomItem)>=0){
                zoom=""+arrayLines[i].split('=')[1]
                break
            }
        }
        return zoom
    }
    function zoomDown(){
        let gz=getJsonZoom(r.numSign, r.numDegree, r.currentInterpreter)
        console.log('gz baja:'+gz)
        let zoom=parseFloat(gz).toFixed(1)
        console.log('Z1:'+zoom)
        if(zoom==='NaN'){
            console.log('NaN! :'+zoom)
            return
        }
        apps.panelSabianosFz-=0.1
        if(apps.panelSabianosFz<0.01){
            apps.panelSabianosFz=0.01
        }
        zoom=parseFloat(apps.panelSabianosFz).toFixed(1)
        //unik.speak('Sube '+zoom)


        //data.font.pixelSize=r.fs*2*apps.panelSabianosFz
        console.log('SETZOOM:'+zoom)
        setJsonZoom(r.numSign, r.numDegree, r.currentInterpreter, zoom)
        r.loadData()
    }
    function zoomUp(){
        let gz=getJsonZoom(r.numSign, r.numDegree, r.currentInterpreter)
        console.log('gz sube:'+gz)
        let zoom=parseFloat(gz).toFixed(1)
        console.log('Z1:'+zoom)
        if(zoom==='NaN'){
            console.log('NaN! :'+zoom)
            return
        }
        apps.panelSabianosFz+=0.1
        zoom=parseFloat(apps.panelSabianosFz).toFixed(1)
        //unik.speak('Baja '+zoom)
        /*if(zoom<1.0){
                zoom=parseFloat(1).toFixed(1)
            }*/
        //data.font.pixelSize=r.fs*2*apps.panelSabianosFz
        console.log('SETZOOM:'+zoom)
        setJsonZoom(r.numSign, r.numDegree, r.currentInterpreter, zoom)
        r.loadData()
    }
}

