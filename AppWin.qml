import QtQuick 2.12
import QtQuick.Controls 2.12


ApplicationWindow {
    id: r
    property alias ip: itemXPlanets
    Item{
        id: itemXPlanets
        anchors.fill: parent
        //XPlanets{id: xPlanets}
        function showSS(){
            let comp=Qt.createComponent("XPlanets.qml")
            let obj=comp.createObject(itemXPlanets)
            if(obj){
                app.sspEnabled=true
            }
        }
        function hideSS(){
            for(var i=0;itemXPlanets.children.length;i++){
                itemXPlanets.children[i].destroy(1)
            }
        }
        Component.onCompleted: {
            if(unik.objectName!=='unikpy'){
                showSS()

            }
        }        
    }

    Shortcut{
        sequence: 'Ctrl+Down'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.ctrlDown()
                return
            }
            xBottomBar.state=xBottomBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.ctrlUp()
                return
            }
            xDataBar.state=xDataBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Space'
        onActivated: {
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }

    Shortcut{
        sequence: 'Ctrl+Space'
        onActivated: {
            if(app.currentPlanetIndex>=0&&app.currentXAs){
                app.showPointerXAs=!app.showPointerXAs
                return
            }
            if(panelZonaMes.state==='show'){
                panelZonaMes.pause()
                return
            }
            sweg.nextState()
            //swegz.sweg.nextState()
        }
    }
    Shortcut{
        sequence: 'Ctrl+0'
        onActivated: {
            panelDataBodies.currentIndex=-1
            //app.lock=!app.lock
        }
    }
    Shortcut{
        sequence: 'Return'
        onActivated: {
            if(panelNewVNA.state==='show'){
                panelNewVNA.enter()
                return
            }
            if(panelRsList.state==='show'){
                panelRsList.enter()
                return
            }
            if(xBottomBar.state==='show'){
                xBottomBar.enter()
                return
            }
            if(panelFileLoader.state==='show'){
                panelFileLoader.enter()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            if(menuBar.expanded){
                menuBar.e()
                return
            }
            if(xEditor.visible){
                //xEditor.enter()
                //return
            }
            if(panelNewVNA.state==='show'){
                panelNewVNA.enter()
                return
            }
            if(panelRsList.state==='show'){
                panelRsList.enter()
                return
            }
            if(panelFileLoader.state==='show'){
                panelFileLoader.enter()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            if(ncv.visible){
                ncv.visible=false
                return
            }
            if(xEditor.visible&&xEditor.e.textEdit.focus){
                xEditor.e.textEdit.focus=false
                xEditor.focus=true
                return
            }
            if(xEditor.visible&&xEditor.editing){
                xEditor.editing=false
                xEditor.e.textEdit.focus=false
                xEditor.focus=true
                return
            }
            if(xEditor.visible){
                xEditor.visible=false
                return
            }
            if(app.currentPlanetIndex>=0){
                app.currentPlanetIndex=-1
                return
            }
            if(app.currentPlanetIndexBack>=0){
                app.currentPlanetIndexBack=-1
                return
            }
            if(xSabianos.visible){
                xSabianos.visible=false
                return
            }
            if(xBottomBar.objPanelCmd.state==='show'){
                xBottomBar.objPanelCmd.state='hide'
                return
            }
            if(panelRsList.state==='show'){
                panelRsList.state='hide'
                return
            }
            if(panelFileLoader.state==='show'){
                panelFileLoader.state='hide'
                return
            }
            if(panelDataBodies.state==='show'){
                panelDataBodies.state='hide'
                return
            }
            if(panelNewVNA.state==='show'){
                panelNewVNA.state='hide'
                return
            }
            if(panelControlsSign.state==='show'){
                panelControlsSign.state='hide'
                return
            }
            if(xInfoData.visible){
                xInfoData.visible=false
                return
            }
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(panelNewVNA.state==='show'){
                panelNewVNA.toUp()
                return
            }
            if(menuBar.expanded){
                menuBar.u()
                return
            }
            if(xSabianos.visible){
                xSabianos.toup()
                return
            }
            if(panelFileLoader.state==='show'){
                if(panelFileLoader.currentIndex>0){
                    panelFileLoader.currentIndex--
                }else{
                    panelFileLoader.currentIndex=panelFileLoader.listModel.count-1
                }
                return
            }
            if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                if(currentSignIndex>0){
                    currentSignIndex--
                }else{
                    currentSignIndex=12
                }
                return
            }
            if(panelRsList.state==='show'){
                if(panelRsList.currentIndex>0){
                    panelRsList.currentIndex--
                }else{
                    panelRsList.currentIndex=panelRsList.listModel.count-1
                }
                return
            }
            if(currentPlanetIndex>-1){
                currentPlanetIndex--
            }else{
                currentPlanetIndex=17
            }
            //xAreaInteractiva.back()
        }
    }
    Shortcut{
        sequence: 'Down'
        //enabled: !menuBar.expanded
        onActivated: {
            if(panelNewVNA.state==='show'){
                panelNewVNA.toDown()
                return
            }
            if(menuBar.expanded){
                menuBar.d()
                return
            }
            if(xSabianos.visible){
                xSabianos.todown()
                return
            }
            if(panelFileLoader.state==='show'){
                if(panelFileLoader.currentIndex<panelFileLoader.listModel.count){
                    panelFileLoader.currentIndex++
                }else{
                    panelFileLoader.currentIndex=0
                }
                return
            }
            if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                if(currentSignIndex<12){
                    currentSignIndex++
                }else{
                    currentSignIndex=0
                }
                return
            }
            if(panelRsList.state==='show'){
                if(panelRsList.currentIndex<panelRsList.listModel.count-1){
                    panelRsList.currentIndex++
                }else{
                    panelRsList.currentIndex=0
                }
                return
            }
            if(currentPlanetIndex<17){
                currentPlanetIndex++
            }else{
                currentPlanetIndex=-1
            }
            //xAreaInteractiva.next()
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(panelNewVNA.state==='show'){
                panelNewVNA.toLeft()
                return
            }
            if(app.currentPlanetIndex>=0 && app.currentXAs){
                app.currentXAs.rot(false)
                return
            }
            if(menuBar.expanded&&!xSabianos.visible){
                menuBar.left()
                return
            }
            if(xSabianos.visible){
                xSabianos.toleft()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(panelNewVNA.state==='show'){
                panelNewVNA.toRight()
                return
            }
            if(app.currentPlanetIndex>=0 && app.currentXAs){
                app.currentXAs.rot(true)
                return
            }
            if(menuBar.expanded&&!xSabianos.visible){
                menuBar.right()
                return
            }

            if(xSabianos.visible){
                xSabianos.toright()
                return
            }

        }
    }

    //Restaurar xAs Pointer rotation
    Shortcut{
        sequence: 'r'
        onActivated: {
            app.currentXAs.restoreRot()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+a'
        onActivated: {
            apps.lt=!apps.lt
        }
    }
    //Mostrar/Ocultar MenuBar
    Shortcut{
        sequence: 'Ctrl+m'
        onActivated: {
            apps.showMenuBar=!apps.showMenuBar
        }
    }
    //Mostrar/Ocultar Panel Numerología
    Shortcut{
        sequence: 'Ctrl+d'
        onActivated: {
            ncv.visible=!ncv.visible
        }
    }
    //Mostrar / Ocultar Decanatos
    Shortcut{
        sequence: 'Ctrl+Shift+d'
        onActivated: {
            apps.showDec=!apps.showDec
            //swegz.sweg.objSignsCircle.showDec=!swegz.sweg.objSignsCircle.showDec
        }
    }
    //Mostrar Panel para Cargar Archivos
    Shortcut{
        sequence: 'Ctrl+f'
        onActivated: {
            panelFileLoader.state=panelFileLoader.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel PL Signos
    Shortcut{
        sequence: 'Ctrl+w'
        onActivated: {
            panelControlsSign.state=panelControlsSign.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel Editor de Pronósticos
    Shortcut{
        sequence: 'Ctrl+e'
        onActivated: {
            panelPronEdit.state=panelPronEdit.state==='show'?'hide':'show'
        }
    }
    //Mostrar Mostrar Reloj
//    Shortcut{
//        sequence: 'Ctrl+t'
//        onActivated: {
//            apps.showTimes=!apps.showTimes
//        }
//    }
    //Mostrar Panel para Lineas de Comando
    Shortcut{
        sequence: 'Ctrl+Shift+c'
        onActivated: {
            xBottomBar.objPanelCmd.state=xBottomBar.objPanelCmd.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Cuerpos
    Shortcut{
        sequence: 'Ctrl+i'
        onActivated: {
            panelDataBodies.state=panelDataBodies.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel para Crear Nuevo VN
    Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            panelNewVNA.state=panelNewVNA.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Revoluciones Solares
    Shortcut{
        sequence: 'Ctrl+r'
        onActivated: {
            panelRsList.state=panelRsList.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Aspectos en Transito
    Shortcut{
        sequence: 'Ctrl+t'
        onActivated: {
            panelAspTransList.state=panelAspTransList.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+p'
        onActivated: {
            panelZonaMes.state=panelZonaMes.state==='hide'?'show':'hide'
        }
    }
    Shortcut{
        sequence: 'Ctrl+s'
        onActivated: {
            if(xEditor.visible){
                xEditor.save()
                return
            }
            panelSabianos.state=panelSabianos.state==='hide'?'show':'hide'
        }
    }
    Shortcut{
        sequence: 'Ctrl+x'
        onActivated: {
            if(xEditor.visible){
                xEditor.close()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+Down'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.zoomDown()
                return
            }
            //signCircle.subir()
            sweg.objSignsCircle.rotarSegundos(0)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+Up'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.zoomUp()
                return
            }
            //signCircle.bajar()
            sweg.objSignsCircle.rotarSegundos(1)
        }
    }
    Shortcut{
        sequence: 'Ctrl++'
        onActivated: {
            sweg.width+=app.fs
        }
    }
    Shortcut{
        sequence: 'Ctrl+-'
        onActivated: {
            sweg.width-=app.fs
        }
    }
}
