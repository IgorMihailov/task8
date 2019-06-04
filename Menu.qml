import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Window 2.3


    Rectangle {
        id: menu
        visible: true
        color: "white"
        anchors.fill: parent
        state: "menu"

        signal gameStarted
        signal leaderboardOpened
        signal windowClosed

        /* Задний фон */
        Image
        {
            id: menubackground
            x: 0
            y: 0
            width: window.width
            height: window.height
            source: "qrc:/sources/menuBG.png"
        }

        /* Кнопка начала игры */
        Button {
            id: startgame
            x: 100
            y: parent.height / 8
            width: startgamemouse.containsMouse ? 330 : 310
            height: 90
            font.family: "Verdana"
            font.pointSize: startgamemouse.containsMouse ? 24 : 22

            text: qsTr("Начать игру")

            background: Rectangle {
                anchors.fill: parent
                color: "#FDE74C"
            }

            MouseArea {
                id: startgamemouse
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    gameStarted()
                }
            }
        }


        /* Кнопка таблицы рекордов */
        Button {
            id: settings
            width: settingsmouse.containsMouse ? 330 : 310
            height: 90
            anchors.verticalCenterOffset: 140
            anchors.verticalCenter: startgame.verticalCenter
            font.family: "Verdana"
            font.pointSize: settingsmouse.containsMouse ? 24 : 22
            x: 100
            text: qsTr("Таблица рекордов")

            background: Rectangle {
                anchors.fill: parent
                color: "#FDE74C"
            }

            MouseArea {
                id: settingsmouse
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    leaderboardOpened()
                }
            }
        }

        /* Кнопка выхода из игры */
        Button {
            id: exitgame
            width: exitgamemouse.containsMouse ? 330 : 310
            height: 90
            anchors.verticalCenterOffset: 140
            anchors.verticalCenter: settings.verticalCenter
            anchors.horizontalCenterOffset: 0
            font.family: "Verdana"
            font.pointSize: exitgamemouse.containsMouse ? 24 : 22
            x: 100
            text: qsTr("Выход")

            background: Rectangle {
                anchors.fill: parent
                color: "#FDE74C"
            }

            MouseArea {
                id: exitgamemouse
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    windowClosed()
                }
            }
        }
    }
