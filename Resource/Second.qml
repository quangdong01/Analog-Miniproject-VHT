import QtQuick 2.15

// DongNQ #230903 (S)
Item {
    id: id_root
    // value of secnd
    property int value: 0

    // division interval or granularity
    property int granularity: 60

    // option 'F1' is pressed
    property bool pressedF1: false

    Rectangle {
        width: 1
        height: id_root.height * 0.6
        color: "red"
        anchors {
            horizontalCenter: id_root.horizontalCenter
        }
        antialiasing: true
        y: id_root.height * 0.05
    }

    // calculate rotation of second
    rotation: 360/granularity * (value % granularity)
    antialiasing: true
}
// DongNQ #230903 (E)
