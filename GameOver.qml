import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle {
    id: gameover

    signal gameoverClosed
    signal gameRestarted

    Text {
        x: 500 - this.width
        y: 50
        width: 100
        text: "Игра окончена"
        font.pointSize: 24
    }

    Text {
        x: 500 - this.width
        y: 100
        width: 80
        text: "Счёт: " + gameplay.scores
        font.pointSize: 16
    }

    Button {
        id: returntogame
        x: 500 - (this.width/2)
        y: 200
        width: startmouse.containsMouse ? 220 : 200
        height: 50
        text: "Начать заново"
        font.family: "Verdana"

        MouseArea {
            id: startmouse
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                gameRestarted()
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#FDE74C"
        }
    }

    Button {
        id: backtomenu
        x: 500 - (this.width/2)
        y: 260
        width: closemouse.containsMouse ? 220 : 200
        height: 50
        text: "Вернуться в меню"
        font.family: "Verdana"

        MouseArea {
            id: closemouse
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                gameoverClosed()
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#FDE74C"
        }
    }

    TextField {
        id: name
        x: 500 - (this.width/2)
        y: 360
        width: 200
        height: 50
        maximumLength: 10

    }

    onVisibleChanged: {
        saveresult.enabled = true;
        name.enabled = true;
    }

    Button {
        id: saveresult
        x: 500 - (this.width/2)
        y: 420
        width: savemouse.containsMouse ? 220 : 200
        height: 50
        text: "Сохранить результат"
        font.family: "Verdana"

        MouseArea {
            id: savemouse
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                col.saveresult(gameplay.scores, name.text);
                col.sorting();
                saveresult.enabled = false;
                name.text ="";
                name.enabled = false;
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#FDE74C"
        }
    }
}
