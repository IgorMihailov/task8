import QtQuick 2.0
import QtQuick.Window 2.3

Window {
    id: window
    visible: true
    minimumWidth: 1000
    minimumHeight: 800
    maximumWidth: 1000
    maximumHeight: 800
    title: qsTr("The GAME")

    Rectangle {
        anchors.fill: parent
        visible: true
        id: main
        state: "menu"

        Menu {
            id: menu
            onGameStarted: {
                parent.state = "game"
                gameplay.newgame()
            }
            onLeaderboardOpened: parent.state = "leaderboard"
            onWindowClosed: window.close()
        }

        Gameplay {
            id: gameplay
            onGameStopped: parent.state = "menu"
            onEndGame: parent.state = "death"
        }

        Leaderboard {
            id: leaderboard
            onLeaderboardClosed: parent.state = "menu"
        }

        GameOver {
            id: gameover
            onGameoverClosed: parent.state = "menu"
            onGameRestarted: {
                parent.state = "game"
                gameplay.newgame();
            }
        }

        states: [
            State {
                name: "menu"
                PropertyChanges {target: menu; visible: true}
                PropertyChanges {target: gameplay; visible: false}
                PropertyChanges {target: leaderboard; visible: false}
                PropertyChanges {target: gameover; visible: false}
            },
            State {
                name: "game"
                PropertyChanges {target: menu; visible: false}
                PropertyChanges {target: gameplay; visible: true}
                PropertyChanges {target: leaderboard; visible: false}
                PropertyChanges {target: gameover; visible: false}
            },
            State {
                name: "leaderboard"
                PropertyChanges {target: menu; visible: false}
                PropertyChanges {target: gameplay; visible: false}
                PropertyChanges {target: leaderboard; visible: true}
                PropertyChanges {target: gameover; visible: false}
            },
            State {
                name: "death"
                PropertyChanges {target: menu; visible: false}
                PropertyChanges {target: gameplay; visible: false}
                PropertyChanges {target: leaderboard; visible: false}
                PropertyChanges {target: gameover; visible: true}
            }
        ]
    }
}
