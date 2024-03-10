import QtQuick 2.15
// DongNQ #230903 (S)
Item {
    id: id_root

        // value of hour
        property int value: 0

        // value of minute
        property int valueminute: 0

        // division interval of hour
        property int granularity: 12

        // hour hand
        Rectangle {
            width: 2
            height: id_root.height * 0.3

            // set blue for hour hand
            color: "blue"

            // set up position
            anchors {
                horizontalCenter: id_root.horizontalCenter
                bottom: id_root.verticalCenter
            }
            antialiasing: true
        }

        // set up rotation of hour
        rotation: 360/granularity * (value%granularity) + 360/granularity * (valueminute / 60)
        antialiasing: true
}
// DongNQ #230903 (E)
