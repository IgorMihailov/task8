import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr("The GAME")

    //Задний план
    Rectangle {
        id: background
        x: 0
        y: 0
        width: 800
        height: 600
        color: "#d3d3d3"
       }

    //Игрок
    Rectangle
    {
        id: player
        x: background.width / 2
        y: background.height - 500
        width: 30
        height: 30
        color: "#4e9a06"
        opacity: 1
        visible: true
        clip: false
        focus: true

        property real xv: 0
        property real yv: 0

        /*Ускорение свободного падения*/
        property real accel: 0
        /*Стоит ли игрок на чём-то*/
        property bool standing: false
        /*Прыгает ли игрок*/
        property bool jumping: false

                Keys.onPressed:
                {
                    if (event.isAutoRepeat) return;


                    switch (event.key)
                    {
                        /*Хотьба*/
                        case Qt.Key_Left: xv -= 2; break;
                        case Qt.Key_Right: xv += 2; break;

                        /*Прыжки*/
                        case Qt.Key_Up: jumping = true; break;
                    }

                }

                Keys.onReleased:
                {
                    if (event.isAutoRepeat) return;
                    switch (event.key)
                    {
                        case Qt.Key_Left: xv += 2; break;
                        case Qt.Key_Right: xv -= 2; break;

                        /*Прыжки*/
                        case Qt.Key_Up: jumping = false; break;
                    }

                }


                Timer
                {
                        interval: 8
                        running: true
                        repeat: true
                        onTriggered:
                        {
                            /*Если игрок не в воздухе и зажата клавиша прыжка, то прыгаем*/
                            if (player.jumping == true && player.standing == true)
                            {
                                player.yv = -5;
                                /*При прыжке персонаж не стоит*/
                                player.standing = false;
                            }

                            /*Гравитация*/
                            player.yv += player.accel;
                            player.y += player.yv
                            /*Перемещение*/
                            player.x += player.xv

                            /*Проверка на коллизию*/
                            if (player.y + player.height > background.height)
                            {
                                player.y = background.height - player.height;
                                player.accel = 0;
                                player.yv = 0;
                                player.standing = true;
                            }
                            else
                            {
                                player.accel = 0.1;
                                player.standing = false;
                            }



                        }
                }

    }



}


