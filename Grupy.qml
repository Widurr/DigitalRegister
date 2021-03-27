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
import groups 1.0

Page {
    implicitWidth: 950
    implicitHeight: 700

    title: qsTr("Grupy")

    Component.onCompleted: {

        theGroupModel.updateModel(account.loggedId)
}

    TableView {
        id: tableView
        width: window.width - 210
        height: window.height - 10
        selectionMode: SelectionMode.SingleSelection
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5


       style: TabelkaStyle{

           rowDelegate: Rectangle
           {   id: delegatRow
               anchors.fill: parent
               color: styleData.selected ? '#A3A660' : (styleData.alternate ? '#2F68A3' : '#355A8F');
              MouseArea{
              anchors.fill: parent
              acceptedButtons: Qt.RightButton | Qt.LeftButton

              onClicked: {
                    tableView.selection.clear()

                  tableView.currentRow = styleData.row
                  tableView.selection.select(tableView.currentRow)

                  switch(mouse.button) {
                  case Qt.RightButton:
                      contextMenu.popup() // Call the context menu
                      break
                  default:
                      break
                  }

              }

              onDoubleClicked: {
                  tableView.selection.clear()

                  tableView.currentRow = styleData.row
                  tableView.selection.select(tableView.currentRow)
                  stackView.push("qrc:/GrStudents.qml", {"groupName": theGroupModel.getGroupName(tableView.currentRow), "studentIDs": theGroupModel.getStudentIDs(tableView.currentRow)})



                }
              }
       }}
       //^ włącza uniwersalny, EKSPERYMENTALNY styl tabelek (jak coś)
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

        TableViewColumn {
            id: id
            role: "id"
            title: "id"
            width: 40

        }
        TableViewColumn {
            id: name
            role: "groupName"
            title: "Nazwa"
            width: tableView.width - id.width
        }

        model: theGroupModel
    }




    Rectangle {
        id: rectangle

        // y: 0
        width: 200
        height: window.height
        anchors.right: parent.right
        anchors.rightMargin: 0
        // anchors.leftMargin: 400
        color: "#2F5A9C"
        ColumnLayout
        {
            x: 45
            y: window.height - 130
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
               id: wlasciwosci
                onClicked: stackView.push("qrc:/GrStudents.qml", {"groupName": theGroupModel.getGroupName(tableView.currentRow), "studentIDs": theGroupModel.getStudentIDs(tableView.currentRow)})

                contentItem: Text {
                        text: qsTr("Wyświetl właściwości grupy")
                        font: wlasciwosci.font
                        color: wlasciwosci.down ? "#9E912E" : "#293D79"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 0.8
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        implicitHeight: 40
                        implicitWidth: wlasciwosci.width
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        opacity: enabled ? 1 : 0.3
                        border.color: wlasciwosci.down ? "#9E912E" : "#293D79"
                        border.width: 1
                        radius: 2
                    }
            }
            Button {
                id: nowaGrupa

                contentItem: Text {
                        text: qsTr("Dodaj nową grupę")
                        font: nowaGrupa.font
                        color: nowaGrupa.down ? "#9E912E" : "#293D79"
                        horizontalAlignment: Text.AlignHCenter
                        opacity:0.8
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        implicitHeight: 40
                        implicitWidth: nowaGrupa.width
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        opacity: enabled ? 1 : 0.3
                        border.color: nowaGrupa.down ? "#9E912E" : "#293D79"
                        border.width: 1
                        radius: 2
                    }
                onClicked: {

                    stackView.push("qrc:/GrAdd.qml")
                }
            }

        }
        TextField {
            id: search
            x: 400
            y: 55
            width: 160
            height: 30
            placeholderText: qsTr("Szukaj...")


            anchors.right: rectangle.right
            anchors.rightMargin: 20
            anchors.top: rectangle.top
            anchors.topMargin: 20
        }
    }


    MessageDialog
    {
        id: dialogDelete
        title: qsTr("Usuń grupę")
        text: qsTr("Potwierdź usunięcie grupy")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        // If the answer ...
        onAccepted: {
            /* ... remove the line by id, which is taken from the data model
                 * on the line number in the presentation
                 * */
            database.removeRecordGr(theGroupModel.getId(tableView.currentRow))
            theGroupModel.updateModel(account.loggedId);

        }
    }


}


