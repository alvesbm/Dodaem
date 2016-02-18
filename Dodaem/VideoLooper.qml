import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id:rootVL
    anchors.fill: parent
    property string videoFile: "http://127.0.0.1/blue.mp4"
    property int trasitionDuration: 1000
    color: "black"
    onVideoFileChanged: {playerA.source = rootVL.videoFile; playerB.source = rootVL.videoFile}



    states: [
        State {
            name: "onA"
            PropertyChanges {
                target: frameA
                opacity:1
            }
        },
        State {
            name: "onB"
            PropertyChanges {
                target: frameA
                opacity:0
            }
        }
    ]
    Timer {
        id: timer
        interval:2000

        running: false
        onTriggered: {if (rootVL.state!="onB"){
            playerB.play();
            rootVL.state="onB";
            } else {
                playerA.play();
                rootVL.state="onA";
            }
            stopTimer.restart();
        }
    }

    Timer {
        id: stopTimer
        interval:rootVL.trasitionDuration

        running: false
        triggeredOnStart: false
        onTriggered: {if (rootVL.state!="onB"){
            playerB.stop();
            playerB.seek(0);
            } else {
                playerA.stop();
                playerA.seek(0);
            }
        }
    }
/**/
    MediaPlayer {
        id: playerB
        source: rootVL.videoFile
        autoPlay: false
        onPlaying: {timer.restart()}
        muted: true
    }

        VideoOutput {
            id: videoB
            source: playerB
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop
        }



    MediaPlayer {
        id: playerA
        source: rootVL.videoFile
        autoPlay: true

        muted: true
        onPlaying: {timer.restart()}
        onStatusChanged: {
            if (playerA.status == MediaPlayer.Buffered){
                timer.interval=playerA.duration-rootVL.trasitionDuration;//-74000;
            }

        }
    }

        VideoOutput {

            id: frameA
            source: playerA
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop
            Behavior on opacity {

                NumberAnimation {
                    duration: rootVL.trasitionDuration
                }

            }
        }




}

