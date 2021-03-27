import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 2.1

Page {
    id: page
    implicitWidth: 950
    implicitHeight: 700


    title: qsTr("Twoje zajęcia")

    Component.onCompleted: {

        theGroupModel.updateModel(account.loggedId)
        classes.updateModel(account.loggedId)
}

    Popup{
        id: addZajPopup
        anchors.centerIn: parent
        width: 300
        height: 250


        Column{
            id: passColumn
            anchors.horizontalCenter: parent.horizontalCenter
            y: 30
            Text{
                text: qsTr("Nazwa zajęć")
            }
            TextField{
                id: zajeciaName
            }
            Item{
            width: 1
            height: 5
            }

            Text{
                text: qsTr("Grupa")
            }

            ListModel{
            id: model
            
            
            }
            
            
            ComboBox {
                id: combo
                width: zajeciaName.width
                model: theGroupModel
                textRole: "groupName"

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
                width: zajeciaName.width
                height: 40
            Button{
                id: addFinalize

                anchors.horizontalCenter: parent.horizontalCenter
                width: 150
               height: 40
                contentItem:
                    Text {
                            text: qsTr("Dodaj zajęcia")
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
                            addZajPopup.close();
                            database.inserIntoClassTable(zajeciaName.text,account.loggedId,theGroupModel.getterId(combo.currentText))
                            Component.completed(classes.updateModel(account.loggedId))
                            //Component.completed(gridView.model.append({myText: zajeciaName.text,myColor: "lightblue"}))
                            zajeciaName.text="";
                        }
                }


        }
        }


        }



    GridView {
        id: gridView2
        clip: true
        x: 36
        y: 21
        width: window.width - 250
        height: window.height - 50
        cellHeight: 150
        cellWidth: 150


        ScrollBar.vertical: ScrollBar {
            id: scroll
                active: true

                }

        delegate: Item {

            width: 140
            height: 140
            Row {
                id: row1
               // spacing: 10
                Rectangle {
                    id: rektu
                    width: 140
                    height: 140
                    color: "lightblue"
                    MouseArea{
                    anchors.fill: parent
                    onClicked: {
                    classes.setactiveClassID(classes.getId(index))
                    console.log(classes.getId(index))
                    stackView.push("ZajeciaPage.qml")


                    }
                    }

                    Text {
                        text: classname
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.Wrap
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        font.bold: true
                        font.pixelSize: 20

                    }


                }
            }
        }
        model: classes
    }


    /*
        GridView {
        id: gridView
        x: 36
        y: 21
        width: window.width - 250
        height: window.height - 50
        cellWidth: 150
        cellHeight: 150
        model: ListModel{}
        delegate: Button {
                   id: rect
                   width: 140
                   height: 140
                   onClicked: {
                       stackView.push("ZajeciaPage.qml")
                   }

                    Text{
                        text: myText
                        font.pointSize: 20
                    }
                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        topMargin: 20
                        leftMargin: 20
                    }


                    background: Rectangle{
                        color: myColor
                        anchors{
                            top: parent.top
                            bottom: parent.bottom
                            left: parent.left
                            right:parent.right

                        }
                    }

        }
}
        */

    Rectangle {
        id: rectangle

       // y: 0
        width: 200
        height: window.height
        anchors.right: parent.right
        anchors.rightMargin: 0
       // anchors.leftMargin: 400
        color: "#2F5A9C"
        Button {
            id: button
            x: 45
            y: window.height - 130
            z: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Dodaj nowe zajęcia")
            onClicked: {
                addZajPopup.open()

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

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
