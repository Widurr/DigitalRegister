import account 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Page {
    id: strona
    implicitWidth: 950
    implicitHeight: 700
    title: qsTr("Wirtualny dziennik")

    Image {
        id: tlo
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "stock-images/art-2578353.jpg"


        Text {
            id: copyright_text
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
            id: rectangle_logowania_bialy
            visible: !account.statusLogged()
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width / 2
            height: parent.width / 3
            color: "#ffffff"
            radius: 9
            opacity: 0.9

            Item{
                id:stuff_do_logowania
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.9
                height: 25+ loginfield.height + logowanie_info_czy_bledne_itp.height + passwordfield.height + 5 + 1 + 10 + zaloguj_button.height






                TextField{
                    id: loginfield
                    placeholderText: qsTr("Nazwa użytkownika")
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.y
                    anchors.topMargin: 25
                    width: parent.width - 75

                    Text{
                        id: logowanie_info_czy_bledne_itp
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 5
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: ""
                        color: "red"

                    }

                    TextField{
                        id: passwordfield
                        placeholderText: qsTr("Hasło")
                        anchors.top: parent.bottom
                        anchors.topMargin: 1
                        width: parent.width
                        echoMode: TextInput.Password
                    }

                    Item {
                        id: linijka_dla_dwoch_buttonow
                        anchors.top: passwordfield.bottom
                        anchors.topMargin: 10
                        anchors.horizontalCenter: passwordfield.horizontalCenter
                        width: passwordfield.width


                    Button {
                        id: zaloguj_button

                            x: parent.width /2 + 2
                            width: parent.width /2 - 4
                            height: 40
                            contentItem: Text{
                                text: qsTr("Zaloguj")
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                                color: zaloguj_button.down ? "#9E912E" : "#293D79"
                            }
                            background: Rectangle {
                                   implicitWidth: zaloguj_button.width
                                   implicitHeight: zaloguj_button.height
                                   border.color: zaloguj_button.down ? "#9E912E" : "#293D79"
                                   border.width: 1
                                   radius: 2
                                   opacity: 0.9
                               }

                        onClicked: {
                            if(account.checkData(loginfield.text, passwordfield.text)){
                                account.login(account.getId(loginfield.text))
                                rectangle_logowania_bialy.visible = !account.statusLogged()
                                myModel.updateModel(account.loggedId)
                            }
                            else{
                                logowanie_info_czy_bledne_itp.color = "red"
                                logowanie_info_czy_bledne_itp.text = "Wprowadzono błędne dane"
                                loginfield.text = ""
                                passwordfield.text = ""
                            }
                        }

                    }
                    Button {
                        id: rejestracja
                        x: parent.x + 2
                        width: zaloguj_button.width
                        height: 40
                        contentItem: Text{
                            text: qsTr("Zarejestruj")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            color: rejestracja.down ? "#9E912E" : "#293D79"
                        }
                        background: Rectangle {
                               implicitWidth: rejestracja.width
                               implicitHeight: rejestracja.height
                               border.color: rejestracja.down ? "#9E912E" : "#293D79"
                               border.width: 1
                               radius: 2
                               opacity: 0.9
                           }


                        onClicked: {
                            if(!account.checkData(loginfield.text)){
                                database.inserIntoTable(loginfield.text, passwordfield.text)
                                logowanie_info_czy_bledne_itp.text = "Pomyślnie utworzono użytkownika"
                                logowanie_info_czy_bledne_itp.color = "green"
                                loginfield.text = ""
                                passwordfield.text = ""
                            }
                            else{
                                logowanie_info_czy_bledne_itp.color = "red"
                                logowanie_info_czy_bledne_itp.text = "Już utworzono takiego użytkownika"
                                loginfield.text = ""
                                passwordfield.text = ""
                            }
                        }
                    }

                    }
                }



            }

            Label {
                x: 38
                y: 107
                id: naglowek_digitalregister
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


        //Stuff po zalogowaniu:



        //v------- to zostanie zastąpione modelem "zajęć w danym dniu", który pewnie kiedyś powstanie <3
        ListModel {
                            id: modelek
                            ListElement {
                                name: "10:30 Matematyka - klasa 1b"
                                colorCode: "#275C7A"
                               // colorA: "#172957"
                                 //   colorB: "#3c6798"
                               // colorC: "#43699f"
                            }

                            ListElement {
                                name: "12:15 Informatyka - klasa 1a"
                                colorCode: "#275C7A"
                               // colorA: "#172957"
                                 //   colorB: "#3c6798"
                               // colorC: "#43699f"
                            }

                            ListElement {
                                name: "13:30 Lekcja QT - klasa 2b"
                                colorCode: "#275C7A"
                               // colorA: "#172957"
                                //    colorB: "#3c6798"
                               // colorC: "#43699f"
                            }


                            ListElement {
                                name: "15:00 Systemy ekspertowe xd - Algorytmika i programowanie"
                                colorCode: "#C7676B"
                                //colorA: "#675907"
                                   // colorB: "#ddc42d"
                               // colorC: "#ce8123"
                            }
                            ListElement {
                                name: "16:00 Matematyka - 1b"
                                colorCode: "#C7C440"
                               // colorA: "#833b0b"
                                  //  colorB: "#ce2b0e"
                               // colorC: "#df6f33"
                            }
                            ListElement {
                                name: "17:00 - Systemy operacyjne wykład - gr1"
                                colorCode: "#C7C440"
                                //colorA: "#833b0b"
                                 //   colorB: "#ce2b0e"
                                //colorC: "#df6f33"
                            }
                            ListElement {
                                name: "18:00 - Informatyka - gr2"
                                colorCode: "#C7C440"
                                //colorA: "#833b0b"
                                 //   colorB: "#ce2b0e"
                               // colorC: "#df6f33"
                            }
                        }



        Image {
            id: tlo2
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "stock-images/desktop2.jpg"
            visible: false
           x: -1
           y: -1


        }


        Rectangle {
            id: rect_po_log_dzisiejsze_zajecia
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 12.5
            width: parent.width / 3
            height: parent.height - 30
            color: "#549CC7"
            radius: 9
            opacity: 0.9
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: -3
                color: "#80000000"
                radius: 2
                samples: 3
            }



            Item{
            id: na_listview
             width: parent.width - 20
            height: {

                                                    if (window.height < 900 )
                                                    {
                                                        height: (parent.height - dzisiejsze_zaj_naglowek.height) /3

                                                    }
                                                    else
                                                    { height: (40 * listView.count) + listView.count }




            }

            anchors.top: dzisiejsze_zaj_naglowek.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter




            ListView {
                id: listView
                clip: true
                anchors.fill: parent
                width: parent.width - 20
                height: modelek.items.length * height
                spacing: 1

                ScrollBar.vertical: ScrollBar {
                    id: scroll
                        active: true

                        }

                delegate: Item {

                    width: rect_po_log_dzisiejsze_zajecia.width - 20
                    height: 40
                    Row {
                        id: row1
                       // spacing: 10
                        Rectangle {
                            id: rektu
                            width: rect_po_log_dzisiejsze_zajecia.width - 20
                            height: 40
                           color: colorCode
                            radius: 9

                            Text {
                                text: name
                                color: "#ffffff"
                                anchors.horizontalCenter: parent.horizontalCenter
                                wrapMode: Text.WordWrap
                                anchors.right: parent.right
                                anchors.rightMargin: 5
                                font.bold: true
                                font.pixelSize: { //mozna dopracowac / lepsze parametry more thought out
                                    if (window.width > 900 )
                                    {
                                        pixelSize: 16
                                    }
                                    else
                                    { pixelSize: window.width * 0.019 }
                                }

                            }


                        }
                    }
                }
                model: modelek
            }


            }




            Text{
                id: dzisiejsze_zaj_naglowek
                text: "Dzisiejsze zajęcia"
                font.weight: Font.Bold
                font.family: "Verdana"
                font.pixelSize:    {
                                     if (window.width > 1100 )
                                     {
                                         pixelSize: 25
                                     }
                                     else
                                     { pixelSize: window.width * 0.022 }
                                 }
                anchors.top: parent.top
                anchors.topMargin: 5
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                color: "#EDF4F6"

            }

Item{
id: na_kalen
anchors.top: na_listview.bottom
 anchors.topMargin: 5
height: parent.height - (na_listview.height + na_date_i_godzine.height + 10)
width: parent.width - 20
anchors.horizontalCenter: parent.horizontalCenter
anchors.bottom: na_date_i_godzine.top
anchors.bottomMargin: 4



Calendar {
    id: kalen
    anchors.fill: parent


    style: CalendarStyle {
        gridVisible: false
       // navigationBar: - mozna go zmienic ale chyba recznie tylko :/
        dayDelegate: Rectangle {
            color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");

            Label {
                text: styleData.date.getDate()
                //font.pixelSize:
                anchors.centerIn: parent
                color: styleData.valid ? "white" : "grey"
                font.pixelSize:  {
                    if (window.width > 1100 )
                    {
                        pixelSize: 20
                    }
                    else
                    { pixelSize: window.width * 0.02 }
                }

            }

            Rectangle { //krecha oddzielająca tygodnie
                width: parent.width
                height: 1
                color: "#555"
                anchors.bottom: parent.bottom
            }

            Rectangle { //krecha oddzielająca dni
                width: 1
                height: parent.height
                color: "#555"
                anchors.right: parent.right
            }
        }
    }
}


}


            Item{
            height:  {
                if (window.height > 700 )
                {
                    height: 80
                }
                else
                { height: 70 }
            }
            width: parent.width
            id: na_date_i_godzine
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7



           Label{
               id: data_po_polsku

               anchors.horizontalCenter: parent.horizontalCenter
               anchors.top: parent.top
               anchors.topMargin: 4
               color: "white"
               width: parent.width - 5
               horizontalAlignment: Text.AlignHCenter
               font.weight: Font.Bold
               font.pixelSize:    {
                                    if (window.height > 700 )
                                    {
                                        pixelSize: 20
                                    }
                                    else
                                    { pixelSize: 15 }
                                }
              wrapMode: Text.WordWrap



           }
           Label{
               id: czas_plynacy

               anchors.horizontalCenter: parent.horizontalCenter
               anchors.bottom: parent.bottom
               anchors.bottomMargin: 3
               color: "white"
               width: parent.width
               horizontalAlignment: Text.AlignHCenter
               font.weight: Font.Bold
               font.pixelSize:    {
                                    if (window.height > 700 )
                                    {
                                        pixelSize: 30
                                    }
                                    else
                                    { pixelSize: 26 }
                                }



           }




           Timer {
               id: timer
               interval: 1000
               repeat: true
               running: true

               onTriggered:
               {
                   data_po_polsku.text =  "Dziś jest " + new Date().toLocaleDateString(Qt.locale("pl_PL"))
                           //Qt.formatTime(new Date(),"hh:mm:ss")
               }
           }
           Timer {
               id: timer2
               interval: 1000
               repeat: true
               running: true

               onTriggered:
               {
                   czas_plynacy.text =  Qt.formatTime(new Date(),"hh:mm:ss")

               }
           }
            }


}


         Rectangle {
         id: rect_po_log_najblizsze_zaj
           visible: false
           anchors.bottom: rect_po_log_dzisiejsze_zajecia.bottom
           anchors.right: rect_po_log_dzisiejsze_zajecia.left
           anchors.rightMargin: 10 // FUTURE: mozna relatywny, bo potem az razi ze taki maly
           width: rect_po_log_dzisiejsze_zajecia.width * 0.8
            height: rect_po_log_dzisiejsze_zajecia.height * 0.6
           color: "#58baa9"
           radius: 9
           opacity: 0.9
           layer.enabled: true
           layer.effect: DropShadow {
               verticalOffset: -3
               color: "#80000000"
               radius: 2
               samples: 3
           }

           Text{
               id: najblizsze_zaj_naglowek
               text: "Najbliższe zajęcia"
               font.weight: Font.Bold
               font.family: "Verdana"
               font.pixelSize:  {
                   if (window.width > 1100 )
                   {
                       pixelSize: 25
                   }
                   else
                   { pixelSize: window.width * 0.022 }
               }

               anchors.top: parent.top
               anchors.topMargin: 5
               width: parent.width
               horizontalAlignment: Text.AlignHCenter
               color: "#EDF4F6"
               wrapMode: Text.WordWrap

           }
           Rectangle{
               id: dane_najblizszych_zajec
           width: parent.width - 20
           height: parent.height - 10
           color: "#F0A1A4"
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.top: najblizsze_zaj_naglowek.bottom
           anchors.topMargin: 10
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 10
           radius: 9
           opacity: 0.9
           layer.enabled: true
           layer.effect: DropShadow {
               verticalOffset: -3
               color: "#80000000"
               radius: 2
               samples: 3
           }
           Item{
           id: srodkowanie_modulu_najblizsze_zaj
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           width: parent.width
           height: najblizsze_zaj_informacja1.height  + data_h_najblizszych_zaj.height + 5 + but1.height + but2.height + but3.height + 20

           Text{
               id: najblizsze_zaj_informacja1
               anchors.horizontalCenter: parent.horizontalCenter

           text: "Matematyka - klasa 1b"
           font.pixelSize:  window.width * 0.02
           color: "#EDF4F6"
           font.weight: Font.Bold
           horizontalAlignment: Text.AlignHCenter
           wrapMode: Text.WordWrap
           anchors.top: parent.top
          // anchors.topMargin: 5
           width: parent.width - 5
           }
           Text{

               id: data_h_najblizszych_zaj
               anchors.horizontalCenter: parent.horizontalCenter
           text: "12.12.2025   10:30"
           font.pixelSize: window.width * 0.02
           color: "#EDF4F6"
           font.weight: Font.Bold
           horizontalAlignment: Text.AlignHCenter
           wrapMode: Text.WordWrap
           anchors.top: najblizsze_zaj_informacja1.bottom
           anchors.topMargin: 5
           width: parent.width - 5
           }

           Button{
               id: but1
           text: "Przejdź do zajęć"
           font.pixelSize: {
               if (window.width > 1100 )
               {
                   pixelSize: 20
               }
               else
               { pixelSize: window.width * 0.017 }
           }
           width: parent.width - 30
           anchors.top: data_h_najblizszych_zaj.bottom
           anchors.topMargin: 10
           height: {
               if (window.height > 1100 )
               {
                   height: 20
               }
               else
               { height: window.height * 0.06 }
           }
           anchors.horizontalCenter: parent.horizontalCenter
           background: Rectangle{

               color: but1.down ? "#D4D4D4" : "#FFFFFF"
           }



           }
           Button{
               id: but2
           text: "Frekwencja"
           font.pixelSize: {
               if (window.width > 1100 )
               {
                   pixelSize: 20
               }
               else
               { pixelSize: window.width * 0.017 }
           }
           width: parent.width - 30
           anchors.top: but1.bottom
           anchors.topMargin: 5
           height: {
               if (window.height > 1100 )
               {
                   height: 20
               }
               else
               { height: window.height * 0.06 }
           }
           anchors.horizontalCenter: parent.horizontalCenter
           background: Rectangle{

               color: but2.down ? "#D4D4D4" : "#FFFFFF"
           }


           }
           Button{
               id: but3
           text: "Oceny"
           font.pixelSize: {
               if (window.width > 1100 )
               {
                   pixelSize: 20
               }
               else
               { pixelSize: window.width * 0.017 }
           }
           width: parent.width - 30
           anchors.top: but2.bottom
           anchors.topMargin: 5
           height: {
               if (window.height > 1100 )
               {
                   height: 20
               }
               else
               { height: window.height * 0.06 }
           }
           anchors.horizontalCenter: parent.horizontalCenter
           background: Rectangle{

               color: but3.down ? "#D4D4D4" : "#FFFFFF"
           }


           }



           }





           }






         }


    }




//klamra [ po states:
        states: State {
        name: "zalogowany"; when: ifLogged == true

        PropertyChanges {target: rect_po_log_dzisiejsze_zajecia; visible: true}
        PropertyChanges {target: czas; visible: true}
        PropertyChanges {target: rect_po_log_najblizsze_zaj; visible: true}

        PropertyChanges {target:tlo2; visible: true; x: 50; y: 50}



        } //przecinek
       /* State{
                name: "niezalogowany"; when: ifLogged == false


        } */


//klamra ]

/*
        transitions: [
                Transition {
                    from: root
                    to: "zalogowany"

                    NumberAnimation {
                        target: tlo2
                        property: "visible"
                        duration: 0
                    }

                    SequentialAnimation{
                       NumberAnimation {
                           target: tlo2
                           property: "x"
                           duration: 1000
                           easing.type: Easing.InOutQuad
                       }

                    }
                },
                Transition {
                    from: root
                    to: "zalogowany"
                    SequentialAnimation{
                       NumberAnimation {
                           target: tlo2
                           property: "visible"
                           duration: 0
                       }
                       NumberAnimation {
                           target: tlo2
                           property: "x"
                           duration: 1000
                           easing.type: Easing.InOutQuad
                       }
                    }
                }
            ] */





}


    /*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


