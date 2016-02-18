import QtQuick 2.0

Rectangle {
    anchors.fill: parent


   VideoLooper {

       videoFile: "http://127.0.0.1/blue.mp4"
        trasitionDuration: 500
   }

   AnimatedImage {
       source: "Ld.mng"
       anchors.centerIn: parent

   }
}

