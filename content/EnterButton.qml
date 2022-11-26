import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: enterBtn
    width: 250
    height: 80
    text: qsTr("Камень 🪨")
    font.bold: true
    font.pointSize: 24
    property color btnColorDefault: "#FFA640"
    property color btnColorMouseOver: "#331E00"
    property color btnColorClicked: "#331E00"
    QtObject{
        id: internal

        //MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(enterBtn.down){
                                       enterBtn.down ? btnColorClicked : btnColorDefault
                                   } else {
                                        enterBtn.hovered ? btnColorMouseOver : btnColorDefault
                                    }

    }


    background: Rectangle{
        color: internal.dynamicColor
        radius: 15
    }
    contentItem: Item{
        id: itemtextenter
        Text {
                id: textBtnEnter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pointSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#ffffff"
                text: enterBtn.text
            }
        }
}
