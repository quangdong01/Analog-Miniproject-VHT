import QtQuick 2.15

// DongNQ #230903 (S)
Rectangle {
    id: rectForBell
    height: 150
    width: 150
    // define object name
    objectName: "Bell"

    // signal for 'F1' key is pressed
    signal pressF1Button();

    Item {
        anchors.fill: parent
        // Bell image
        // Source image: https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fvi%2Fvec-to%2Fh%25C3%25ACnh-%25E1%25BA%25A3nh-vector-c%25E1%25BB%25A7a-m%25E1%25BB%2599t-chi%25E1%25BA%25BFc-chu%25C3%25B4ng-%25C4%2591en-v%25C3%25A0-tr%25E1%25BA%25AFng-tr%25C3%25AAn-n%25E1%25BB%2581n-tr%25E1%25BA%25AFng-b%25E1%25BB%258B-c%25C3%25B4-l%25E1%25BA%25ADp-chu%25C3%25B4ng-gm1124702401-295359551&psig=AOvVaw35ptyOfNVSYeMswFSDrWhu&ust=1710043059432000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKDykfqk5oQDFQAAAAAdAAAAABAE
        Image {
            id: ringingBell
            source: "../Image/Ring.jpg"
            anchors.centerIn: parent
            width: 100
            height: 100

            // Animation: Ring bell when second hand in range of 12-3-6
            NumberAnimation on rotation {
                id: ringingBellRinging
                // period: 100ms
                duration: 100
                // Start position
                from: 20
                // End position
                to: -20
                // Inital not ring, just ring when 'F1' button pressed
                running: false
                // Loop animation
                loops: Animation.Infinite
            }

            //Animation: Blick bell when second hand in range of 6-9-12
            // Blink take place period 5 second, correspond 2.5 second Blink OFF and 2.5 second Blink ON
            SequentialAnimation {
                id: blinkingAnimation
                running: false
                loops: Animation.Infinite

                NumberAnimation {
                    target: ringingBell
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 2500 // duration of Blink bell OFF
                }

                NumberAnimation {
                    target: ringingBell
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 2500 // duration of Blink bell ON
                }
            }
        }
    }

    function onStateClock(option)
    {
        if(option === 1)
        {
            // return opacity = 1
            ringingBell.opacity = 1
            // start ring process
            ringingBellRinging.start()
            // start blink process
            blinkingAnimation.stop()
        }
        else if(option === 2)
        {
            // return inital rotation
            ringingBell.rotation = 0;
            // stop ring process
            ringingBellRinging.stop()
            // stop blink process
            blinkingAnimation.start()
        }
        else if(option === 3)
        {
            ringingBellRinging.stop()
            // start blink process
            blinkingAnimation.stop()
            ringingBell.opacity = 1
            ringingBell.rotation = 0;
        }
    }

    Connections{
        target: id_root
        onStateClock:
        {
            onStateClock(option)
        }
    }
}
// DongNQ #230903 (E)
