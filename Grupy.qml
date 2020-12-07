import QtQuick 2.12
import QtQuick.Controls 2.5
//import Qt.labs.qmlmodels 1.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import groups 1.0

Page {
    implicitWidth: 600
    implicitHeight: 400

    title: qsTr("Grupy")

    TableView {
        id: tableView
        width: window.width - 210
        height: window.height - 10


        TableViewColumn {
            role: "id"
            title: "id_nr"
            width: 50

        }
        TableViewColumn {
            role: "groupName"
            title: "Nazwa"
            width: 200
        }

        model: GroupModel { id: theModel; list: groupList }
    }




    Rectangle {
        id: rectangle

        // y: 0
        width: 200
        height: window.height
        anchors.right: parent.right
        anchors.rightMargin: 0
        // anchors.leftMargin: 400

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
        ColumnLayout
        {
            x: 45
            y: window.height - 130
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                text: qsTr("Wyświetl właściwości grupy")
                //theModel[tableView.currentRow].groupName
                onClicked: stackView.push("qrc:/GrStudents.qml", {"groupName": theModel.getGroupName(tableView.currentRow), "studentIDs": theModel.getStudentIDs(tableView.currentRow)})
            }
            Button {
                id: buttont
                text: qsTr("Dodaj nową grupę")
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

}


