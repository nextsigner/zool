import QtQuick 2.12
import QtQuick.Controls 2.12
import "../"
import "../../Funcs.js" as JS

Rectangle {
    id: r
    color: apps.backgroundColor
    visible: false
    property var aDes: ['dato1', 'dato2', 'dato3', 'dato4', 'dato5', 'dato6', 'dato7', 'dato8', 'dato9']

    property alias currentDate: controlTimeDateNac.currentDate
    property int currentNum: 0

    property color borderColor: apps.fontColor
    property int borderWidth: app.fs*0.15
    property int dir: -1
    property int uRot: 0

    property int currentNumKarma: -1
    property int currentNumAnioPersonal: -1

    onCurrentNumAnioPersonalChanged: {
        currentNum=currentNumAnioPersonal-1
    }
    onCurrentDateChanged: {
        let d = currentDate.getDate()
        let m = currentDate.getMonth() + 1
        let a = currentDate.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=JS.getNums(f)
        currentNumKarma=aGetNums[0]
    }
    MouseArea{
        anchors.fill: parent
    }
    Row{
        spacing: app.fs*0.5
        anchors.centerIn: parent
        Item{
            id: xForm
            width: app.fs*10
            height: r.height
            Column{
                spacing: app.fs
                Rectangle{
                    id: xFN
                    width: xForm.width
                    height: colFN.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    Column{
                        id: colFN
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Text{
                            text: '<b>Fecha de Nacimiento</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.5
                            //anchors.verticalCenter: parent.verticalCenter
                        }
                        ControlsTimeDate{
                            id: controlTimeDateNac
                            //anchors.verticalCenter: parent.verticalCenter
                            onCurrentDateChanged: {
                                if(controlTimeYear.currentDate){
                                    let d=currentDate.getDate()
                                    let m=currentDate.getMonth() + 1
                                    let a = currentDate.getFullYear()
                                    let sf=''+d+'/'+m+'/'+a
                                    let aGetNums=JS.getNums(sf)
                                    currentNumKarma=aGetNums[0]
                                    let dateP = new Date(controlTimeYear.currentDate.getFullYear(), m - 1, d, 0, 1)
                                    controlTimeYear.currentDate=dateP
                                }
                            }
                        }
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter:  parent.horizontalCenter
                            Text{
                                text: '<b>N° Karma</b>: '
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                id: xNumKarma
                                width: app.fs*2
                                height: width
                                radius: width*0.5
                                border.width: app.fs*0.2
                                border.color: apps.fontColor
                                //rotation: 360-parent.rotation
                                color: apps.backgroundColor
                                anchors.verticalCenter: parent.verticalCenter
                                Text{
                                    text: '<b>'+r.currentNumKarma+'</b>'
                                    font.pixelSize: parent.width*0.8
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id: xAP
                    width: xForm.width
                    height: colAP.height+app.fs
                    color: 'transparent'
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.2
                    Column{
                        id: colAP
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Row{
                            spacing: app.fs
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: '<b>N° Año Personal</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            ControlsTimeFullYear{
                                id: controlTimeYear
                                anchors.verticalCenter: parent.verticalCenter
                                onCurrentDateChanged: {
                                    let d = currentDate.getDate()
                                    let m = currentDate.getMonth() + 1
                                    let a = currentDate.getFullYear()
                                    let sf=''+d+'/'+m+'/'+a
                                    //let aGetNums=JS.getNums(sf)
                                    //currentNumAnioPersonal=aGetNums[0]
                                    let msfd=(''+d).split('')
                                    let sfd=''+msfd[0]
                                    if(msfd.length>1){
                                        sfd +='+'+msfd[1]
                                    }
                                    let msfm=(''+m).split('')
                                    let sfm=''+msfm[0]
                                    if(msfm.length>1){
                                        sfm +='+'+msfm[1]
                                    }
                                    //let msform=(''+a).split('')
                                    let msfa=(''+a).split('')
                                    let sfa=''+msfa[0]
                                    if(msfa.length>1){
                                        sfa +='+'+msfa[1]
                                    }
                                    if(msfa.length>2){
                                        sfa +='+'+msfa[2]
                                    }
                                    if(msfa.length>3){
                                        sfa +='+'+msfa[3]
                                    }
                                    let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
                                    let sum=0
                                    let mSum=sform.split('+')
                                    for(var i=0;i<mSum.length;i++){
                                        sum+=parseInt(mSum[i])
                                    }
                                    let mCheckSum=(''+sum).split('')
                                    if(mCheckSum.length>1){
                                        let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                                        sform+='='+sum+'='+dobleDigSum
                                        let mCheckSum2=(''+dobleDigSum).split('')
                                        if(mCheckSum2.length>1){
                                            let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                                            sform+='='+dobleDigSum2
                                            currentNumAnioPersonal=dobleDigSum2
                                        }else{
                                            currentNumAnioPersonal=dobleDigSum
                                        }
                                    }else{
                                        currentNumAnioPersonal=sum
                                    }
                                    f1.text=sform
                                    if(panelLog.visible){
                                        let edad=a - controlTimeDateNac.currentDate.getFullYear()
                                        panelLog.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')
                                    }
                                }
                            }
                        }
                        Text{
                            id: f1
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.8
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: '<b>Año:</b> '
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                id: xNumAP
                                width: app.fs*2
                                height: width
                                radius: width*0.5
                                border.width: app.fs*0.2
                                border.color: apps.fontColor
                                //rotation: 360-parent.rotation
                                color: apps.backgroundColor
                                anchors.verticalCenter: parent.verticalCenter
                                Text{
                                    text: '<b>'+r.currentNumAnioPersonal+'</b>'
                                    font.pixelSize: parent.width*0.8
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        text: checkBoxLog.checked?'<b>Ocultar texto</b>':'<b>Mostrar texto.</b>'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    CheckBox{
                        id: checkBoxLog
                        checked: panelLog.visible
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: panelLog.visible=checked
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: checkBoxLog.checked
                    Button{
                        text:  'Crear Lista'
                        onClicked: mkDataList()
                        anchors.verticalCenter: parent.verticalCenter
                        visible: checkBoxLog.checked
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: checkBoxLog.checked
                    Button{
                        text:  'Limpiar'
                        onClicked: panelLog.clear()
                        anchors.verticalCenter: parent.verticalCenter
                        visible: checkBoxLog.checked
                    }
                    Button{
                        text:  'Copiar'
                        onClicked: {
                            clipboard.setText(panelLog.text)
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        visible: checkBoxLog.checked
                    }
                }
            }
        }
        Rectangle{
            id: xNums
            width: app.fs*20
            height: width
            border.width: r.borderWidth
            border.color: r.borderColor
            color: apps.backgroundColor
            radius: width*0.5
            anchors.verticalCenter: parent.verticalCenter
            Behavior on rotation{NumberAnimation{duration: 500}}
            MouseArea{
                anchors.fill: parent
                onWheel: {
                    if(wheel.angleDelta.y>=0){
                        r.dir=1
                        if(r.currentNum<8){
                            r.currentNum++
                        }else{
                            r.currentNum=0
                        }
                    }else{
                        r.dir=0
                        if(r.currentNum>0){
                            r.currentNum--
                        }else{
                            r.currentNum=8
                        }
                    }
                }
            }
            Repeater{
                id: rep
                model: r.aDes
                Item{
                    width: 1
                    height: parent.width-parent.border.width*2
                    anchors.centerIn: parent
                    rotation: 360/9*index//+90
                    Rectangle{
                        width: r.borderWidth
                        height: parent.parent.height*0.5-xNum.width-xData.width*0.5-canvasSen.width*0.5
                        color: apps.fontColor
                        opacity: r.currentNum!==index?0.5:1.0
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin:  xNum.width
                        visible: r.currentNum===index
                        Canvas {
                            id:canvasSen
                            width: app.fs
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            //anchors.verticalCenter: parent.verticalCenter
                            //anchors.left: parent.right
                            antialiasing: true
                            rotation: -90
                            onPaint:{
                                var ctx = canvasSen.getContext('2d');
                                ctx.beginPath();
                                ctx.moveTo(0, canvasSen.width*0.5);
                                ctx.lineTo(canvasSen.width, 0);
                                ctx.lineTo(canvasSen.width, canvasSen.width);
                                ctx.lineTo(0, canvasSen.width*0.5);
                                ctx.strokeStyle = r.currentNum===index?apps.fontColor:apps.backgroundColor
                                ctx.lineWidth = 3//canvasSen.parent.height;
                                ctx.fillStyle = r.currentNum===index?apps.backgroundColor:apps.fontColor
                                ctx.fill();
                                ctx.stroke();
                            }
                        }
                    }
                    Rectangle{
                        id: xNum
                        width: app.fs*3
                        height: width
                        radius: width*0.5
                        border.width: app.fs*0.2
                        border.color: r.currentNum===index?apps.fontColor:apps.backgroundColor
                        //rotation: 360-parent.rotation
                        color: r.currentNum===index?apps.fontColor:apps.backgroundColor
                        rotation: 360-parent.rotation-parent.parent.rotation//-360/9*r.currentNum-90
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: r.currentNum!==index?0.5:1.0

                        Text{
                            text: '<b>'+index+'</b>'
                            font.pixelSize: parent.width*0.8
                            color: r.currentNum===index?apps.backgroundColor:apps.fontColor
                            anchors.centerIn: parent
                            Component.onCompleted: {
                                if(index===1){
                                    text='<b>11</b>'
                                }else{
                                    text='<b>'+parseInt(index + 1)+'</b>'
                                }
                            }
                        }
                    }
                }
            }
            //            Text{
            //                text: ''+xNums.rotation
            //                anchors.centerIn: parent
            //                color: 'white'
            //                font.pixelSize: app.fs*2
            //            }
            Rectangle{
                id: xData
                width: parent.width*0.4
                height: width
                border.width: r.borderWidth
                border.color: r.borderColor
                color: 'transparent'//apps.backgroundColor
                radius: width*0.5
                anchors.centerIn: parent
                Text{
                    id: data
                    text : ''+r.aDes[r.currentNum]
                    width: parent.width-app.fs
                    font.pixelSize: parent.width*0.1
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    color: apps.fontColor
                }
            }
        }
        PanelLog{
            id: panelLog
            width: r.width*0.2
            height: parent.height
            visible: true
        }
    }
    Button{
        text:  'Cerrar'
        width: app.fs*3
        height: app.fs
        onClicked: {
            r.visible=false
        }
    }
    Component.onCompleted: {
        let a =[]
        let d = 'INICIOS, VIDA NUEVA, RENOVACIONES'
        a.push(d)
        d = 'TOMA DE DESICIONES, SALIR DE TUS FRONTERAS, LA REALIDAD TE ALCANZA'
        a.push(d)
        d = 'NOTORIEDAD, BRILLO, OPCIONES, OPORTUNIDADES'
        a.push(d)
        d = 'CONSTRUCCIÓN, DISCIPLINA, TIEMPO DE PONER ORDEN EN TU VIDA'
        a.push(d)
        d = 'PROGRESO, MOVIMIENTO, SALIR DE LA ZONA DE CONFORT'
        a.push(d)
        d = 'TRABAJO EN RELACIONES, PRODUCTIVIDAD, GENERACIÓN'
        a.push(d)
        d = 'RESPONSABILIDAD Y ESTRUCTURA, ASUMIR LA PROPIA REALIDAD'
        a.push(d)
        d = 'COSECHA Y LOGROS, RETO Y CONQUISTA A SUPERAR'
        a.push(d)
        d = 'AUTOSUFICIENCIA, CONSOLIDACIÓN, CIERRE DE CICLO'
        a.push(d)
        r.aDes=a
        rep.model=a
        //xNums.rotation=90
    }
    function mkDataList(){
        var ai=r.currentDate.getFullYear()
        var d = currentDate.getDate()
        var m = currentDate.getMonth() + 1
        var sform=''
        //return
        for(var i=ai;i<ai+101;i++){
            panelLog.l('ai:'+ai)
            panelLog.l('ai i:'+i)
            panelLog.visible=true

            let a = ai
            let sf=''+d+'/'+m+'/'+a
            //let aGetNums=JS.getNums(sf)
            //currentNumAnioPersonal=aGetNums[0]
            let msfd=(''+d).split('')
            let sfd=''+msfd[0]
            if(msfd.length>1){
                sfd +='+'+msfd[1]
            }
            let msfm=(''+m).split('')
            let sfm=''+msfm[0]
            if(msfm.length>1){
                sfm +='+'+msfm[1]
            }
            //let msform=(''+a).split('')
            let msfa=(''+a).split('')
            let sfa=''+msfa[0]
            if(msfa.length>1){
                sfa +='+'+msfa[1]
            }
            if(msfa.length>2){
                sfa +='+'+msfa[2]
            }
            if(msfa.length>3){
                sfa +='+'+msfa[3]
            }
            let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
            let sum=0
            let mSum=sform.split('+')
            for(var i=0;i<mSum.length;i++){
                sum+=parseInt(mSum[i])
            }
            let mCheckSum=(''+sum).split('')
            if(mCheckSum.length>1){
                let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                sform+='='+sum+'='+dobleDigSum
                let mCheckSum2=(''+dobleDigSum).split('')
                if(mCheckSum2.length>1){
                    let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                    sform+='='+dobleDigSum2
                    //currentNumAnioPersonal=dobleDigSum2
                }else{
                    //currentNumAnioPersonal=dobleDigSum
                }
            }else{
                //currentNumAnioPersonal=sum
            }
        }
        //f1.text=sform
        if(panelLog.visible){
            let edad=a - ai
            //panelLog.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')
        }
    }
}
