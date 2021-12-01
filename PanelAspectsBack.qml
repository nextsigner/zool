import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: cellWidth*15
    height: cellWidth*15
    color: 'transparent'
    antialiasing: true
    property int cellWidth: app.fs*0.5
    Row{
        id: row
        Repeater{
            model: r.visible?15:0
            CellColumnAspBack{planet: index;cellWidth: r.cellWidth; objectName: 'cellRowAsp_'+index}
        }
    }
    MouseArea{
        anchors.fill: r
        enabled: sweg.state!==sweg.aStates[2]
        onClicked: {
            sweg.state=sweg.aStates[2]
            //swegz.sweg.state=sweg.aStates[2]
        }
        //Rectangle{anchors.fill: parent; color: 'red';opacity:0.5}
    }
    Button{
        id: bot
        width: r.cellWidth
        height: width
        text:  ''
        //checkable: true
        //checked: apps.showAspCircle
        anchors.bottom: parent.top
        rotation: 180
        onClicked: {
            apps.showAspCircleBack=!apps.showAspCircleBack
        }
        Text{
            text:  apps.showAspCircleBack?'\uf06e':'\uf070'
            font.family: "FontAwesome"
            font.pixelSize: r.cellWidth*0.8
            opacity: apps.showAspCircleBack?1.0:0.65
            anchors.centerIn: parent
        }
    }
    function clear(){
        if(!r.visible)return
        for(var i=0;i<15;i++){
            let column=row.children[i]
            column.clear()
        }
    }
    function setAsp2(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        let column=row.children[c2]
        let cellRow=column.col.children[c1]
        cellRow.indexAsp=ia
        cellRow.indexPosAsp=iPosAsp
    }
    function setAsp(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        setAsp2(c1,c2,ia,iPosAsp)
        setAsp2(c2,c1,ia,iPosAsp)
    }
    function load(jsonData){

        if(!r.visible)return
        //console.log('PanelAspectsBack jsonData: '+JSON.stringify(jsonData))
        clear()
        if(!jsonData.asps)return
        let asp=jsonData.asps
        for(var i=0;i<Object.keys(asp).length;i++){
            if(asp['asp'+parseInt(i +1)]){
                if(asp['asp'+parseInt(i +1)]){
                    if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                        continue
                    }else{
                        let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i)
                    }
                }
            }
        }
    }
}
