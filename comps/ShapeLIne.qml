import QtQuick 2.15
import QtQuick.Shapes 1.12
//import QtQuick.Extras 1.4

Rectangle{
    id: r
    width: parent.width
    height: parent.width
    color: 'transparent'
    radius: width*0.5
    border.width: 0
    border.color: 'red'
    //anchors.centerIn: parent

    property int n: 0
    property alias sx: sp.startX
    property alias sy: sp.startY
    property alias px: p.x
    property alias py: p.y
    property color c: 'red'
    Shape {
        id: shape
        //anchors.fill: parent
        width: parent.width-apps.aspLineWidth//*1.8
        height: width
        anchors.centerIn: parent
        containsMode: Shape.FillContains
        function clicked(){
            Qt.quit()
        }
        HoverHandler {
            id: hoverHandler
        }
        TapHandler {
            onTapped: print("Hexagon clicked")
        }
        ShapePath {
            id: sp
            strokeColor: r.c
            strokeWidth: apps.aspLineWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            property int joinStyleIndex: 2
            property variant styles: [
                ShapePath.BevelJoin,
                ShapePath.MiterJoin,
                ShapePath.RoundJoin
            ]
            joinStyle: styles[joinStyleIndex]
            startX: 0
            startY: 0
            PathLine {id: p}
        }
    }

}
