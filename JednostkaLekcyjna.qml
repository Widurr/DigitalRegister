import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Page {
    id: page
    implicitWidth: 950
    implicitHeight: 700

    title: qsTr("NAZWA ZAJĘĆ - DATA")


    /* Image { <--------------- tlo possible
        id: tlo
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "stock-images/....jpg"
*/
    Rectangle {
        id: sidebar

        // y: 0
        width: 200
        height: window.height
        anchors.right: parent.right
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#dcd7d1"
            }

            GradientStop {
                position: 0.76699
                color: "#999999"
            }
        }
        anchors.rightMargin: 0
        // anchors.leftMargin: 400






        Button {
            id: buttonm
            x: 45
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 200
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Oceny")
            //onClicked: {
            //   stackView.replace("ZajeciaAdd.qml")
        }
        Button {
            id: button2
            x: 45
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 150
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Frekwencja")
            //onClicked: {
            //   stackView.replace("ZajeciaAdd.qml")
        }
        Button {
            id: button3
            x: 45
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Uczniowie")
            //onClicked: {
            //   stackView.replace("ZajeciaAdd.qml")
        }


        Text {

            id: text1
            text: qsTr("Nazwa zajęć (właciwosc klasy)")
            y: 65
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            font.bold: true
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 3
                color: "#80000000"
                radius: 2
                samples: 3

            }

        }


        Text {
            id: text2
            text: qsTr("inna właciwosc klasy")
            y: 85
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3

            }

        }

        Text {
            id: text3
            y: 105
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("jeszcze inna właciwosc klasy")
            font.pixelSize: 12
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3

            }

        }

        Text {
            id: text4
            y: 125
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("i jeszcze inna właciwosc klasy")
            font.pixelSize: 12
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }
    }

    TextField {
        id: search
        x: 400
        y: 55
        width: 160
        height: 30
        placeholderText: qsTr("Tego pewnie nie będzie")


        anchors.right: sidebar.right
        anchors.rightMargin: 20
        anchors.top: sidebar.top
        anchors.topMargin: 20


    }


    Item{
    id: na_stuff
    width: page.width - sidebar.width
    height: page.height - pasek.height
    x: 0
    y: 0

    TextField {
        id: temat
        x: 5
        y: 30
        width: na_stuff.width - 100
        height: 30
        placeholderText: qsTr("Temat...")
        anchors.horizontalCenter: parent.horizontalCenter
         font.pixelSize: 13
        selectByMouse: true
        selectedTextColor: "white"

        background: Rectangle{
        color: "white"
        opacity: 0.6
         border.color: "#c3c3c3"
        }



    }
ScrollView{
    anchors.top: temat.bottom
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    x: 5
     height: na_stuff.height - 70
     width: na_stuff.width - 100

    TextArea {
        background: Rectangle {
            color: "white"
            opacity: 0.6
             border.color: "#c3c3c3"
            }

        wrapMode: Text.WordWrap

        font.pixelSize: 13
        persistentSelection: true
        selectByKeyboard: true
        selectByMouse: true
         focus: true
         selectedTextColor: "white"
         placeholderText: "Uwagi..."
     }
}
    }


}
//} tlo
