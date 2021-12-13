import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: parent.width//sweg.fs*4
    height: width
    anchors.centerIn: parent
    z:r.parent.z-1
    rotation: 0-signCircle.rotation
    //visible: p===0
    property int iconoSignRot: 0
    property int is: -1
    property int gdeg: -1
    property int mdeg: -1
    property int sdeg: -1
    property int rsgdeg: -1
    property int ih: -1
    property bool expand: false
    property int wtc: (sweg.fs*0.5)/(sweg.xs*0.5) //width of each circle de triple circle
    property int p: -1
    Rectangle{
        width: r.width
        height: 8
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        Rectangle{
            width: parent.width*0.5
            height: apps.pointerLineWidth
            color: apps.pointerLineColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: r.parent.parent.planetSize+apps.pointerLineWidth
            Rectangle{
                width: col.width+app.fs
                height: col.height+app.fs
                color: apps.fontColor
                border.width: 3
                border.color: apps.pointerLineColor
                radius: app.fs*0.5
                rotation: r.iconoSignRot
                anchors.right: parent.right
                anchors.rightMargin: parent.height*0.5
                anchors.verticalCenter: parent.verticalCenter
                Column{
                    id: col
                    anchors.centerIn: parent
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: app.planetas[r.p]+' en '+app.signos[r.is]
                            font.pixelSize: app.fs
                            color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: app.fs*2
                            height: width
                            radius: width*0.5
                            color: apps.fontColor
                            border.width: 2
                            border.color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img1
                                source: "./resources/imgs/signos/"+r.is+".svg"
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                                //rotation: r.iconoSignRot + 60 - r.rotation
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co1
                                anchors.fill: img1
                                source: img1
                                color: apps.backgroundColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                        }

                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            text: 'En el grado °'+r.gdeg+'\''+r.mdeg+' Casa '
                            font.pixelSize: app.fs
                            color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Rectangle{
                            width: app.fs*2
                            height: width
                            radius: width*0.5
                            color: apps.fontColor
                            border.width: 2
                            border.color: apps.backgroundColor
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img2
                                source: "./resources/imgs/casa.svg"
                                width: parent.width
                                height: width
                                rotation: r.iconoSignRot + 180 - r.rotation
                                antialiasing: true
                                visible: false
                            }
                            ColorOverlay {
                                id: co2
                                anchors.fill: img2
                                source: img2
                                color: apps.backgroundColor
                                //rotation: img1.rotation
                                antialiasing: true
                            }
                            Text{
                                font.pixelSize: r.ih<=9?parent.width*0.8:parent.width*0.6
                                text: '<b>'+r.ih+'</b>'
                                color: 'white'
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
            Canvas {
                id:canvasSen
                width: apps.pointerLineWidth*4
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0-width*0.5
                antialiasing: true
                onPaint:{
                    var ctx = canvasSen.getContext('2d');
                    ctx.beginPath();
                    ctx.moveTo(0, canvasSen.width*0.5);
                    ctx.lineTo(canvasSen.width, 0);
                    ctx.lineTo(canvasSen.width, canvasSen.width);
                    ctx.lineTo(0, canvasSen.width*0.5);
                    ctx.strokeStyle = apps.pointerLineColor
                    ctx.lineWidth = 1//canvasSen.parent.height;
                    ctx.fillStyle = apps.pointerLineColor
                    ctx.fill();
                    ctx.stroke();
                }
            }
        }
    }
}
