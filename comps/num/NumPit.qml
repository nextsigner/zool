import QtQuick 2.12
import QtQuick.Controls 2.12
import "../"
import "../../comps" as Comps
import "../../Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    clip: true
    color: apps.backgroundColor
    //visible: false
    property string jsonNum: ''
    property var aDes: ['dato1', 'dato2', 'dato3', 'dato4', 'dato5', 'dato6', 'dato7', 'dato8', 'dato9']

    property var currentDate
    property int currentNum: 0

    property color borderColor: apps.fontColor
    property int borderWidth: app.fs*0.15
    property int dir: -1
    property int uRot: 0

    //Número total de la fecha de nacimiento
    property int currentNumNacimiento: -1
    property int currentNumNatalicio: -1

    //Numero total de Nombre
    property int currentNumNombre: -1

    //Numero de suma de vocales de nombre
    property int currentNumNombreInt: -1
    property int currentNumNombreIntM: -1

    //Numero de suma de consonantes de nombre
    property int currentNumNombreExt: -1
    property int currentNumNombreExtM: -1

    //Número total de nacimiento y nombre
    property int currentNumDestino: -1

    //Numero de suma de letras de firma
    property int currentNumFirma: -1

    //Pinaculos
    property int currentPin1: -1
    property int currentPin2: -1
    property int currentPin3: -1
    property int currentPin4: -1
    property int currentTipoPin1: -1
    property int currentTipoPin2: -1
    property int currentTipoPin3: -1
    property int currentTipoPin4: -1

    property int currentNumPersonalidad: -1
    property int currentNumAnioPersonal: -1
    property bool esMaestro: false

    //String Fórmulas
    property string sFormulaInt : ''
    property string sFormulaExt: ''
    property string sFormulaNumPer : ''
    property string sFormulaNatalicio : ''

    property int itemIndex: -1

    onCurrentNumNacimientoChanged: {
        calcularPersonalidad()
    }
    onCurrentNumNombreChanged: {
        calcularPersonalidad()
    }
    onCurrentNumAnioPersonalChanged: {
        currentNum=currentNumAnioPersonal-1
    }
    onCurrentDateChanged: {
        //panelLog.l('CurrentDate: '+currentDate.toString())
        //panelLog.visible=true
        let d = currentDate.getDate()
        let m = currentDate.getMonth() + 1
        let a = currentDate.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=JS.getNums(f)
        currentNumNacimiento=aGetNums[0]
        r.currentNumNatalicio=d
        r.sFormulaNatalicio=aGetNums[1]
    }
    MouseArea{
        anchors.fill: parent
    }
    Flickable{
        id: flk
        anchors.fill: r
        contentWidth: r.width
        contentHeight: col1.height*1.5
        Column{
            id: col1
            spacing: app.fs*0.5
            Rectangle{
                id: xForm
                width: r.width-app.fs*0.5
                height: col2.height
                color: 'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: col2
                    spacing: app.fs*0.25
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
                            Row{
                                spacing: app.fs*0.25
                                Text{
                                    id: labelFN
                                    text: '<b>Fecha de Nacimiento:</b>'
                                    color: apps.fontColor
                                    font.pixelSize: app.fs*0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    id:xTiFecha
                                    width: xForm.width-labelFN.width-app.fs
                                    height: app.fs*1.2
                                    color: apps.backgroundColor
                                    border.width: 2
                                    border.color: apps.fontColor
                                    anchors.verticalCenter: parent.verticalCenter
                                    TextInput {
                                        id: txtDataSearchFecha
                                        text: apps.numUFecha
                                        font.pixelSize: app.fs*0.5
                                        width: parent.width-app.fs*0.2
                                        wrapMode: Text.WordWrap
                                        color: apps.fontColor
                                        focus: true
                                        //inputMask: '00.00.0000'
                                        anchors.centerIn: parent
                                        Keys.onReturnPressed: {
                                            if(text==='')return
                                            calc()
                                            //panelLog.l(getNumNomText(text))
                                        }
                                        onTextChanged: {
                                            calc()
                                            //setNumNac()
                                            //                                            let mfecha=text.split('.')
                                            //                                            if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
                                            //                                                f0.text=''
                                            //                                                currentNumNacimiento=-1
                                            //                                                return
                                            //                                            }
                                            //                                            let d=mfecha[0]
                                            //                                            let m=mfecha[1]
                                            //                                            let a = mfecha[2]
                                            //                                            let sf=''+d+'/'+m+'/'+a
                                            //                                            let aGetNums=JS.getNums(sf)
                                            //                                            currentNumNacimiento=aGetNums[0]
                                            //                                            let dateP = new Date(parseInt(txtDataSearchFechaAP.text), m - 1, d, 0, 1)
                                            //                                            //controlTimeYear.currentDate=dateP
                                            //                                            r.currentDate = dateP
                                            //                                            let msfd=(''+d).split('')
                                            //                                            let sfd=''+msfd[0]
                                            //                                            if(msfd.length>1){
                                            //                                                sfd +='+'+msfd[1]
                                            //                                            }
                                            //                                            let msfm=(''+m).split('')
                                            //                                            let sfm=''+msfm[0]
                                            //                                            if(msfm.length>1){
                                            //                                                sfm +='+'+msfm[1]
                                            //                                            }
                                            //                                            //let msform=(''+a).split('')
                                            //                                            let msfa=(''+a).split('')
                                            //                                            let sfa=''+msfa[0]
                                            //                                            if(msfa.length>1){
                                            //                                                sfa +='+'+msfa[1]
                                            //                                            }
                                            //                                            if(msfa.length>2){
                                            //                                                sfa +='+'+msfa[2]
                                            //                                            }
                                            //                                            if(msfa.length>3){
                                            //                                                sfa +='+'+msfa[3]
                                            //                                            }
                                            //                                            let sform= sfd + '+' + sfm + '+' + sfa//msform[0] + '+' + msform[1] + '+'  + msform[2]+ '+'  + msform[3]
                                            //                                            let sum=0
                                            //                                            let mSum=sform.split('+')
                                            //                                            for(var i=0;i<mSum.length;i++){
                                            //                                                sum+=parseInt(mSum[i])
                                            //                                            }
                                            //                                            let mCheckSum=(''+sum).split('')
                                            //                                            if(mCheckSum.length>1){
                                            //                                                if(sum===11||sum===22||sum===33){
                                            //                                                    //r.esMaestro=true
                                            //                                                }
                                            //                                                let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                                            //                                                sform+='='+sum+'='+dobleDigSum
                                            //                                                let mCheckSum2=(''+dobleDigSum).split('')
                                            //                                                if(mCheckSum2.length>1){
                                            //                                                    let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                                            //                                                    sform+='='+dobleDigSum2
                                            //                                                    currentNumNacimiento=dobleDigSum2
                                            //                                                }else{
                                            //                                                    currentNumNacimiento=dobleDigSum
                                            //                                                }

                                            //                                            }else{
                                            //                                                currentNumNacimiento=sum
                                            //                                            }
                                            //                                            f0.text=sform
                                            //                                            apps.numUFecha=txtDataSearchFecha.text
                                            //                                            calcularAP()
                                        }
                                        onFocusChanged: {
                                            if(focus)selectAll()
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
                            }

                            Text{
                                id: labelFNTS
                                text: r.currentDate?r.currentDate.toString():''
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.25
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                id: f0
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.6
                                anchors.horizontalCenter: parent.horizontalCenter
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
                                        text: '<b>'+r.currentNumNacimiento+'</b>'
                                        font.pixelSize: parent.width*0.8
                                        color: apps.fontColor
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: xFormNom
                width: xForm.width
                height: colNom.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colNom
                    spacing: app.fs*0.75
                    anchors.centerIn: parent
                    Text{
                        text: '<b>Calcular Nombre</b>'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Rectangle{
                        id:xTiNombre
                        width: xForm.width-app.fs*0.5
                        height: app.fs*1.2
                        color: apps.backgroundColor
                        border.width: 2
                        border.color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Nombre:</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.25
                            anchors.bottom: parent.top
                            anchors.bottomMargin: app.fs*0.25
                        }
                        TextInput {
                            id: txtDataSearchNom
                            text: apps.numUNom
                            font.pixelSize: app.fs*0.5
                            width: parent.width-app.fs*0.2
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                            focus: false
                            anchors.centerIn: parent
                            Keys.onReturnPressed: {
                                if(text==='')return
                                //panelLog.l(getNumNomText(text))
                                calc()
                                apps.numUNom=text
                            }
                            onTextChanged: {
                                //panelLog.l(getNumNomText(text))
                                calc()
                                apps.numUNom=text
                            }
                            onFocusChanged: {
                                if(focus)selectAll()
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
                    Rectangle{
                        id:xTiFirma
                        width: xForm.width-app.fs*0.5
                        height: app.fs*1.2
                        color: apps.backgroundColor
                        border.width: 2
                        border.color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Firma:</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.25
                            anchors.bottom: parent.top
                            anchors.bottomMargin: app.fs*0.25
                        }
                        TextInput {
                            id: txtDataSearchFirma
                            text: apps.numUFirma
                            font.pixelSize: app.fs*0.5
                            width: parent.width-app.fs*0.2
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                            focus: false
                            anchors.centerIn: parent
                            Keys.onReturnPressed: {
                                if(text==='')return
                                //panelLog.l(getNumNomText(text))
                                calc()
                                apps.numUNom=text
                            }
                            onTextChanged: {
                                //panelLog.l(getNumNomText(text))
                                calc()
                                apps.numUFirma=text
                            }
                            onFocusChanged: {
                                if(focus)selectAll()
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
                }
            }
            Row{
                spacing: app.fs*0.25
                //anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: '<b>Género: </b>'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.verticalCenter: parent.verticalCenter
                }
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: 'Masculino'
                        font.pixelSize: app.fs*0.25
                        color: 'white'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rbM
                        font.pixelSize: app.fs*0.25
                        anchors.verticalCenter: parent.verticalCenter
                        checked: true
                        onCheckedChanged: {
                            if(checked)rbF.checked=false
                        }
                    }
                }
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: 'Femenino'
                        font.pixelSize: app.fs*0.25
                        color: 'white'
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rbF
                        font.pixelSize: app.fs*0.25
                        anchors.verticalCenter: parent.verticalCenter
                        checked: false
                        onCheckedChanged: {
                            if(checked)rbM.checked=false
                        }
                    }
                }
            }
            Rectangle{
                id: xResults
                width: r.width-app.fs*0.25
                height: children[0].height+app.fs*0.5
                border.width: 2
                border.color: apps.fontColor
                color: 'transparent'
                radius: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    spacing: app.fs*0.5
                    width: r.width-app.fs*0.5
                    anchors.centerIn: parent
                    opacity: r.currentNumPersonalidad!==-1&&r.currentNumNombre!==-1&&r.currentNumNombreInt!==-1&&r.currentNumNombreExt!==-1&&r.currentNumFirma!==-1&&r.currentNumDestino!==-1?1.0:0.5
                    Text{
                        text:'<b>Resultados</b> '
                        font.pixelSize: app.fs*0.75
                        color: apps.fontColor
                        //anchors.verticalCenter: parent.verticalCenter
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>N° de Nacimiento/Karma:</b> '+r.currentNumNacimiento
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                let genero='m'
                                if(rbF.checked)genero='f'
                                panelLog.clear()
                                if(checkBoxFormula.checked){
                                    panelLog.l('N° de Nacimiento/Karma '+r.currentNumNacimiento+'\n')
                                    panelLog.l('Fórmula: '+f0.text+'\n')
                                    panelLog.l(getItemJson('per'+r.currentNumNacimiento+genero))
                                }else{
                                    panelLog.l('¿Cómo es su vibración de nacimiento o karma '+r.currentNumNacimiento+'?\n')
                                    panelLog.l(getItemJson('per'+r.currentNumNacimiento+genero))
                                }
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Personalidad:</b> '+r.currentNumPersonalidad
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                let genero='m'
                                if(rbF.checked)genero='f'
                                panelLog.clear()
                                if(checkBoxFormula.checked){
                                    panelLog.l('Personalidad '+r.currentNumPersonalidad+'\n')
                                    panelLog.l('Fórmula: '+r.sFormulaNumPer+'\n')
                                    panelLog.l(getItemJson('per'+r.currentNumPersonalidad+genero))
                                }else{
                                    panelLog.l('¿Cómo es su personalidad?\n')
                                    panelLog.l(getItemJson('per'+r.currentNumPersonalidad+genero))
                                }
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                    }
                    Rectangle{
                        width: xResults.width-app.fs*0.25
                        height: children[0].height+app.fs*0.5
                        border.width: 2
                        border.color: apps.fontColor
                        color: 'transparent'
                        Column{
                            anchors.centerIn: parent
                            spacing: app.fs*0.25
                            width: parent.width-app.fs*0.5
                            Row{
                                spacing: app.fs*0.5
                                Text{
                                    text:'<b>Nombre:</b> '+r.currentNumNombre
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Comps.ButtonIcon{
                                    text: '\uf06e'
                                    width: app.fs*0.6
                                    height: width
                                    anchors.verticalCenter: parent.verticalCenter
                                    onClicked: {
                                        if(txtDataSearchNom.text==='')return
                                        panelLog.clear()
                                        panelLog.l(getNumNomText(txtDataSearchNom.text))
                                        panelLog.visible=true
                                        panelLog.flk.contentY=0
                                    }
                                }
                            }
                            Text{
                                text:'<b>* Interior:</b> '+r.sFormulaInt+''+r.currentNumNombreInt+'<br />       <b>* Exterior:</b> '+r.sFormulaExt+''+r.currentNumNombreExt
                                width: r.width-app.fs*0.6
                                wrapMode: Text.WordWrap
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                //anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Natalicio:</b> '+r.currentNumNatalicio+' / '+r.sFormulaNatalicio
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(txtDataSearchNom.text==='')return
                                panelLog.clear()
                                panelLog.l(getDataJsonNumDia())
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Firma:</b> '+r.currentNumFirma
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                panelLog.clear()
                                panelLog.l('¿Cómo es la energía de su firma?\n')
                                panelLog.l(getItemJson('firma'+r.currentNumFirma))
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        Text{
                            text:'<b>Destino:</b> '+r.currentNumDestino
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Comps.ButtonIcon{
                            text: '\uf06e'
                            width: app.fs*0.6
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                panelLog.clear()
                                panelLog.l('¿Cómo podría ser su destino?\n')
                                panelLog.l(getItemJson('dest'+r.currentNumDestino))
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                    }
                }
            }

            //            Text{
            //                id: txtPersonalidad
            //                text: opacity<1.0?'Esperando...':'<b>Destino:</b> '+r.currentNumDestino
            //                color: apps.fontColor
            //                font.pixelSize: app.fs*0.5
            //                width: parent.width-app.fs
            //                textFormat: Text.RichText
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                opacity: r.currentNumPersonalidad!==-1&&r.currentNumNombre!==-1&&r.currentNumNombreInt!==-1&&r.currentNumNombreExt!==-1&&r.currentNumFirma!==-1&&r.currentNumDestino!==-1?1.0:0.5
            //            }
            //            Button{
            //                text:  'Calcular'
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                visible: txtPersonalidad.opacity<1.0
            //                onClicked: {
            //                    calc()
            //                }
            //            }

            Rectangle{
                id: xAP
                width: r.width//-app.fs*0.5
                height: colAP.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: colAP
                    spacing: app.fs*0.5
                    anchors.centerIn: parent
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Column{
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                id: labelAP
                                text: '<b>N° Año</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text{
                                id: labelAP2
                                text: '<b>Personal</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.5
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        Rectangle{
                            id: xTiFechaAP
                            width: xForm.width-labelAP.contentWidth-rowAp.width-app.fs
                            height: app.fs*1.2
                            color: apps.backgroundColor
                            border.width: 2
                            border.color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                            Text{
                                text: '<b>Año:</b>'
                                color: apps.fontColor
                                font.pixelSize: app.fs*0.25
                                anchors.bottom: parent.top
                                anchors.bottomMargin: app.fs*0.25
                            }
                            TextInput {
                                id: txtDataSearchFechaAP
                                text: ''
                                font.pixelSize: app.fs*0.5
                                width: parent.width-app.fs*0.2
                                wrapMode: Text.WordWrap
                                color: apps.fontColor
                                focus: true
                                //inputMask: '00.00.0000'
                                anchors.centerIn: parent
                                Keys.onReturnPressed: {
                                    if(text==='')return
                                    //panelLog.l(getNumNomText(text))
                                }
                                onTextChanged: {
                                    calcularAP()
                                }
                                onFocusChanged: {
                                    if(focus)selectAll()
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





                        Row{
                            id: rowAp
                            spacing: app.fs*0.5
                            anchors.verticalCenter: parent.verticalCenter
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
                    Text{
                        id: f1
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.6
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }
            }
            Rectangle{
                id: xBtns
                width: parent.width//-app.fs*0.5
                height: colBtns.height+app.fs
                color: 'transparent'
                border.width: 2
                border.color: apps.fontColor
                radius: app.fs*0.2
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: '<b>Calcular</b>'
                    color: apps.fontColor
                    font.pixelSize: app.fs*0.5
                    anchors.left: parent.left
                    anchors.leftMargin: app.fs*0.25
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.25
                }
                Column{
                    id: colBtns
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: '<b>Mostrar cálculo</b>'
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.25
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        CheckBox{
                            id: checkBoxFormula
                            checked: apps.numShowFormula
                            anchors.verticalCenter: parent.verticalCenter
                            onCheckedChanged: apps.numShowFormula=checked
                        }
                    }
//                    Row{
//                        spacing: app.fs*0.25
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        Button{
//                            text:  'Natalicio'
//                            anchors.verticalCenter: parent.verticalCenter
//                            onClicked: {
//                                if(txtDataSearchNom.text==='')return
//                                panelLog.clear()
//                                panelLog.l(getDataJsonNumDia())
//                                panelLog.visible=true
//                                panelLog.flk.contentY=0
//                            }
//                        }
//                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Años Personales'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                panelLog.clear()
                                panelLog.l(mkDataList())
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                            }
                        }
                        Button{
                            text:  'Calcular todo'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                calc()
                                panelLog.clear()
                                panelLog.l(getTodo())
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                                if(Qt.platform.os!=='android'){
                                    clipboard.setText(panelLog.text)
                                }else{
                                    panelLog.cp()
                                }
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Guardar todo en archivo'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                calc()
                                let fn=unik.getPath(3)+'/'+(txtDataSearchNom.text).replace(/ /g,'_')+'.txt'

                                unik.setFile(fn, getTodo())
                                panelLog.clear()
                                panelLog.l('El archivo se ha guardado en '+fn)
                                panelLog.visible=true
                                panelLog.flk.contentY=0
                                if(Qt.platform.os!=='android'){
                                    clipboard.setText(panelLog.text)
                                }else{
                                    panelLog.cp()
                                }
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            text:  'Limpiar'
                            onClicked: panelLog.clear()
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            text:  'Copiar'
                            onClicked: {
                                if(Qt.platform.os!=='android'){
                                    clipboard.setText(panelLog.text)
                                }else{
                                    panelLog.cp()
                                }
                            }
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tCalc
        running: !panelLog.visible
        repeat: true
        interval: 250
        onTriggered: {
            //calc()
        }
    }
    Component.onCompleted: {
        let date = new Date(Date.now())
        txtDataSearchFechaAP.text=date.getFullYear()
        let a =[]
        let d = 'INICIOS, VIDA NUEVA, RENOVACIONES'
        a.push(d)
        d = 'TOMA DE DESICIONES, SALIR DE TUS FRONTERAS, LA REALIDAD SE TE PONE CARA A CARA, NO PODES ESQUIVARLA, MOMENTO DE HACERSE CARGO, ACEPTAR LA REALIDAD'
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
        calc()
    }
    function getNumNomText(text){
        let ret=''
        let t=text.toUpperCase().replace(/ /g, '')
        let av=[]
        let ac=[]
        let ml=t.split('')
        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            if(l==='A'||l==='E'||l==='I'||l==='O'||l==='U'||l==='Á'||l==='É'||l==='Í'||l==='Ó'||l==='Ú'){
                av.push(l)
            }else{
                ac.push(l)
            }
        }
        let vtv=0
        let vtc=0
        let sfv=''
        let sfc=''
        let rc=0
        for(i=0;i<av.length;i++){
            rc=gvl(av[i])
            vtv+=rc
            if(i===0){
                sfv+=rc
            }else{
                sfv+='+'+rc
            }
        }
        sfv+='='+vtv
        for(i=0;i<ac.length;i++){
            rc=gvl(ac[i])
            vtc+=rc
            if(i===0){
                sfc+=rc
            }else{
                sfc+='+'+rc
            }
        }
        sfc+='='+vtc
        let m0

        let dataInt=''
        let dataExt=''
        let st='int'
        let st2='ext'
        let resM1=-1
        let resM2=-1
        r.currentNumNombreIntM=-1
        r.currentNumNombreExtM=-1
        r.sFormulaInt=''
        r.sFormulaExt=''
        if(vtv===11||vtv===33){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            m0=(''+vtv).split('')
            r.sFormulaInt='Maestro '+vtv+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreIntM=vtv
            //vtv=1
        }
        if(vtv===22||vtv===44){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            m0=(''+vtv).split('')
            r.sFormulaInt='Maestro '+vtv+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreIntM=vtv
        }
        if(vtc===11||vtc===33){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            m0=(''+vtc).split('')
            r.sFormulaExt='Maestro '+vtc+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreExtM=vtc
            //vtc=1
        }
        if(vtc===22||vtc===44){
            dataExt='En su exterior nació con el número Maestro '+vtc+'\n'
            dataExt+=getDataNum('extm', vtc)+'\n\n'
            m0=(''+vtc).split('')
            r.sFormulaExt='Maestro '+vtc+'='+m0[0]+'+'+m0[1]+'='
            r.currentNumNombreExtM=vtc
            //vtc=2
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
            sfv+='='+vtv
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        if(vtc>9){
            m0=(''+vtc).split('')
            vtc=parseInt(m0[0])+parseInt(m0[1])
            sfc+='='+vtc
        }
        //panelLog.l('st:'+st+' vtv:'+vtv)
        if(r.currentNumNombreIntM===-1){
            dataInt+=getDataNum(st, vtv)
        }else{
            dataInt+=getDataNum('intm', r.currentNumNombreIntM)
        }

        r.currentNumNombreInt=vtv
        //panelLog.l('st2:'+st2+' vtc: '+vtc)
        if(r.currentNumNombreExtM===-1){
            dataExt+=getDataNum(st2, vtc)
        }else{
            dataExt+=getDataNum('extm', r.currentNumNombreExtM)
        }
        r.currentNumNombreExt=vtc
        let nunNombre=r.currentNumNombreInt+r.currentNumNombreExt
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(nunNombre>9){
            m0=(''+nunNombre).split('')
            nunNombre=parseInt(m0[0]) + parseInt(m0[1])
        }
        r.currentNumNombre=nunNombre
        let numDestino=nunNombre + r.currentNumFirma
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        if(numDestino>9){
            m0=(''+numDestino).split('')
            numDestino=parseInt(m0[0]) + parseInt(m0[1])
        }
        r.currentNumDestino=numDestino

        if(checkBoxFormula.checked){
            ret+='Vocales: '+av.toString()+'\n'
            ret+='Fórmula de Vocales: '+sfv+'\n'
            ret+='Vibración '+dataInt+'\n'
            ret+='\n'
            ret+='Consonantes: '+ac.toString()+'\n'
            ret+='Fórmula de Consonantes: '+sfc+'\n'
            ret+='Vibración '+dataExt+'\n'
        }else{
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' por dentro?\n\n'+dataInt+'\n\n'
            ret+='¿Cómo es la forma de ser de '+txtDataSearchNom.text+' hacia afuera?\n\n'+dataExt+'\n\n'
        }
        return ret
    }
    function setNumFirma(){
        let t=txtDataSearchFirma.text.toUpperCase().replace(/ /g, '')//.replace(/./g, '')
        let av=[]
        let ml=t.split('')
        //console.log('vtv firma:'+ml)
        for(var i=0;i<ml.length;i++){
            let l=ml[i]
            av.push(l)
        }
        let rc=0
        let vtv=0
        for(i=0;i<av.length;i++){
            rc=gvl(av[i])
            vtv+=rc
            console.log('vtv firma:'+vtv)
        }

        let m0
        if(vtv===11||vtv===33){
            dataInt='En su interior nació con el número Maestro '+vtv+'\n'
            dataInt+=getDataNum('intm', vtv)+'\n\n'
            //vtv=1
        }
        if(vtv===22||vtv===44){
            return vtv
        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])

        }
        if(vtv>9){
            m0=(''+vtv).split('')
            vtv=parseInt(m0[0])+parseInt(m0[1])
        }
        return vtv
    }
    function getDataJsonNumDia(){
        let ret=''
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            return ret
        }
        let stringDia=''
        let dia=parseInt(mfecha[0])
        if(dia>0&&dia<=31){
            stringDia=getDataNumDia(dia)
            ret+='Natalicio en día '+dia+': '+stringDia
        }
        return ret
    }
    function getDataNum(t, v){
        //panelLog.l('t:'+t)
        //panelLog.l('v:'+v)
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./comps/num/numv2.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[''+t+''+v]
        return ret
    }
    function getDataNumDia(dia){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./comps/num/numv2.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json['d'+dia]
        return ret
    }
    function getItemJson(i){
        let ret='?'
        let jsonString
        if(r.jsonNum===''){
            r.jsonNum=unik.getFile('./comps/num/numv2.json')
        }
        jsonString=r.jsonNum.replace(/\n/g, ' ')
        let json=JSON.parse(jsonString)

        ret=json[i]
        return ret
    }
    function gvl(l){
        let r=0
        let col1=['A', 'J', 'R']
        let col2=['B', 'K', 'S']
        let col3=['C', 'L', 'T']
        let col4=['D', 'M', 'U']
        let col5=['E', 'N', 'V']
        let col6=['F', 'Ñ', 'W']
        let col7=['G', 'O', 'X']
        let col8=['H', 'P', 'Y']
        let col9=['I', 'Q', 'Z']
        if(col1.indexOf(l)>=0){
            r=1
        }else if(col2.indexOf(l)>=0){
            r=2
        }else if(col3.indexOf(l)>=0){
            r=3
        }else if(col4.indexOf(l)>=0){
            r=4
        }else if(col5.indexOf(l)>=0){
            r=5
        }else if(col6.indexOf(l)>=0){
            r=6
        }else if(col7.indexOf(l)>=0){
            r=7
        }else if(col8.indexOf(l)>=0){
            r=8
        }else if(col9.indexOf(l)>=0){
            r=9
        }else{
            r=9
        }
        return r
    }
    function mkDataList(){
        let ret=''
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            return ret
        }
        var ai=parseInt(mfecha[2])
        var d =parseInt(mfecha[0])
        var m =parseInt(mfecha[1])
        var sformTodo='Ciclo de Vida Numerológico\n\n'
        //return
        for(var i=ai;i<ai+101;i++){
            var currentNumAP=-1
            var sform=''
            let a = i
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
            for(var i2=0;i2<mSum.length;i2++){
                sum+=parseInt(mSum[i2])
            }
            let mCheckSum=(''+sum).split('')
            if(mCheckSum.length>1){
                let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
                sform+='='+sum+'='+dobleDigSum
                let mCheckSum2=(''+dobleDigSum).split('')
                if(mCheckSum2.length>1){
                    let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                    sform+='='+dobleDigSum2
                    currentNumAP=dobleDigSum2
                }else{
                    currentNumAP=dobleDigSum
                }
            }else{
                currentNumAP=sum
            }
            let edad=a - ai
            var sp
            if(edad===0){
                sp='Período: Desde el nacimiento '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }else{
                sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
            }
            //sformTodo+='Año: '+i+' - Edad: '+edad+' - Ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
            sformTodo+='Año: '+i+' - Edad: '+edad+'\nAño personal de ciclo: '+parseInt(currentNumAP)+'\n'+sp+'\nCálculo: '+sform+'\n'+aDes[currentNumAP - 1]+'\n\n'
        }
        return sformTodo
    }
    function printData(nom, date){
        let genero='m'
        if(rbF.checked)genero='f'
        txtDataSearchNom.text=nom
        let d = date.getDate()
        let m = date.getMonth() + 1
        let a = date.getFullYear()
        let f = d + '/' + m + '/' + a
        let aGetNums=JS.getNums(f)
        let vcurrentNumNacimiento=aGetNums[0]
        panelLog.l('Número de Karma '+vcurrentNumNacimiento+'\n')
        panelLog.l(getNumNomText(nom))
        panelLog.l('¿Cómo es su personalidad?\n\n\n\n\n\n')
        panelLog.l(getItemJson('per'+vcurrentNumNacimiento+genero))
    }
    function calcularAP(){
        r.esMaestro=false
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            f1.text=''
            currentNumAnioPersonal=-1
            return
        }
        let d=mfecha[0]
        let m=mfecha[1]
        let a = txtDataSearchFechaAP.text
        let sf=''+d+'/'+m+'/'+a
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
            if(sum===11||sum===22||sum===33){
                r.esMaestro=true
            }
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
        let edad=a - parseInt(txtDataSearchFechaAP.text)

        let sp='Período: Desde el cumpleaños del día '+d+'/'+m+'/'+a+' hasta el día '+d+'/'+m+'/'+parseInt(a + 1)
        panelLog.l('Año: '+a+' - Edad: '+edad+' - Ciclo: '+parseInt(r.currentNum +1)+'\n'+sp+'\nCálculo: '+f1.text+'\n'+aDes[r.currentNum]+'\n')

    }
    function calcularPersonalidad(){
        r.sFormulaNumPer='Se reduce a un dígito la suma de los números de su fecha de nacimiento ('+r.currentNumNacimiento+') más la suma de todas las letras de su nombre ('+r.currentNumNombre+')\n'
        let ret=r.currentNumNacimiento + r.currentNumNombre
        r.sFormulaNumPer+=''+r.currentNumNacimiento +'+'+ r.currentNumNombre
        let m0
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        if(ret>9){
            m0=(''+ret).split('')
            ret=parseInt(m0[0]) + parseInt(m0[1])
            r.sFormulaNumPer+='='+parseInt(m0[0]) +'+'+ parseInt(m0[1])
        }
        r.sFormulaNumPer+='='+ret
        r.currentNumPersonalidad=ret
    }
    function setCurrentDate(date){
        let d = date.getDate()
        let m = date.getMonth() + 1
        let a = date.getFullYear()
        txtDataSearchFecha.text=d + '.' + m + '.' + a
    }
    function setCurrentNombre(nom){
        txtDataSearchNom.text=nom
    }
    function setCurrentFirma(firma){
        txtDataSearchFirma.text=firma
    }
    function setNumNac(){
        let mfecha=txtDataSearchFecha.text.split('.')
        if(!mfecha[0]||!mfecha[1]||!mfecha[2]||mfecha[2].length<4){
            f0.text=''
            currentNumNacimiento=-1
            return
        }
        let d=mfecha[0]
        let m=mfecha[1]
        let a = mfecha[2]
        let sf=''+d+'/'+m+'/'+a
        let aGetNums=JS.getNums(sf)
        currentNumNacimiento=aGetNums[0]
        let dateP = new Date(parseInt(txtDataSearchFechaAP.text), m - 1, d, 0, 1)
        //controlTimeYear.currentDate=dateP
        r.currentDate = dateP
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
            if(sum===11||sum===22||sum===33){
                //r.esMaestro=true
            }
            let dobleDigSum=parseInt(mCheckSum[0])+parseInt(mCheckSum[1])
            sform+='='+sum+'='+dobleDigSum
            let mCheckSum2=(''+dobleDigSum).split('')
            if(mCheckSum2.length>1){
                let dobleDigSum2=parseInt(mCheckSum2[0])+parseInt(mCheckSum2[1])
                sform+='='+dobleDigSum2
                currentNumNacimiento=dobleDigSum2
            }else{
                currentNumNacimiento=dobleDigSum
            }

        }else{
            currentNumNacimiento=sum
        }
        f0.text=sform
        apps.numUFecha=txtDataSearchFecha.text
        calcularAP()
    }
    function calc(){
        r.currentNumFirma=setNumFirma()
        setNumNac()
        let dataNombre=getNumNomText(txtDataSearchNom.text)
        setPins()
    }
    function getTodo(){
        let ret=''
        let genero='m'
        if(rbF.checked)genero='f'
        ret+='\n\nCuadro Numerológico de '+txtDataSearchNom.text+'\n\n'
        if(checkBoxFormula.checked){
            ret+='Personalidad '+r.currentNumPersonalidad+'\n'
            ret+='Fórmula: '+r.sFormulaNumPer+'\n'

            ret+=getItemJson('per'+r.currentNumPersonalidad+genero)
        }else{
            ret+='¿Cómo es su personalidad?\n\n'
            ret+=getItemJson('per'+r.currentNumPersonalidad+genero)
        }
        ret+='\n\n'

        //Número de nacimiento o karma
        if(checkBoxFormula.checked){
            ret+='N° de Nacimiento/Karma '+r.currentNumNacimiento+'\n\n'
            ret+='Fórmula: '+f0.text+'\n'
            ret+=getItemJson('per'+r.currentNumNacimiento+genero)
        }else{
            ret+='¿Cómo es su vibración de nacimiento o karma '+r.currentNumNacimiento+'?\n\n'
            ret+=getItemJson('per'+r.currentNumNacimiento+genero)
        }
        ret+='\n\n'

        //Nombre
        ret+=getNumNomText(txtDataSearchNom.text)
        //ret+='\n'

        //Natalicio
        ret+=getDataJsonNumDia()
        ret+='\n\n'

        //Firma
        ret+='¿Cómo es la energía de su firma?\n\n'
        ret+=getItemJson('firma'+r.currentNumFirma)
        ret+='\n\n'

        //Destino
        ret+='¿Cómo podría ser su destino?\n\n'
        ret+=getItemJson('dest'+r.currentNumDestino)
        ret+='\n\n'

        //Pinaculos
        ret+='Pináculos\n\n'
        ret+='1° Pináculo del tipo '+r.currentTipoPin1+': Desde los '+r.currentPin1+' hasta '+parseInt(r.currentPin2)+' años.\n'
        ret+=getItemJson('pin'+r.currentTipoPin1)
        ret+='\n\n'

        ret+='2° Pináculo del tipo '+r.currentTipoPin2+': Desde los '+r.currentPin2+' hasta '+parseInt(r.currentPin3)+' años.\n'
        ret+=getItemJson('pin'+r.currentTipoPin2)
        ret+='\n\n'

        ret+='3° Pináculo del tipo '+r.currentTipoPin3+': Desde los '+r.currentPin3+' hasta '+parseInt(r.currentPin4)+' años.\n'
        ret+=getItemJson('pin'+r.currentTipoPin3)
        ret+='\n\n'

        ret+='4° Pináculo del tipo '+r.currentTipoPin4+': Desde los '+r.currentPin4+' hasta el final de la vida.\n'
        ret+=getItemJson('pin'+r.currentTipoPin4)
        ret+='\n\n'

        ret+='\n'


        //Lista de 100 años personales
        ret+=mkDataList()
        ret+='\n\n'

        //Créditos
        let dt=new Date(Date.now())
        ret+='Cuadro numerológico creado en fecha '+dt.toString()+'\n'
        ret+='Utilizando la aplicación NumPit desarrollada por Ricardo Martín Pizarro. Whatsapp +549 11 3802 4370. E-Mail: nextsigner@gmail.com\n'
        ret+='\n\n'
        return ret
    }
    function setPins(){
        let p1=36-r.currentNumNacimiento
        r.currentPin1=p1
        r.currentPin2=p1+9
        r.currentPin3=p1+9+9
        r.currentPin4=p1+9+9+9
        let m0

        let mfecha=txtDataSearchFecha.text.split('.')

        //Calculando tipo de pináculo 1
        let tPin=parseInt(mfecha[0]) + parseInt(mfecha[1])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin1=tPin

        //Calculando tipo de pináculo 2
        let mAnio=(''+mfecha[2]).split('')
        tPin=parseInt(mfecha[0]) + parseInt(mAnio[0]) + parseInt(mAnio[1]) + parseInt(mAnio[2]) + parseInt(mAnio[3])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin2=tPin

        //Calculando tipo de pináculo 3
        tPin=r.currentTipoPin1 + r.currentTipoPin2
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin3=tPin

        //Calculando tipo de pináculo 4
        tPin=parseInt(mfecha[1]) + parseInt(mAnio[0]) + parseInt(mAnio[1]) + parseInt(mAnio[2]) + parseInt(mAnio[3])
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        if(tPin>9){
            m0=(''+tPin).split('')
            tPin=parseInt(m0[0])+parseInt(m0[1])
        }
        r.currentTipoPin4=tPin
    }
}