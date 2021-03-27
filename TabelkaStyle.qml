import QtQuick 2.0
import QtQuick 2.12
import QtQuick 2.5
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import student 1.0
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
//^na razie niech zostanie, potem wywalę co niepotrzebne

// Szablon dla (być może) wszystkich tabelek. Fajnie, bo nie trzeba zaśmiecać kodu w innych plikach jednym i tym samym, jak się pewnie i tak będzie powtarzać.
TableViewStyle{
        backgroundColor : "#527AAC"

                headerDelegate: Rectangle { //bg headeru

                    height: textItem.implicitHeight * 1.2 + 15
                    width: textItem.implicitWidth
                    //color: "#385199"

                    gradient: Gradient{

                        GradientStop{position: 1; color: "#172957"} //dol
                        GradientStop{position: 0.2; color: "#3c6798"}
                        GradientStop{position: 0; color: "#43699f"} //gora
                    }  //też się da gradient

                    Text { //text w headerze
                        id: textItem
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter//styleData.textAlignment
                       // anchors.leftMargin: 12
                        text: styleData.value
                        elide: Text.ElideRight
                        font.weight: Font.Bold
                        font.family: Qt.font()
                        color: "#ffffff"
                        renderType: Text.NativeRendering
                    }
                    Rectangle { //kreseczka między
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.topMargin: 1
                        width: 1
                        color: "#ccc"
                    }
                }
                itemDelegate: Item {
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#ffffff"
                        elide: styleData.elideMode
                        text: styleData.value
                    }
                }

                rowDelegate: Rectangle
                {   id: delegatRow
                    anchors.fill: parent
                    color: styleData.selected ? '#172957' : (styleData.alternate ? '#3c6798' : '#43699f');
                /*MouseArea{
                anchors.fill: parent
                //można wkleić szablon uniwersalnego mouse area do tego szablonu
                //jak jest pusty to nie działa as intended więc zakomentuję na razie xd
                }*/

                }

}
