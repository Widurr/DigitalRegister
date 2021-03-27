import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQml 2.15

ApplicationWindow {
    id: window
    width: 950
    height: 700
    minimumHeight: 500
    minimumWidth: 650
    visible: true
    title: qsTr("Dziennik elektroniczny") //lepsza nazwa
    property bool ifLogged: account.statusLogged()

    header: ToolBar {
        id: pasek

        objectName: "pasek"
     Connections{
         target: account
         function onLoginChanged() {
           window.ifLogged = account.statusLogged()

         }
       }

       // visible: ifLogged
        contentHeight: toolButton.implicitHeight
        background:

            Rectangle{
        implicitWidth: parent.width
        implicitHeight: parent.height

        gradient: Gradient {

        GradientStop{position: 1; color: "#172957"} //dol
        GradientStop{position: 0.2; color: "#3c6798"}
        GradientStop{position: 0; color: "#43699f"} //gora
        }


        }

        Drawer {
            id: drawer

            OpacityMask {
                       source: mask

                   }

                   LinearGradient {
                       id: mask
                       anchors.fill: parent
                       gradient: Gradient {
                           GradientStop { position: 0.3; color: "transparent"}
                           GradientStop { position: 0.09; color: "#172957" } //gora
                       }
                   }

            width: 221 //window.width * 0.37
            height: window.height
            background: Rectangle{
                opacity: 0.85
            implicitWidth: parent.width
            implicitHeight: parent.height
            color: "#172957"

            }


            Column {
                anchors.fill: parent


                ItemDelegate {

                    Label{
                    id: powrot
                    anchors.verticalCenter: parent.verticalCenter
                    x: 15
                    color: "white"
                    text: qsTr("\u2190")
                    font.pixelSize: 20
                    }
                    width: parent.width
                    id: first
                    onClicked: {
                        drawer.close()
                    }
                    onHoveredChanged: hovered ? powrot.color = "#e5b82c":
                    powrot.color = "white";


                }

                Item {
                  width: parent.width
                  height: first.height * 0.35

                }


                ItemDelegate {

                    Label{
                        id: twoje_zaj_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+book.width
                    color: "white"
                    text: qsTr("Twoje zajęcia")
                    }
                    Image{
                        id: book
                        source: "icons/book.png"
                        x: 15
                        y: twoje_zaj_txt.y-7
                        height: first.height-10
                        width: book.height
                        smooth: true


                    }
                    ColorOverlay{
                    id: bcolor
                    anchors.fill: book
                    source: book

                    }
                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Twoje_zajecia.qml")
                        drawer.close()

                    }
                    onHoveredChanged: hovered ? (bcolor.color = "#e5b82c",twoje_zaj_txt.color = "#e5b82c") : (bcolor.color="white", twoje_zaj_txt.color = "white")

                }

                Item { //brejk między sekcjami
                  width: parent.width
                  height: first.height * 0.35

                }


                ItemDelegate {

                    Label{
                    id: uczniowie_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+student.width
                    color: "white"
                    text: qsTr("Uczniowie")
                    }
                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Uczniowie.qml")
                        drawer.close()

                    }
                    onHoveredChanged: hovered ? (scolor.color = "#e5b82c",uczniowie_txt.color = "#e5b82c") : (scolor.color="white", uczniowie_txt.color = "white")

                    Image{
                        id: student
                        source: "icons/reading.png"
                        x: 15
                        y: uczniowie_txt.y-7
                        height: first.height-10
                        width: student.height

                        }
                    ColorOverlay{
                        id: scolor
                        anchors.fill: student
                        source: student

                    }
                    }

                ItemDelegate {

                    Label{
                    id: frekw
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+presence.width
                    color: "white"
                    text: qsTr("Frekwencja")
                    }
                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Frekwencja.qml")
                        drawer.close()
                    }
                    onHoveredChanged: hovered ? (pcolor.color = "#e5b82c",frekw.color = "#e5b82c") : (pcolor.color="white", frekw.color = "white")

                    Image{
                        id: presence
                        source: "icons/check-mark.png"
                        x: 15
                        y: frekw.y-6
                        height: first.height-10
                        width: presence.height

                    }
                    ColorOverlay{
                        id: pcolor
                        anchors.fill: presence
                        source: presence
                    }

                }
                ItemDelegate {

                    Label{
                    id: grupy_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+groups.width
                    color: "white"
                    text: qsTr("Grupy")
                    }


                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Grupy.qml")
                        drawer.close()

                    }
                    onHoveredChanged: hovered ? (gcolor.color = "#e5b82c",grupy_txt.color = "#e5b82c") : (gcolor.color="white", grupy_txt.color = "white")

                    Image{
                        id: groups
                        source: "icons/group.png"
                        x: 15
                        y: grupy_txt.y-6
                        height: first.height-10
                        width: groups.height

                    }
                    ColorOverlay{
                        id: gcolor
                        anchors.fill: groups
                        source: groups
                    }
                }


                Item { //brejk między sekcjami
                  width: parent.width
                  height: first.height * 0.35

                }
                Item { //brejk między sekcjami
                  width: parent.width
                  height: first.height * 0.35

                }

                ItemDelegate {

                    Label{
                    id: ustawienia_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+settings.width
                    color: "white"
                    text: qsTr("Ustawienia")
                    }

                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Ustawienia.qml")
                        drawer.close()

                    }
                    onHoveredChanged: hovered ? (settcolor.color = "#e5b82c",ustawienia_txt.color = "#e5b82c") : (settcolor.color="white", ustawienia_txt.color = "white")

                    Image{
                        id: settings
                        source: "icons/settings.png"
                        x: 15
                        y: ustawienia_txt.y-7
                        height: first.height-10
                        width: settings.height

                    }
                    ColorOverlay{
                        id: settcolor
                        anchors.fill: settings
                        source: settings
                    }
                }



                ItemDelegate {
                    id: pomoc_menu
                    Label{
                    id: pomoc_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+help.width
                    color: "white"
                    text: qsTr("Pomoc")
                    }


                    width: parent.width
                    onClicked: {
                        stackView.clear()
                        stackView.replace("Pomoc.qml")
                        drawer.close()

                    }

                   onHoveredChanged: hovered ? (hcolor.color = "#e5b82c",pomoc_txt.color = "#e5b82c") : (hcolor.color="white", pomoc_txt.color = "white")
                    Image{
                        id: help
                        source: "icons/help.png"
                        x: 15
                        y: pomoc_txt.y-5
                        height: first.height-10
                        width: help.height

                    }
                    ColorOverlay{
                        id: hcolor
                        anchors.fill: help
                        source: help
                    }


                }
                ItemDelegate {

                    Label{
                    id: wyloguj_txt
                    anchors.verticalCenter: parent.verticalCenter
                    x: 25+logout.width
                    text: qsTr("Wyloguj")
                    color: "white"
                    }
                    onClicked: {
                         stackView.clear()
                        account.login(-1)
                        stackView.replace("StronaGlowna.qml")
                        drawer.close()
                    }


                    width: parent.width
                   /* onClicked: {
                        stackView.clear()
                        stackView.replace("Pomoc.qml")
                        drawer.close()

                    } */
                    onHoveredChanged: hovered ? (lcolor.color = "#e5b82c",wyloguj_txt.color = "#e5b82c") : (lcolor.color="white", wyloguj_txt.color = "white")
                    Image{
                        id: logout
                        source: "icons/logout.png"
                        x: 15
                        y: wyloguj_txt.y-5
                        height: first.height-10
                        width: logout.height

                    }
                    ColorOverlay{
                        id: lcolor
                        anchors.fill: logout
                        source: logout
                    }
                }
            }
        }


        ToolButton { //MENU BUTTON
            id: toolButton
            visible: ifLogged
            x: 5
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6

            onClicked: {
                    drawer.open()

            }
            onHoveredChanged: hovered ? toolButoon_bg.color = "#17ffffff" :
            toolButoon_bg.color = "transparent";
           background: Rectangle {
               id: toolButoon_bg
                anchors.fill: parent
               width: 33
               height: 33

                    color: "transparent"
                    }
}
        ToolButton { //HOME BUTTON

            visible: ifLogged
            height: pasek.height
            width: toolButton.width
            Image {
                anchors.fill: parent
            anchors.horizontalCenter: parent
            id: toolButton2

            fillMode: Image.PreserveAspectFit
            source: "home-screen-512.png"
            }
            id: homeButton
            onHoveredChanged: hovered ? bg_home.color = "#17ffffff" :
            bg_home.color = "transparent";
            background: Rectangle {
                 anchors.fill: parent
                id: bg_home
                width: 33
                height: 33


                     color: "transparent"
                     }
            x: toolButton.x + 35 ;
            onClicked: {
                //if(stackView.currentItem !== "StronaGlowna.qml") <- coś kombinowałam, ale idk
              //  {
                    stackView.clear()
                   stackView.replace("StronaGlowna.qml")

               // }




                }

            }
       ToolButton { //przycisk BACK

            id: toolButton3
            x: toolButton2.x + 80 ;
            text: "\u25C0"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onHoveredChanged: hovered ? back_button_bg.color = "#17ffffff" :
            back_button_bg.color = "transparent";
            background: Rectangle {
                anchors.fill: parent
                id: back_button_bg
                width: 33
                height: 33


                     color: "transparent"
                     }


            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                }
               }
            visible: { stackView.depth > 1 ? true : false


            }
}

        Label { //nazwa strony na srodku w toolbarze

            id: txt_na_srodku_toolbaru
            text: stackView.currentItem.title
            anchors.centerIn: parent
            color: "white"
            visible: ifLogged
            //mozna dac ładną czcionkę or smth
            //wgle imagem to mozna zfillowac jakims gradientowym or smth, logo?
        }



        Label{ //czas wyswietlany w toolbarze
            id: czas
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            text: Qt.formatTime(new Date(),"hh:mm")
            color: "white"
            font.pixelSize: 15

        }

        Timer { //timer potrzebny do czasu w toolbarze
            id: timer
            interval: 1000
            repeat: true
            running: true

            onTriggered:
            {
                czas.text =  Qt.formatTime(new Date(),"hh:mm")
            }
        }



    }




    StackView {

        id: stackView
        initialItem: "StronaGlowna.qml"
        anchors.fill: parent



    }


}

