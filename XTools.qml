import QtQuick 2.0
import QtQuick.Controls 2.0
import "./comps"
import "Funcs.js" as JS

Rectangle {
    id: r
    width: app.fs*6
    height: app.fs*3
    border.width: 0
    border.color: 'red'
    color: 'transparent'
    Column{
        spacing: app.fs*0.25
        //anchors.centerIn: r
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: app.fs*0.1
        //        Button{
        //            text: app.uSon
        //            width: app.fs*3
        //            height: app.fs*0.6
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            visible: app.uSon!==''
        //            onClicked: {
        //                JS.showIW()
        //            }
        //        }
        Row{
            spacing: app.fs*0.25
            anchors.right: parent.right
            Button{
                text: 'MODO '+parseInt(sweg.aStates.indexOf(sweg.state) + 1)
                width: app.fs*2
                height: app.fs*0.6
                onClicked: {
                    sweg.nextState()
                }
            }
            ButtonIcon{
                text:  'N'
                width: apps.botSize
                height: width
                onClicked: {
                    ncv.visible=true
                    //                    let comp=Qt.createComponent("./comps/num/NumCiclosVida.qml")
                    //                    let d = new Date(Date.now())
                    //                    let obj=comp.createObject(capa101, {currentDate: d, width: xApp.width, height: xApp.height})
                }
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.right: parent.right
            Rectangle{
                width: rowBotsSabInt.width+app.fs*0.35
                height: apps.botSize+app.fs*0.35
                color: apps.houseColor
                anchors.verticalCenter: parent.verticalCenterenter
                Row{
                    id: rowBotsSabInt
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    ButtonIcon{
                        text:  '<b>S</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJson.pc.c0
                                let gf=h1.rsgdeg//app.currentGradoSolar-gr
                                app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>A</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJson.ph.h1
                                app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>M</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJson.ph.h10
                                app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: rowBotsSabIntBack.width+app.fs*0.35
                height: apps.botSize+app.fs*0.35
                color: apps.houseColorBack
                anchors.verticalCenter: parent.verticalCenter
                visible: app.ev
                Row{
                    id: rowBotsSabIntBack
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    ButtonIcon{
                        text:  '<b>S</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.pc.c0
                                let gf=h1.rsgdeg//app.currentGradoSolar-gr
                                app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>A</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.ph.h1
                                app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>M</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.ph.h10
                                app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                }
            }
        }
        Row{
            spacing: app.fs*0.1
            Button{
                id: botEditSin
                text: 'Crear Sinastria'
                //width: app.fs*3
                height: app.fs*0.6
                anchors.verticalCenter: parent.verticalCenter
                visible: app.ev&&app.mod!=='sin'
                onClicked: {
                    JS.mkSinFile(apps.urlBack)
                }
            }
            Button{
                id: botEdit
                text: xEditor.visible?'Ocultar Informe':'Ver Informe'
                //width: app.fs*3
                height: app.fs*0.6
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(!xEditor.visible){
                        xEditor.showInfo()
                    }else{
                        xEditor.visible=false
                    }
                }
            }
            ComboBox{
                id: cbHsys
                width: app.fs*4
                height: app.fs*0.75
                model: app.ahysNames
                currentIndex: app.ahys.indexOf(apps.currentHsys)
                //anchors.bottom: parent.bottom
                onCurrentIndexChanged: {
                    if(currentIndex===app.ahys.indexOf(apps.currentHsys))return
                    apps.currentHsys=app.ahys[currentIndex]
                    //JS.showMsgDialog('Zool Informa', 'El sistema de casas ha cambiado.', 'Se ha seleccionado el sistema de casas '+app.ahysNames[currentIndex]+' ['+app.ahys[currentIndex]+'].')
                    //sweg.load(JSON.parse(app.currentData))
                    JS.loadJson(apps.url)
                }
            }
        }

        //}
    }
}
