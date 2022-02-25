import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12

Rectangle {
    id: r
    color: apps.backgroundColor
    x:apps.repLectX
    y: apps.repLectY
    width: apps.repLectW
    height: apps.repLectH
    border.width: 1
    border.color: apps.fontColor
    clip: true
    onXChanged: apps.repLectX=x
    onYChanged: apps.repLectY=y
    FolderListModel{
        id: flm
        folder: '/media/ns/WD/vnRicardo'
        showDirs: false
        showFiles: true
        showHidden: false
        nameFilters: [ "*.*" ]
        sortReversed: true
        sortField: FolderListModel.Time
        onCountChanged: {
            playList.clear()
            for(var i=0;i<count;i++){
                let s=flm.folder+'/'+flm.get(i,'fileName')
                playList.addItem(s)
            }
        }
    }
    MediaPlayer{
        id: videoPlayer
        autoPlay: true
        playlist: Playlist{
            id: playList
            onCurrentIndexChanged: {
                app.currentPlanetIndex=currentIndex
            }
        }
        onPlaybackStateChanged: {
            if(videoPlayer.playbackState===MediaPlayer.PlayingState){
                tAutoMaticPlanets.stop()
                //app.currentPlanetIndex=0
            }
            if(videoPlayer.playbackState===MediaPlayer.StoppedState){
                //app.currentPlanetIndex++
            }
        }
    }

    Grid{
        spacing: app.fs*0.25
        columns: 30
        anchors.centerIn: parent
        Repeater{
            model:480
            Rectangle{
                width: 2
                height: 2
            }
        }
    }
    Text{
        text: '<b>Video Player</b>'
        font.pixelSize: app.fs
        color: apps.fontColor
        anchors.centerIn: parent
    }

    VideoOutput{
        id: videoPlayerOutPut
        source: videoPlayer
        width: parent.width
        height: parent.height
        anchors.bottom: parent.bottom
    }
    MouseArea{
        drag.target: r
        drag.axis: Drag.XAndYAxis
        anchors.fill: r
        onClicked: {
            if(videoPlayer.playbackState===MediaPlayer.PlayingState){
                videoPlayer.pause()
            }else{
                videoPlayer.play()
            }
        }
        onWheel: {
            //apps.enableFullAnimation=false
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    if(apps.repLectW<xApp.width*0.2){
                        apps.repLectW+=1
                    }
                }else{
                    if(apps.repLectW>app.fs*6){
                        apps.repLectW-=1
                    }
                }
            }else{
                if(wheel.angleDelta.y>=0){
                    if(apps.repLectH<xApp.width*0.3){
                        apps.repLectH+=1
                    }
                }else{
                    if(apps.repLectH>app.fs*2){
                        apps.repLectH-=1
                    }
                }
            }
            //reSizeAppsFs.restart()
        }
    }
    Text{
        text: 'C:'+playList.currentIndex
        font.pixelSize: 30
        color: 'red'
    }
}
