import QtQuick 2.0
import QtQuick.Controls 2.0
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
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                text: 'MODO '+parseInt(sweg.aStates.indexOf(sweg.state) + 1)
                //width: app.fs*1.5
                height: app.fs*0.6
                onClicked: {
                    sweg.nextState()
                }
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                width: rowBotsSabInt.width+app.fs*0.35
                height: apps.botSize+app.fs*0.35
                color: apps.houseColor
                anchors.verticalCenter: parent.verticalCenterenter
                Row{
                    id: rowBotsSabInt
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    Button{
                        text: 'S'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJson.pc.c0
                            let gf=h1.rsgdeg//app.currentGradoSolar-gr
                            app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                        }
                    }
                    Button{
                        text: 'A'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJson.ph.h1
                            app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                        }
                    }
                    Button{
                        text: 'M'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJson.ph.h10
                            app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
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
                    Button{
                        text: 'S'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJsonBack.pc.c0
                            let gf=h1.rsgdeg//app.currentGradoSolar-gr
                            app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                        }
                    }
                    Button{
                        text: 'A'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJsonBack.ph.h1
                            app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                        }
                    }
                    Button{
                        text: 'M'
                        font.pixelSize: app.fs*0.35
                        width: apps.botSize
                        height: width
                        onClicked: {
                            let h1=app.currentJsonBack.ph.h10
                            app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                            JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                        }
                    }
                }
            }
        }
        Rectangle{
            id: xVerLupa
            width: children[0].width+app.fs*0.25
            height: children[0].height+app.fs*0.25
            color: 'transparent'
            border.width: apps.showLupa?1:0
            border.color: 'white'
            anchors.right: parent.right
            Row{
                anchors.centerIn: parent
                spacing: apps.botSize*0.25
                Row{
                    spacing: app.fs*0.25
                    anchors.verticalCenter: parent.verticalCenter
                    visible: apps.showLupa
                    Button{
                        width: apps.botSize
                        height: width
                        text:  ''
                        onClicked: {
                            if(apps.lupaMod<2){
                                apps.lupaMod++
                            }else{
                                apps.lupaMod=0
                            }
                            xLupa.mod=apps.lupaMod
                        }
                        Text{
                            text:  '<b>'+parseInt(xLupa.mod + 1)+'</b>'
                            font.family: "FontAwesome"
                            font.pixelSize: parent.width*0.8
                            anchors.centerIn: parent
                        }
                    }
                    Button{
                        width: apps.botSize
                        height: width
                        text:  ''
                        onClicked: {
                            apps.lt=!apps.lt
                        }
                        Text{
                            text:  apps.lt?'\uf245':'\uf255'
                            font.family: "FontAwesome"
                            font.pixelSize: parent.width*0.8
                            anchors.centerIn: parent
                        }
                    }
                    Button{
                        width: apps.botSize
                        height: width
                        text:  ''
                        onClicked: {
                            xLupa.x=xLupa.parent.width*0.5-xLupa.height*0.5
                            xLupa.y=xLupa.parent.height*0.5-xLupa.width*0.5+sweg.verticalOffSet-sweg.fs*0.5
                        }
                        Text{
                            text:  '\uf05b'
                            font.family: "FontAwesome"
                            font.pixelSize: parent.width*0.8
                            anchors.centerIn: parent
                        }

                    }
                }
                Button{
                    width: apps.botSize
                    height: width
                    text:  ''
                    opacity: apps.showLupa?1.0:0.5
                    onClicked: {
                        apps.showLupa=!apps.showLupa
                        //apps.showAspCircle=!apps.showAspCircle
                    }
                    Text{
                        text:  apps.showLupa?'\uf010':'\uf002'
                        font.family: "FontAwesome"
                        font.pixelSize: parent.width*0.8
                        anchors.centerIn: parent
                    }
                }
            }
        }
        Item{
            anchors.horizontalCenter: parent.horizontalCenter
            width: app.fs*3//xVerLupa.width
            height: cbHsys.height
            Row{
                spacing: app.fs*0.1
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.left
                anchors.rightMargin: app.fs*0.1
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
    }
}
