import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Page {
    id: page
    implicitWidth: 950
    implicitHeight: 700


   /* Image { <--------------- tlo possible
        id: tlo
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "stock-images/....jpg"
*/
    Popup{
        id: addDataPopup
        anchors.centerIn: parent
        width: 300
        height: 250


        Column{
            id: passColumn
            anchors.horizontalCenter: parent.horizontalCenter
            y: 30
            Text{
                text: qsTr("Godzina rozpoczęcia")
            }
            TextField{
                id: godzRozpoczecia
            }
            Item{
            width: 1
            height: 5
            }

            Text{
                text: qsTr("Dzień tygodnia")
            }

            ListModel{
            id: model
            ListElement {
                name: "Poniedziałek"
            }
            ListElement {
                name: "Wtorek"
            }
            ListElement {
                name: "Środa"
            }
            ListElement {
                name: "Czwartek"
            }
            ListElement {
                name: "Piątek"
            }
            ListElement {
                name: "Sobota"
            }
            ListElement {
                name: "Niedziela"
            }

            }


            ComboBox {
                id: combo
                width: godzRozpoczecia.width
                model: model
                textRole: "name"

                height: 38
               // popup.contentItem.implicitHeight: +funkcja. jak jest mało grup to nie ruszać, ew. na przyszlość tu restrykcję zrobić, bo jak jest
                //dużo grup to mogłaby lepiej ta lista wyglądać


                indicator:Item{
                    anchors.right: parent.right
                    width: height - 5
                    height: combo.height

                    Text{
                        id: content
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.verticalCenter: parent.verticalCenter
                         font.pixelSize: 8

                          text: {
                              if (combo.popup.visible == true )
                              {
                                  text: qsTr("\u25B2")
                              }
                              else
                              { text: qsTr("\u25BC") }
                          }






                   }
            }}
            Item{

            width: 1
            height: 15
            }

            Item{
                width: godzRozpoczecia.width
                height: 40
            Button{
                id: addFinalize

                anchors.horizontalCenter: parent.horizontalCenter
                width: 150
               height: 40
                contentItem:
                    Text {
                            text: qsTr("Dodaj termin")
                            font: addFinalize.font
                            color: addFinalize.down ? "#9E912E" : "#293D79"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        background: Rectangle {
                            implicitHeight: addFinalize.height
                            implicitWidth: addFinalize.width
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5
                            border.color: addFinalize.down ? "#9E912E" : "#293D79"
                            border.width: 1
                            radius: 2
                        }
                        onClicked:{
                            //tu dodanie
                            console.log(combo.currentIndex, godzRozpoczecia.text, 1, classes.activeClassID)
                            addDataPopup.close();
                            database.inserIntoDateTable(combo.currentIndex, godzRozpoczecia.text, 1, classes.activeClassID)
                           godzRozpoczecia.text="";
                        }
                }


        }
        }


        }

    Rectangle {
        id: sidebar

        // y: 0
        width: 200
        height: window.height
        anchors.right: parent.right
        color: "#2F5A9C"
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

    Button {
        id: wlasciwosci_zaj_button
        x: 400
        y: 55
        width: 160
        height: 30
       text: qsTr("Właściwości zajęć")


        anchors.right: sidebar.right
        anchors.rightMargin: 20
        anchors.top: sidebar.top
        anchors.topMargin: 20

        onClicked: {
            addDataPopup.open()

        }


    }

    Item{
    id: na_listview
    width: page.width - sidebar.width
    height: page.height - pasek.height
    x: 0
    y: 0



    ListView {
        id: listView
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        //x: 57
       // y: 37
        width: na_listview.width - 150
        height: na_listview.height - 50
        spacing: 1

        ScrollBar.vertical: ScrollBar {
            id: scroll
                active: true

                }
        model: modelekz
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Rectangle {
                    width: listView.width - 5
                    height: 40
                    color: colorCode
                    radius: 9
                    MouseArea {
                    anchors.fill: parent
                    onClicked: { listView.currentIndex = index
                       stackView.push("JednostkaLekcyjna.qml")
                    }
                    }
                    Text {
                        text: name
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter

                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        font.bold: true

                    }

                }
            }
        }

    }
}







    ListModel
    {
        id: modelekz
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"

                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#275C7A"
                }

                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7676B"
                }

                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }

                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }
                ListElement {
                    name: "DATA - temat: ..."
                    colorCode: "#C7C440"
                }

            }


}

//} tlo

