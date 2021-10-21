import QtQuick 2.7
import QtQuick.Controls 2.0
import "Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm
    property int edadMaxima: 0
    property string jsonFull: ''

    property var aAspNames: ['Conjunción', 'Trígono', 'Cuadratura', 'Sextil']
    property var aAspNamesRes: ['Con', 'Trí', 'Squ', 'Sex']

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
    onStateChanged: {
        if(state==='show'){
            if(sbDesde.value<=0){
                sbDesde.from =app.currentDate.getFullYear()
                sbDesde.to =sbDesde.from + 150
                sbDesde.value = app.currentDate.getFullYear()
                sbHasta.from=sbDesde.from + 1
                sbHasta.to=sbHasta.from + 150
                sbHasta.value = sbDesde.value+60
            }
//            if(lm.count===0){
//                loadItemsYears()
//            }
        }
    }
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Column{
        spacing: app.fs*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id:xTit
            width: lv.width
            height: app.fs*1.5
            color: apps.fontColor
            border.width: 2
            border.color: txtLabelTit.focus?'red':'white'
            anchors.horizontalCenter: parent.horizontalCenter
            XText {
                id: txtLabelTit
                text: 'Aspectos en Tránsito'
                font.pixelSize: app.fs*0.5
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                color: apps.backgroundColor
                focus: true
                anchors.centerIn: parent
            }
        }
        Column{
            id: colCbs
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ComboBox{
                    id: cbP1
                    model: app.planetas
                    width: r.width*0.5-app.fs*0.5
                    font.pixelSize: app.fs*0.5
                }
                ComboBox{
                    id: cbP2
                    model: app.planetas
                    width: r.width*0.5-app.fs*0.5
                    font.pixelSize: app.fs*0.5
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ComboBox{
                    id: cbAsp
                    model: r.aAspNames
                    width: r.width-botSearchAsp.width-app.fs
                    font.pixelSize: app.fs*0.5
                }

            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{text: 'Desde: '; color: apps.fontColor; font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                SpinBox{
                    id: sbDesde
                    font.pixelSize: app.fs*0.5
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{text: 'Hasta: '; color: apps.fontColor; font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                SpinBox{
                    id: sbHasta
                    font.pixelSize: app.fs*0.5
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{text: ''+parseInt(sbHasta.value - sbDesde.value )+' años.'; color: apps.fontColor; font.pixelSize: app.fs*0.5;anchors.verticalCenter: parent.verticalCenter}
                Button{
                    id: botSearchAsp
                    text: 'Buscar'
                    font.pixelSize: app.fs*0.5
                }
            }
        }
        ListView{
            id: lv
            width: r.width
            height: r.height-xTit.height-colCbs.height-app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            cacheBuffer: 150
            displayMarginBeginning: cacheBuffer*app.fs*3
            clip: true
            Behavior on contentY{NumberAnimation{duration: app.msDesDuration}}
            onCurrentIndexChanged: {
                //contentY=lv.itemAtIndex(currentIndex).y+lv.itemAtIndex(currentIndex).height-r.height*0.5
            }
        }
    }
    ListModel{
        id: lm
        function addItem(a){
            return {
                anio: a
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: itemRS
            width: lv.width-r.border.width*2
            height: app.fs*1.5//index!==lv.currentIndex?app.fs*1.5:app.fs*3.5+app.fs
            color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            Behavior on opacity{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            XText {
                id: txtData
                text: '<b>'+anio+'</b>'
                font.pixelSize: app.fs
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignHCenter
                color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    //r.state='hide'
                    //xBottomBar.objPanelCmd.makeRS(itemRS.rsDate)
                    xBottomBar.objPanelCmd.makeRSBack(itemRS.rsDate)
                }
            }
        }
    }
    Item{id: xuqp}
    function loadItemsYears(){
        let ai=app.currentDate.getFullYear()
        for(var i=0; i < 150; i++){
            lm.append(lm.addItem(ai + 1))
            ai++
        }
    }
    function loadAspsYears(y){
        lm.clear()
        let cd3= new Date(app.currentDate)
        //let hsys=apps.currentHsys
        let finalCmd=''
            +app.pythonLocation+' '+app.mainLocation+'/py/astrologica_trans.py '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+edad//+' '+hsys
        let c=''
            +'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'try {\n'
            +'  j=JSON.parse(logData)\n'
            +'  loadJson(j)\n'
            +'  logData=""\n'
            +'} catch(e) {\n'
            +'  console.log(e+" "+logData);\n'
            +'  //unik.speak("error");\n'
            +'}\n'
        mkCmd(finalCmd, c, xuqp)
    }
    function mkCmd(finalCmd, code, item){
        for(var i=0;i<item.children.length;i++){
            item.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='import "Funcs.js" as JS\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        '+code+'\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        run(\''+finalCmd+'\')\n'
        c+='    }\n'
        c+='}\n'
        //console.log(c)
        let comp=Qt.createQmlObject(c, item, 'uqpcodecmdrslist')
    }
    function clear(){
        lm.clear()
        r.state='hide'
    }
    function enter(){
        //Qt.quit()
        //        if(xTit.showTi){
        //            xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
        //            xTit.showTi=false
        //            return
        //        }
        //        if(lv.count>=1){
        //            xBottomBar.objPanelCmd.makeRSBack(lv.itemAtIndex(lv.currentIndex).rsDate)
        //        }
    }
}
