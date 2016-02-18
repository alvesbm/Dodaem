import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id:rootApp
    visible: true
    width: Screen.width
    height: Screen.height
    BackBone {
        anchors.fill: parent


    }

    MouseArea {
        anchors.fill: parent
        onClicked: {Qt.quit()}
        Keys.onEscapePressed: {Qt.quit()}
        focus:true
    }

}
