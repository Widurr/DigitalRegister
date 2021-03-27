import QtQuick 2.12
import QtQuick 2.5
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import student 1.0

Page
{
    id: page
    implicitWidth: 950
    implicitHeight: 700
    property string groupName
    property string studentIDs
    title: qsTr(groupName)


    TableView
    {
         id: tableView
        style: TabelkaStyle{}
        //^ włącza uniwersalny, EKSPERYMENTALNY styl tabelek (jak coś)

        Component.onCompleted: myModel.updateModel(account.loggedId, studentIDs)
        Component.onDestruction: myModel.updateModel(account.loggedId)

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        TableViewColumn{
            id: id
            role:"id"
            title: "Id"
            width: 40
        }
        TableViewColumn {
            id: nazwisko
            role: "lname"
            title: "Nazwisko"
            width: 150
        }

        TableViewColumn {
            id: imie
            role: "fname"
            title: "Imię"
            width: 150
        }

        TableViewColumn {
            role: "phone"
            title: "Telefon"
            width: tableView.width - (id.width + imie.width + nazwisko.width) - 2
        }

        model: myModel

    }
}
