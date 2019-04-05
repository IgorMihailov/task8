import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    minimumWidth: 1024
    minimumHeight: 768
    maximumWidth: 1024
    maximumHeight: 768
    title: qsTr("The GAME")

    //Задний план
    Rectangle
    {
        id: background
        x: 0
        y: 0
        width: window.width
        height: window.height
        color: "#d3d3d3"
    }

    //Игрок
    Rectangle
    {
        id: player
        x: background.width / 2
        y: background.height - 30
        width: 30
        height: 30
        color: "#4e9a06"
        opacity: 1
        visible: true
        clip: false
        focus: true

        property int xv: 0
        property int yv: 0

        //При нажатии клавиши
        Keys.onPressed:
        {
            if (event.isAutoRepeat) return;


            switch (event.key)
            {
                case Qt.Key_Left: xv -= 2; break;
                case Qt.Key_Right: xv += 2; break;
            }


        }

        //При разжатии клавиши
        Keys.onReleased:
        {
            if (event.isAutoRepeat) return;
            switch (event.key)
            {
                case Qt.Key_Left: xv += 2; break;
                case Qt.Key_Right: xv -= 2; break;
            }
        }

                //Таймер обновления экрана и отрисовки объектов
                Timer
                {
                        interval: 8
                        running: true
                        repeat: true
                        onTriggered:
                        {
                                player.x += player.xv

                                //Ограничение перемещения игрока краями экрана
                                if (player.x + player.xv <= 0)
                                    player.x = 0;
                                if (player.x >= background.width - player.width)
                                    player.x = background.width - player.width;
                        }
                }
    }



}


