import QtQuick 2.15
// DongNQ #230903 (S)
Item {
    id: id_root
    // value of minute
    property int value: 0

    // value of second
    property int valueSecond: 0
    // devision interval
    property int granularity: 60

    Rectangle {
        width: 2
        height: id_root.height * 0.4
        color: "black"
        anchors {
            horizontalCenter: id_root.horizontalCenter
            bottom: id_root.verticalCenter
        }
        antialiasing: true
    }

    // calculate rotation of minute
    rotation: 360/granularity * (value % granularity) + 360/granularity * (valueSecond / 60)
    antialiasing: true
}
// DongNQ #230903 (E)
