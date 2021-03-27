import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15

import groups 1.0

Page{
        implicitWidth: 950
        implicitHeight: 700

        title: qsTr("Dodawanie frekwencji")
        TableView {
             id: tableViewSudents
             style: TabelkaStyle{}

            y: groupNameTextField.height + 6

            width: window.width - 210
            height: window.height - 10


            TableViewColumn {
                id: id
                role: "id"
                title: "id"
                width: 30

            }
            TableViewColumn {
                id: nazwisko
                role: "lname"
                title: "Nazwisko"
                width: 100
            }
            TableViewColumn {
                id: imie
                role: "fname"
                title: "Imię"
                width: 100
            }
            /*TableViewColumn {
                id: obecnosc
                width: 304
                title: "ob"
                delegate: RadioButton {
                    implicitWidth: 15
                    implicitHeight: 15


                }
             TableViewColumn {
                    id: nieobecnosc
                    width: 30
                    title: "nieob"
                    delegate: RadioButton {
                        implicitWidth: 15
                        implicitHeight: 15
                    }

            }
             TableViewColumn {
                    id: spoznienie
                    width: 30
                    title: "sp"
                    delegate: RadioButton {
                        implicitWidth: 15
                        implicitHeight: 15

                    }

            }
             TableViewColumn {
                    id: nieobUpr
                    width: 30
                    title: "nieobUspr"
                    delegate: RadioButton {
                        implicitWidth: 15
                        implicitHeight: 15


                    }*/


            }
             Rectangle {
                 id: rectangle
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
                     id: frekwadd
                     x: 45
                     y: window.height - 130
                     z: 1
                     anchors.bottom: parent.bottom
                     anchors.bottomMargin: 100
                     anchors.horizontalCenter: parent.horizontalCenter
                     text: qsTr("Dodaj frekwencję")
                     onClicked: {
                     }
                 }
                 Text{
                     text: "Wpisz datę, aby wyszukać frekwencję konkretnego dnia"
                     width: parent.width-30
                     height: 40
                     wrapMode: Text.WordWrap
                     anchors.left: parent.left
                     anchors.right: parent.right
                     anchors.top: parent.top
                     anchors.leftMargin: 20
                     anchors.topMargin: 20

                     TextField{
                         id: wyszukiwarka
                         x: parent.x-10
                         y: parent.y+ 20
                         width: 140
                         height: 30
                         Button{
                             text: qsTr("Szukaj")
                             x: wyszukiwarka.x+30
                             y: wyszukiwarka.y
                             width: 60
                             height:20
                         }
                     }
                 }

             }

}

