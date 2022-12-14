import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: btnToggle

    //CUSTOM PROPERTIES
    property url btnIconSource: "images/menu_icon.svg"
    property color btnColorDefault: "#06161c"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"

    QtObject{
        id: internal

        //MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnToggle.down){
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else {
                                        btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 70
    implicitHeight: 60

        Image{
            id: iconBtn
            layer.enabled: false
            anchors.verticalCenter: parent.verticalCenter
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }
     background: Rectangle{
          id: bgBtn
          color: internal.dynamicColor
    }
}
