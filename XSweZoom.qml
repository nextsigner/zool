import QtQuick 2.0

Rectangle {
    id:mappanel
    visible: true
    width:xApp.width
    height:xApp.width
    color: "white"

    Flickable
    {
        id: flick
        anchors.fill: parent
        clip: true

        // Map
        Rectangle {
            id: rect
            border.width: 2
            width: Math.max(mapImage.sourceSize.width, flick.width)
            height: Math.max(mapImage.sourceSize.height, flick.height)
            transform: Scale {
                id: scaler
                origin.x: pinchArea.m_x2
                origin.y: pinchArea.m_y2
                xScale: pinchArea.m_zoom2
                yScale: pinchArea.m_zoom2
            }

            Image
            {
                id: mapImage
                z: dragArea.z+1
                source: "file:///home/ns/Descargas/foto.jpeg"
                //anchors.centerIn: parent
                //fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }

            PinchArea {
                id: pinchArea
                anchors.fill: parent
                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 0.5
                property real m_zoom2: 0.5
                property real m_max: 2
                property real m_min: 0.5

                onPinchStarted: {
                    console.log("Pinch Started")
                    m_x1 = scaler.origin.x
                    m_y1 = scaler.origin.y
                    m_x2 = pinch.startCenter.x
                    m_y2 = pinch.startCenter.y
                    rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                    rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                }
                onPinchUpdated: {
                    console.log("Pinch Updated")
                    m_zoom1 = scaler.xScale
                    var dz = pinch.scale-pinch.previousScale
                    var newZoom = m_zoom1+dz
                    if (newZoom <= m_max && newZoom >= m_min) {
                        m_zoom2 = newZoom
                    }
                }
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: rect
                    drag.filterChildren: true

                    onWheel: {
                        console.log("Wheel Scrolled")
                        pinchArea.m_x1 = scaler.origin.x
                        pinchArea.m_y1 = scaler.origin.y
                        pinchArea.m_zoom1 = scaler.xScale
                        pinchArea.m_x2 = mouseX
                        pinchArea.m_y2 = mouseY

                        var newZoom
                        if (wheel.angleDelta.y > 0) {
                            newZoom = pinchArea.m_zoom1+0.1
                            if (newZoom <= pinchArea.m_max) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_max
                            }
                        } else {
                            newZoom = pinchArea.m_zoom1-0.1
                            if (newZoom >= pinchArea.m_min) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_min
                            }
                        }
                        rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                        rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)

                        console.debug(rect.width+" -- "+rect.height+"--"+rect.scale)

                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Click in child")
                    }
                }
            }
        }
    }
}
