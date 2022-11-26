import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: btnTopBar

    //CUSTOM PROPERTIES
    property url btnIconSource: "images/minimize_icon.svg"
    property color btnColorDefault: "#06161c"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"

    QtObject{
        id: internal

        //MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                        btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    width: 35
    height: 35

        Image{
            id: iconBtn
            layer.enabled: false
            anchors.verticalCenter: parent.verticalCenter
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit
        }
     background: Rectangle{
          id: bgBtn
          color: internal.dynamicColor
    }
}
