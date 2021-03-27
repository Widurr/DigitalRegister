import QtQuick 2.12
import QtQuick 2.6
import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import student 1.0
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 2.0


import database 1.0

Page
{
    id: page
    implicitWidth: 950
    implicitHeight: 700
    title: qsTr("Uczniowie")
    property bool startButton: database.dbIsEmpty()
    Component.onCompleted: myModel.updateModel(account.loggedId)

    function isdbempty(){
        if(startButton==true)
            return false;
        else return true;
    }

    header:
        Item{

        Button{
        height: 40
        width: page.width/2
        id: addStudentButt
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        //visible: isdbempty()
        contentItem: Text {
                text: qsTr("Dodaj ucznia")
                font: addStudentButt.font
                opacity: enabled ? 1.0 : 0.3
                color: addStudentButt.down ? "#9E912E" : "#293D79"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitHeight: 40
                implicitWidth: addStudentButt.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                opacity: enabled ? 1 : 0.3
                border.color: addStudentButt.down ? "#9E912E" : "#293D79"
                border.width: 1
                radius: 2
            }
        onClicked:{

            dodawanie.open()
        }
    }
    }
            // the code below is used to import and export students

            // shameless button for testing purposes
            // frontend pls fix it
            Row{
                y: parent.height - 60;
                x: 10
                z: 2
                spacing: 4
                Button{
                    text: qsTr("Import students from file")
                    onClicked: {
                        fileDialogIn.open()
                    }
                }
                Button{
                    text: qsTr("Export students to file")
                    onClicked: {
                        fileDialogOut.open()
                    }
                }
            }
            // FileDialog that opens the file choosing thing in system
            FileDialog{
                id: fileDialogIn
                title: "Importuj studentów z pliku"
                nameFilters: ["Text files (*.txt)", "Comma-separated values  (*.csv)"]
                folder: shortcuts.documents
                onAccepted:
                {
                    database.importStudentsFromFile(account.loggedId, this.fileUrl)
                    myModel.updateModel(account.loggedId)
                }
            }
            FileDialog{
                id: fileDialogOut
                title: "Eksportuj studentów do pliku"
                nameFilters: ["Text files (*.txt)", "Comma-separated values  (*.csv)"]
                folder: shortcuts.documents
                onAccepted:{
                    database.exportStudentsToFile(account.loggedId, this.fileUrl)
                }
            }


    TableView
    {

        id: tableView
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.bottomMargin: 5
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        //anchors.margins: 5

        style: TabelkaStyle{ //większość kodu jest w pliku "TabelkaStyle.qml"
                               //to poniżej jednak tu zostawiam na razie, bo nadpisuje się, a MouseArea nie chcę na razie tam wkładać, dopóki
                                //nie będziemy mieli jasności co do funkcjonowania reszty tabelek w tej naszej aplikacji

                        rowDelegate: Rectangle
                        {
                            anchors.fill: parent
                            color: styleData.selected ? '#A3A660' : (styleData.alternate ? '#2F68A3' : '#355A8F');

                            MouseArea
                            {
                                anchors.fill: parent
                                acceptedButtons: Qt.RightButton | Qt.LeftButton
                                onClicked: {
                                    tableView.selection.clear()
                                    tableView.selection.select(styleData.row)
                                    tableView.currentRow = styleData.row
                                    tableView.focus = true

                                    switch(mouse.button) {
                                    case Qt.RightButton:
                                        contextMenu.popup() // Call the context menu
                                        break
                                    default:
                                        break
                                    }
                                }
                            }
                        }

        }

        TableViewColumn{
            id: id
            role:"id"
            title: "Id"
            width: 50
        }
        TableViewColumn {
            id: nazwisko
            role: "lname"
            title: "Nazwisko"
        }
        TableViewColumn {
            id: imie
            role: "fname"
            title: "Imię"
        }

        TableViewColumn {
            role: "phone"
            title: "Telefon"
            width: tableView.width - 2 - (id.width + nazwisko.width + imie.width)
        }

        model: myModel

        // The context menu offers deleting a row from the database
        Menu
        {
            id: contextMenu

            MenuItem {
                text: qsTr("Usuń")
                onTriggered: {
                    /* Call the dialog box that will clarify the intention to remove the row from the database
                         * */
                    dialogDelete.open()
                }
            }

        }

        // Dialog of confirmation the removal line from the database
        MessageDialog
        {
            id: dialogDelete
            title: qsTr("Usuń ucznia")
            text: qsTr("Potwierdź usunięcie ucznia")
            icon: StandardIcon.Warning
            standardButtons: StandardButton.Ok | StandardButton.Cancel

            // If the answer ...
            onAccepted: {
                /* ... remove the line by id, which is taken from the data model
                     * on the line number in the presentation
                     * */
                database.removeRecord(myModel.getId(tableView.currentRow))
                myModel.updateModel(account.loggedId);
                startButton = database.dbIsEmpty(account.loggedId)
            }
        }
        Popup
        {
            id:dodawanie

            anchors.centerIn: parent
            width:300
            height:250
            Column
            {
                Text {text: qsTr("Imię")}
                TextField {id: fnameField}

                Text {text: qsTr("Nazwisko")}
                TextField { id: lnameField}

                Text {text: qsTr("Numer Telefonu")}
                TextField {id: phoneField}

                Button {
                    text: qsTr("Dodaj Ucznia")
                    anchors.right:dodawanie
                    // Make a new entry in the database
                    onClicked: {
                        database.inserIntoTable(fnameField.text , lnameField.text, phoneField.text, account.loggedId)
                        myModel.updateModel(account.loggedId) // And updates the data model with a new record
                        startButton = database.dbIsEmpty(account.loggedId)
                        dodawanie.close()
                        fnameField.text = ""
                        lnameField.text = ""
                        phoneField.text = ""
                    }
                }
            }
        }
    }

    /*Button{
        id: addstudent
        anchors.centerIn: parent
        width: 300
        height: 100
        text: qsTr("Dodaj ucznia")
        visible: startButton
        onClicked:{
            dodawanie.open()
        }
    }*/
}
