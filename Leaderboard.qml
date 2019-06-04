import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQml 2.3

Rectangle {
    id: leaderboard

    signal leaderboardClosed
    Text {
        x: 200
        y: 150
        text: "10 лучших результатов"
        font.pointSize: 20
    }

    Text {
        id: leaderlist
        x: 200
        y: 200
        text: ""
        font.pointSize: 16
    }

    Button {
        id: backtomenu
        x: 10
        y: 30
        width: backmouse.containsMouse ? 220 : 200
        height: 50
        text: "Вернуться в меню"
        font.family: "Verdana"

        MouseArea {
            id: backmouse
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                leaderboardClosed()
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#FDE74C"
        }

    }

    onVisibleChanged: {
       leaderlist.text = col.loadresult();
    }
}
