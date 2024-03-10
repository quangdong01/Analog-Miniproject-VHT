import QtQuick 2.15
import QtQuick.Controls 2.15

// DongNQ #230903 (S)
ApplicationWindow {
    visible: true
    width: 600
    height: 360 + 500
    title: qsTr("Analog Application")
    // Instance of LOCK
    Lock{
        id: id_root
        x: 0
        y: 0
        height: 360
        width: 360
    }

    // Instance of BELL
    Bell{
        id: root_Bell
        x: 400
        y: 0
    }

    Rectangle
    {
        id: rectContainListView
        height: 450
        width: 550
        anchors.top: id_root.bottom
        anchors.topMargin: 20
        anchors.left: id_root.left
        anchors.leftMargin: 25
        border.color: "#a9a9a9"

        Rectangle{
            id: recStt
            height: 25
            width: 30
            anchors.top: parent.top
            anchors.left: parent.left
            border.color: "#a9a9a9"
            Text{
                text: "STT"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

        Rectangle{
            id: recDateTimeLog
            height: 25
            width: 125 + 7
            anchors.top: recStt.top
            anchors.left: recStt.right
            border.color: "#a9a9a9"
            Text{
                text: "Datetime"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

        Rectangle{
            id: recDirectLog
            height: 25
            width: 195
            anchors.top: recDateTimeLog.top
            anchors.left: recDateTimeLog.right
            border.color: "#a9a9a9"
            Text{
                text: "Direct"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

        Rectangle{
            id: recContentLog
            height: 25
            width: 193
            anchors.top: recDirectLog.top
            anchors.left: recDirectLog.right
            border.color: "#a9a9a9"
            Text{
                text: "Content"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

        ListView {
            id: listLogTcpView
            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.top: recStt.bottom
            clip: true
            focus: true
            snapMode: ListView.SnapOneItem
            model: logTcp
            smooth: true
            spacing: -1
            cacheBuffer: 10000
            ScrollBar.vertical: ScrollBar {}
            delegate: Rectangle {
                width: 543
                height: 25
                Rectangle {
                    id: stt
                    width: 30
                    height: 25
                    anchors.left: parent.left
                    border.color: "#a9a9a9"
                    Text {
                        text: index + 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        font.pixelSize: 13
                    }
                }

                Rectangle {
                    id: time
                    width: 125 + 7
                    height: 25
                    anchors.left: stt.right
                    border.color: "#a9a9a9"
                    Text {
                        text: dateTimeLog
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        font.pixelSize: 13
                    }
                }
                Rectangle {
                    id: dir
                    width: 195
                    height: 25
                    anchors.left: time.right
                    border.color: "#a9a9a9"
                    Text {
                        text: dirLog
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        font.pixelSize: 13
                    }
                }
                Rectangle {
                    id: ctent
                    width: 193
                    height: 25
                    anchors.left: dir.right
                    border.color: "#a9a9a9"
                    Text {
                        text: contentLog
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        font.pixelSize: 13
                    }
                }
            }
        }
    }
}
// DongNQ #230903 (E)
