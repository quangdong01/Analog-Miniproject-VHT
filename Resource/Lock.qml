import QtQuick 2.15
// DongNQ #230903 (S)
Rectangle {
    id: id_root
    // define object name to interact with other object and used in back end (C++)
    objectName: "Lock"
    // get currend data
    property var currentDate: new Date()
    // get current hour
    property int hours: currentDate.getHours()
    // get current minute
    property int minutes: currentDate.getMinutes()
    // get current second
    property int seconds: currentDate.getSeconds()

    // option time // true: real time // false: time from other Application
    property bool optionTime: true

    // parameter for event button 'F1' button pressed
    property bool pressF1Button: false

    // signal for event at Lock
    signal stateClock(int option) // option true: second hand in range of 12-3-6, // option false: second hand in range of 6-9-12

    // signal for F1 pressed
    signal clickF1Key()

    property int timerDelay: 1000
    // Clock image
    // Source image: https://www.google.com/url?sa=i&url=https%3A%2F%2Fvi.pngtree.com%2Fso%2Fm%25E1%25BA%25B7t-%25C4%2591%25E1%25BB%2593ng-h%25E1%25BB%2593&psig=AOvVaw1-OkoUPakJwSnD-6mM9tG4&ust=1710042683452000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCODppMej5oQDFQAAAAAdAAAAABAE
    Image {
        id: idImage
        source: "../Image/AnalogClock.png"

        // Timer to get date after 1 second
        Timer {
            id: timer
            repeat: true

            // repeat after 1 second
            interval: timerDelay

            // running imediately running Clock App
            running: true

            // get current
            onTriggered:
            {
                if(pressF1Button)
                {
                    // Second hand = 0
                    // Delay 2s
                    // 1 circel within 5s
                    timerDelay = 5000/60
                    seconds++;
                    if (seconds === 60) {
                        seconds = 0
                        timerDelay = 2000
                    }
                }
                else
                {
                    if(optionTime)
                    {
                        console.log("In here not not")
                        id_root.currentDate = new Date()
                        hours = currentDate.getHours()
                        // get current minute
                        minutes = currentDate.getMinutes()
                        // get current second
                        seconds = currentDate.getSeconds()
                        console.log("Second: " + seconds)
                        // when seconds updated, emit signal to change bell state if needed
                        if(seconds >= 0 && seconds <= 30)
                        {
                            stateClock(1)
                        }
                        else
                        {
                            stateClock(2)
                        }
                    }
                    else
                    {
                        // Update hour, minute, second
                        seconds++
                        if (seconds === 60) {
                            seconds = 0
                            minutes++
                            if (minutes === 60) {
                                minutes = 0
                                hours++
                                if (hours === 24) {
                                    hours = 0
                                }
                            }
                        }
                        if(seconds >= 0 && seconds <= 30)
                        {
                            stateClock(1)
                        }
                        else
                        {
                            stateClock(2)
                        }
                    }
                }
            }
        }

        // Draw second
        Second {
            id: secondHand
            value: id_root.seconds
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        // Draw minute
        Minute {
            id: minuteHand
            value: id_root.minutes
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        // Draw hour
        Hour {
            id: hourHand
            value: id_root.hours
            valueminute: id_root.minutes
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        // Event handling when 'F1' button pressed
        Item {
            focus: true
            Keys.onPressed: {
                if (event.key === Qt.Key_F1) {
                    pressF1Button = !pressF1Button
                    // handling when click 'F1' button a second time
                    if(pressF1Button === true)
                    {
                        stateClock(3)
                        seconds = 0
                        hourHand.visible = false
                        minuteHand.visible = false
                    }

                    // handling when click 'F1' button a second time
                    else
                    {
                        // get current hour
                        hourHand.visible = true
                        minuteHand.visible = true
                        id_root.currentDate = new Date()
                        hours = currentDate.getHours()
                        // get current minute
                        minutes = currentDate.getMinutes()
                        // get current second
                        seconds = currentDate.getSeconds()
                        timerDelay = 1000

                    }
                }
            }
        }
    }

    Connections{
        target: LockServer
        function onUpdateTime(hour, minute, second)
        {
            optionTime = false
            hours = hour
            minutes = minute
            seconds = second
        }
    }
}
// DongNQ #230903 (E)
