import QtQuick 2.12
import QtQuick.Controls 2.5
import io.qt.backend 1.0
import QtGraphicalEffects 1.0
import account 1.0

Page {

    id: strona
    implicitWidth: 600
    implicitHeight: 400

    title: qsTr("nazwa")
    Image {
        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        source: "stock-images/art-2578353.jpg"

        Text {
            id: text1
            x: 60
            y: 60
            color: "#ffffff"
            font.pixelSize: 12
            text: qsTr("©KMMM Team")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 3
                color: "#80000000"
                radius: 2
                samples: 3

            }
        }



        Rectangle {
            visible: !account.statusLogged()
            id: rectangle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width / 2
            height: parent.width / 3
            color: "#ffffff"
            radius: 9
            opacity: 0.9

           Item{
            id:qml_no_koto_ga_kirai_da_ze
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height

                            BackEnd {
                                id: backend2
                            }
             Rectangle{
             id: login2
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.top: parent.top
             anchors.topMargin: 50 //2change
             width: parent.width * 0.75
             height: 40 //2change
                Text{
                    id: logowanie
                    anchors.bottom: parent.top
                    text: ""
                    color: "red"
                }

             color: "white"

                TextField{
                id: loginfield
                placeholderText: qsTr("Nazwa użytkownika")
                anchors.top: parent.top

                }
                TextField{
                id: passwordfield
                placeholderText: qsTr("Hasło")
                anchors.top: parent.bottom
                echoMode: TextInput.Password

                }
                Button {
                id: login
                y: parent.y/2 + 70
                x: parent.x/2 + 90
                text: qsTr("Zaloguj")
                onClicked: {
                    if(account.checkData(loginfield.text, passwordfield.text)){
                        account.login(account.getId(loginfield.text))
                        rectangle.visible = !account.statusLogged()
                    }
                    else{
                        logowanie.color = "red"
                        logowanie.text = "Wprowadzono błędne dane"
                        loginfield.text = ""
                        passwordfield.text = ""
                    }
                }

                }
                Button {
                id: rejestracja
                y: parent.y/2 + 70
                x: parent.x/2 - 30
                text: qsTr("Zarejestruj")
                onClicked: {
                    if(!account.checkData(loginfield.text)){
                database.inserIntoTable(loginfield.text, passwordfield.text)
                        logowanie.text = "Pomyślnie utworzono użytkownika"
                        logowanie.color = "green"
                        loginfield.text = ""
                        passwordfield.text = ""
                    }
                    else{
                        logowanie.color = "red"
                        logowanie.text = "Już utworzono takiego użytkownika"
                        loginfield.text = ""
                        passwordfield.text = ""
                    }
                }

                }
             }




            }




            Label {
                x: 38
                y: 107
                id: digitalregister
                color: "#FFF"
                text: qsTr("'QT' WIRTUALNY DZIENNIK")
                font.pixelSize: 45
                font.weight: Font.Bold

                font.family: "Courier New"
                styleColor: "#000000"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: -50

                layer.enabled: true
               layer.effect: DropShadow {
                    verticalOffset: 3
                   color: "#80000000"
                    radius: 4
                   samples: 2

                }
            }






        }



    }






    /*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
}
