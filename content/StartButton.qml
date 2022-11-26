import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: customBtn
    width: 250
    height: 80
    text: qsTr("Начать игру")
    font.bold: true
    font.pointSize: 24
    property color btnColorDefault: "#FFA640"
    property color btnColorMouseOver: "#331E00"
    property color btnColorClicked: "#331E00"
    property color btnColorDefaultText: "#331E00"
    property color btnColorClickedText: "#ffffff"
    property color btnColorMouseOverText: "#ffffff"
    QtObject{
        id: internal

        //MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(customBtn.down){
                                       customBtn.down ? btnColorClicked : btnColorDefault
                                   } else {
                                        customBtn.hovered ? btnColorMouseOver : btnColorDefault
                                    }
        property var dynamicColortext: if(customBtn.down){
                                            customBtn.down ? btnColorMouseOverText : btnColorDefaultText
                                       } else {
                                            customBtn.hovered ? btnColorClickedText: btnColorDefaultText
                                       }

    }


    background: Rectangle{
        color: internal.dynamicColor
        radius: 15
        border.color: "#331E00"
        border.width: 3
    }
    contentItem: Item{
        id: iteml
        Text {
                id: textBtn
                text: customBtn.text
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pointSize: 24
                anchors.horizontalCenter: parent.horizontalCenter
                color: internal.dynamicColortext
            }
        }
}
