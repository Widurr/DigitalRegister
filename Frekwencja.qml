import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import groups 1.0
Page {
    implicitWidth: 950
    implicitHeight: 700

    title: qsTr("Frekwencja")
    TableView {
        id: tableView
        width: window.width
        height: window.height
        selectionMode: SelectionMode.SingleSelection
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5


       style: TabelkaStyle{

           rowDelegate: Rectangle
           {   id: delegatRow
               anchors.fill: parent
               color: styleData.selected ? '#A3A660' : (styleData.alternate ? '#2F68A3' : '#355A8F');
              MouseArea{
              anchors.fill: parent
              onClicked: {
                  tableView.selection.clear()
                  tableView.currentRow = styleData.row
                  tableView.selection.select(tableView.currentRow)
              }

              onDoubleClicked: {
                  tableView.selection.clear()
                  tableView.currentRow = styleData.row
                  tableView.selection.select(tableView.currentRow)

                  //ja to bym chciała, żeby jak sie kliknie podwojnie to się wchodzi do frekwAdd

                }
              }
       }}

        TableViewColumn {
            id: id
            role: "id"
            title: "id"
            width: 40

        }
        TableViewColumn {
            id: name
            role: "groupName"
            title: "Nazwa grupy"
            width: tableView.width - id.width
        }

        model: theGroupModel
    }

    //na razie guziczek do testów uwu

    Button{
        y: 60
        x: 100
        text: qsTr("Dodaj frekwencję")
        onClicked: {
            stackView.push("FrekwAdd.qml")
        }

    }

    }


