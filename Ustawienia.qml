import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import account 1.0

Page {

    background: Rectangle{
        width: parent.width
        height: parent.height
        color: setBackgroundColor()
    }
    property int currentIndex: 1
    onCurrentIndexChanged: {
        jasny.checked = currentIndex == 0
        ciemny.checked = currentIndex == 1
    }

    function setBackgroundColor(){
         var color;

        return themeList.background
    }
    function setFontColor(){
        var fontColor;

        return themeList.foreground;
    }

    RadioButton {
        id: jasny
        x: 61
        y: 99
        width: 40
        height: 40
        onClicked: {
            currentIndex=0
            themeList.setCurrentTheme(1)
        }
        checked: true
        Text {
            id: jasnyTekst
            anchors.left: jasny.right
            anchors.leftMargin: 2
            anchors.top: jasny.top
            anchors.topMargin: 8
            text: qsTr("Jasny motyw")
            font.pixelSize: 20
            color: themeList.foreground
        }


    }

    RadioButton {
        id: ciemny
        x: 61
        y: 144
        width: 40
        height: 40
        onClicked:{
            currentIndex=1
            themeList.setCurrentTheme(0)
        }
        Text {
            id: ciemnyTekst
            anchors.left: ciemny.right
            anchors.leftMargin: 2
            anchors.top: ciemny.top
            anchors.topMargin: 8
            text: qsTr("Ciemny motyw")
            font.pixelSize: 20
            color: themeList.foreground
        }
    }      
        Rectangle {
            id: tlo
            anchors.left: parent.left
            anchors.right: parent.right
            y: 44
            height: 29
            color: themeList.accent
            Text {
                id: text3
                anchors.left: tlo.left
                anchors.leftMargin: 48
                anchors.top: tlo.top
                //anchors.topMargin:
                text: qsTr("Zmiana motywu")
                font.pixelSize: 23
                font.bold: true
                color: themeList.foreground2

        }


    }
        Rectangle {
            id: tlo2
            anchors.left: parent.left
            anchors.right: parent.right
            y: 200
            height: 29
            color: themeList.accent
            Text {
                id: text4
                anchors.left: tlo2.left
                anchors.leftMargin: 48
                anchors.top: tlo2.top
                //anchors.topMargin:
                text: qsTr("Zmiana hasła")
                font.pixelSize: 23
                font.bold: true
                color: themeList.foreground2
        }
            Text{
                id: tekst
                text: qsTr("Nowe hasło")
                x: 65
                y:50
                font.pixelSize: 20
                color: themeList.foreground
            }
            TextField{
                id: newPass
                x: 65
                y: 80
                height: 30
                width: 200
                echoMode: TextInput.Password
            }
            Text{
                id: tekst2
                text: qsTr("Powtórz nowe hasło")
                x: 65
                y:130
                font.pixelSize: 20
                color: themeList.foreground
            }
            TextField{
                id: newPassRepeated
                x: 65
                y: 160
                height: 30
                width: 200
                echoMode: TextInput.Password
                Text{
                    id: wrongPass
                    text: qsTr("Hasła nie są takie same!")
                    anchors.left: parent.right
                    anchors.leftMargin: 15
                    font.pixelSize: 20
                    color: "red"
                    visible: false
                }

            }


    }
        Button{
            id: changePassButt
            y: 420
            x: 148
            width: 120
            height: 50
            contentItem:
                Text {
                        text: qsTr("Zmień hasło")
                        font: changePassButt.font
                        color: changePassButt.down ? "#9E912E" : "#293D79"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    background: Rectangle {
                        implicitHeight: changePassButt.height
                        implicitWidth: changePassButt.width
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        border.color: changePassButt.down ? "#9E912E" : "#293D79"
                        border.width: 1
                        radius: 2
                    }
                    Text{
                        id: gutPass
                        text: qsTr("Hasło pomyślnie zmienione")
                        anchors.left: changePassButt.right
                        anchors.leftMargin: 15
                        color: "green"
                        font.pixelSize: 20
                        anchors.top: changePassButt.top
                        anchors.topMargin: 12
                        visible: false
                    }

                    onClicked:{
                        if(newPass.text==newPassRepeated.text){

                        account.changePassword(account.loggedId, newPass.text)
                        account.updateModel()
                        wrongPass.visible=false
                            gutPass.visible=true
                        }
                        else{
                            wrongPass.visible=true
                            gutPass.visible=false
                        }

                    }
            }

        }



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
