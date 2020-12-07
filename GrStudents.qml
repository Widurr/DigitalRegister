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
    implicitWidth: 600
    implicitHeight: 400
    property string groupName
    property string studentIDs
    title: qsTr(groupName)


    TableView
    {
        Component.onCompleted: myModel.updateModel(studentIDs)
        Component.onDestruction: myModel.updateModel()
        id: tableView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        TableViewColumn{
            role:"id";
            title: "Id";
        }

        TableViewColumn {
            role: "fname"
            title: "Imię"
        }
        TableViewColumn {
            role: "lname"
            title: "Nazwisko"
        }
        TableViewColumn {
            role: "phone"
            title: "Telefon"
        }

        model: myModel

    }
}
