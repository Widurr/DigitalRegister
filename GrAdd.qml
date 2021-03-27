import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15

//import student 1.0
import groups 1.0

Page {
    id: page
    implicitWidth: 950
    implicitHeight: 700

    title: qsTr("Dodawanie nowej grupy")
    Component.onCompleted:  myModel.uncheckAll()

    Item{
    y: 2
    height: 30
    width: tableViewSudents.width
    TextField {
        id: groupNameTextField
        x: 5
        width: 150
        height: 30
        placeholderText: "Nazwa grupy"
    }


    Button{
        id: clear
        x: 160
        height: 30
        width: 140
        contentItem: Text {
                text: qsTr("Wyczyść zaznaczenia")
                font: clear.font
                color: clear.down ? "#9E912E" : "#293D79"
                horizontalAlignment: Text.AlignHCenter
                opacity:0.8
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitHeight: 40
                implicitWidth: clear.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                opacity: enabled ? 1 : 0.3
                border.color: clear.down ? "#9E912E" : "#293D79"
                border.width: 1
                radius: 2
            }
        onClicked: {
            myModel.uncheckAll()
        }
    }
    Button{
        id: checkAll
        height: 30
        contentItem: Text {
                text: qsTr("Zaznacz wszyskich")
                font: checkAll.font
                color: checkAll.down ? "#9E912E" : "#293D79"
                horizontalAlignment: Text.AlignHCenter
                opacity:0.8
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitHeight: 40
                implicitWidth: checkAll.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                opacity: enabled ? 1 : 0.3
                border.color: checkAll.down ? "#9E912E" : "#293D79"
                border.width: 1
                radius: 2
            }

        x: clear.x+clear.width+5
       // width: tableViewSudents.width - 290
        width: { if (window.width > 670 ) {
                        width: 170
                        } else { width: tableViewSudents.width - 310 }

                    }


        onClicked: {
            myModel.uncheckAll()
            myModel.checkAll()
        }
    }

    }


    TableView {
         id: tableViewSudents
         style: TabelkaStyle{}
        //^ włącza uniwersalny, EKSPERYMENTALNY styl tabelek (jak coś)

        y: groupNameTextField.height + 6

        width: window.width - 190
        height: window.height - 10

        TableViewColumn {
            id: na_checkbox
            width: 30



            delegate: CheckBox {
                id: control
                checked: model.checkedRole
                onClicked: model.checkedRole = checked

                indicator: Rectangle {
                    implicitWidth: 15
                    implicitHeight: 15
                    x: control.leftPadding
                    y: parent.height / 2 - height / 2

                    border.color: "black"

                    Text{
                        width: 5
                        height: 5
                        text: "\u2713"
                        font.pixelSize: 15
                        x: control.x
                        y: control.y - 2
                      //  anchors.verticalCenter: control.verticalCenter
                        color: control.down ? "black" : "black"
                        visible: control.checked

                    }


                }


                //nie wiem co to jest, bez tego nawet lepiej działa, ale niech zostanie na razie
               /* contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control.down ? "black" : "black"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: control.indicator.width + control.spacing
                } */
            }


        }
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

        TableViewColumn {
            role: "phone"
            title: "Numer telefonu"
            width: tableViewSudents.width - 2 - (id.width + nazwisko.width + imie.width + na_checkbox.width)
        }

        model: myModel
    }


    Rectangle {
        id: rectangle

        // y: 0
        width: 180
        height: window.height
        anchors.right: parent.right
        color: "#2F5A9C"
        anchors.rightMargin: 0
        // anchors.leftMargin: 400


        Button {
            id: addGroup
            x: 45
            y: window.height - 130
            z: 1
            height: 40
            width: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Text {
                    text: qsTr("Dodaj grupę")
                    font: addGroup.font
                    color: addGroup.down ? "#9E912E" : "#293D79"
                    horizontalAlignment: Text.AlignHCenter
                    opacity:0.8
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitHeight: addGroup.height
                    implicitWidth: addGroup.width
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    opacity: enabled ? 1 : 0.3
                    border.color: addGroup.down ? "#9E912E" : "#293D79"
                    border.width: 1
                    radius: 2
                }



            onClicked: {
                database.inserIntoGroupTable(groupNameTextField.text, myModel.checked, account.loggedId);
                theGroupModel.updateModel(account.loggedId)
                myModel.uncheckAll()
                stackView.pop();
            }
        }

        TextField {
            id: search
            x: 420
            y: 55
            width: 150
            height: 30
            placeholderText: qsTr("Szukaj...")


            anchors.right: rectangle.right
            anchors.rightMargin: 20
            anchors.top: rectangle.top
            anchors.topMargin: 20
        }
    }
}




