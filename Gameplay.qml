import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQml 2.3

Rectangle {
    id: gameplay

    signal gameStopped
    signal endGame
    property int scores: 0
    property int health: 3
    property int spikevelocity: 2
    property real difficulty: 1



    function newgame()
    {
        player.x = window.width / 2;
        player.y = window.height;
        player.xv = 0;
        player.yv = 0;
        player.accel = 0;
        player.jumping = false;
        timer.restart();
        falltimer.restart();
        player.focus = true;
        crate.x = Math.floor(Math.random() * (background.width - crate.width))
        crate.y = background.height + crate.height
        super_crate.x = Math.floor(Math.random() * (background.width - crate.width))
        super_crate.y = background.height + super_crate.height
        health_crate.x = Math.floor(Math.random() * (background.width - crate.width))
        health_crate.y = background.height + health_crate.height
        fireball.x = Math.floor(Math.random() * (background.width - crate.width))
        fireball.y = background.height + fireball.height
        scores = 0
        health = 3
        spike.x = 0
        spikevelocity = 2
        player.damaged = false
        difficulty = 1

    }

    //Задний план
    Image
    {
        id: background
        x: 0
        y: 0
        width: window.width
        height: window.height
        source: "qrc:/sources/back.png"
    }

    Button {
        x: 10
        y: 10
        font.family: "Verdana"
        height: 50
        width: 200
        text: "Вернуться в меню"
        onClicked: gameStopped()

        background: Rectangle {
            anchors.fill: parent
            color: "#FDE74C"
        }
    }

    Text {
            id: scoresText
            text: "Очки: "
            x: background.width - 120
            y:  40
            color: "red"
            font.pixelSize: 20
      }

    Text {
            id: scoresValue
            text: gameplay.scores
            x: background.width - 40
            y:  40
            color: "red"
            font.pixelSize: 20
      }

    // Хп
    Image {
        id: hp
        width: 180
        height: 80
        x: background.width - this.width
        y: this.height
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/heart3.png"
    }

    // Шип
    Image {
        id: spike
        width: 50
        height: 50
        x: 400
        y: background.height - this.height
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/spike.png"
        clip: false
    }

    // Ящик, приносящий очки
    Image {
        id: crate
        width: 80
        height: 80
        x: Math.floor(Math.random() * (background.width - crate.width))
        y: 0
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/crate1.png"
        clip: false
    }

    // Ящик, приносящий 3 очка
    Image {
        id: super_crate
        width: 80
        height: 80
        x: Math.floor(Math.random() * (background.width - crate.width))
        y: 0
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/super_crate.png"
        clip: false
    }

    // Ящик, приносящий здоровье
    Image {
        id: health_crate
        width: 80
        height: 80
        x: Math.floor(Math.random() * (background.width - crate.width))
        y: 0
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/health_crate.png"
        clip: false
    }

    //Фаерболы
    Image {
        id: fireball
        width: 100
        height: 100
        x: Math.floor(Math.random() * (background.width - fireball.width))
        y: 0
        opacity: 1
        visible: gameplay.visible
        source: "qrc:/sources/fireball.png"
        clip: false
   }

    //Таймер падения объектов
    Timer {
        id: falltimer
        interval: 3
        running: gameplay.visible
        repeat: true
        onTriggered: {

            //Движение объектов
            crate.y+=3*difficulty;
            fireball.y+=4*difficulty;
            super_crate.y+=5*difficulty;
            health_crate.y+=4*difficulty;
            spike.x+=spikevelocity*difficulty;

            //Изменение направления шипа
            if (spike.x + spike.width >= background.width || spike.x <= 0) {
                spikevelocity = spikevelocity * (-1);

            }

            //Коллизия шипа
            if (player.x < spike.x + spike.width &&
                    player.x > spike.x &&
                    player.y + player.height > background.height - spike.height &&
                    player.damaged == false)
            {
                health--;
                player.damaged = true;
            }
            if (player.x > spike.x + spike.width ||
                                player.x < spike.x ||
                                player.y + player.height < background.height - spike.height &&
                                player.damaged == true)
                player.damaged = false;


            //Респавн ящика при касании земли
            if (crate.y + crate.height > background.height) {
                crate.x = Math.floor(Math.random() * (background.width - crate.width))
                crate.y = 0
            }
            //Респавн ящика и увеличение очков при касании игроком
            if (col.check(player.x,player.y, player.height, player.width,
                          crate.x, crate.y, crate.height, crate.width)){
                crate.x = Math.floor(Math.random() * (background.width - crate.width))
                crate.y = 0
                scores++
                difficulty+=0.03
            }

            //Респавн супер ящика при касании земли
            if (super_crate.y + super_crate.height > background.height && Math.random() < 0.002) {
                super_crate.x = Math.floor(Math.random() * (background.width - super_crate.width))
                super_crate.y = 0
            }
            //Респавн супер ящика и увеличение очков при касании игроком
            if (col.check(player.x,player.y, player.height, player.width,
                          super_crate.x, super_crate.y, super_crate.height, super_crate.width)){
                super_crate.x = Math.floor(Math.random() * (background.width - super_crate.width))
                super_crate.y = background.height + super_crate.height
                scores+=3
                difficulty+=0.03
            }

            //Респавн ящика со здоровьем при касании земли
            if (health_crate.y + health_crate.height > background.height && Math.random() < 0.002) {
                health_crate.x = Math.floor(Math.random() * (background.width - health_crate.width))
                health_crate.y = 0
            }
            //Респавн ящика и увеличение очков при касании игроком
            if (col.check(player.x,player.y, player.height, player.width,
                          health_crate.x, health_crate.y, health_crate.height, health_crate.width)){
                health_crate.x = Math.floor(Math.random() * (background.width - health_crate.width))
                health_crate.y = background.height + health_crate.height
                health = 3
                difficulty+=0.03
            }

            //Респавн фаерболов при касании земли
            if (fireball.y + fireball.height > background.height && Math.random() < 1 ) {
                fireball.x = Math.floor(Math.random() * (background.width - fireball.width))
                fireball.y = 0
            }
            //Респавн фаерболов и уменьшение очков при касании игроком
            if (fireball.y + fireball.height < player.y + player.height &&
                    fireball.y + fireball.width > player.y &&
                    player.x < fireball.x + fireball.width &&
                    player.x > fireball.x - player.width){
                fireball.x = Math.floor(Math.random() * (background.width - fireball.width))
                fireball.y = 0
                health--
            }

            // Изсенение количества сердечек
            if (health == 3) {
                hp.source = "qrc:/sources/heart3.png"
                hp.width = 180
            }
            if (health == 2) {
                hp.source = "qrc:/sources/heart2.png"
                hp.width = 120
            }
            if (health == 1) {
                hp.source = "qrc:/sources/heart1.png"
                hp.width = 60
            }

            //Завершение игры при отрицательных очках
            if (health <= 0){
                endGame()
            }

        }
    }

    //Игрок
    Image
    {
        id: player
        x: window.height / 2
        y: window.height;
        width: 60
        height: 80
        source: "sources/1.png"
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
        /*Повёрнут ли игрок вправо*/
        property bool turnedright: true
        /*Поврежден ли игрок шипом*/
        property bool damaged: false

        //При нажатии клавиши
        Keys.onPressed:
        {
            if (event.isAutoRepeat) return;
            switch (event.key)
            {
                case Qt.Key_Left: xv -= 5; turnedright = false; break;
                case Qt.Key_Right: xv += 5; turnedright = true; break;
                case Qt.Key_Up: jumping = true; break
            }
        }

        //При разжатии клавиши
        Keys.onReleased:
        {
            if (event.isAutoRepeat) return;
            switch (event.key)
            {
                case Qt.Key_Left: xv += 5;  break;
                case Qt.Key_Right: xv -= 5;  break;
                case Qt.Key_Up: jumping = false; break;
            }
        }

        //Таймер обработки игрока
        Timer
        {
                id: timer
                interval: 3
                running: gameplay.visible
                repeat: true
                onTriggered:
                {
                    /*Разворот игрока в нужную сторону*/
                    player.turnedright ? player.source = "sources/1.png" : player.source = "sources/2.png"

                    player.x += player.xv

                    /*Если игрок не в воздухе и зажата клавиша прыжка, то прыгаем*/
                    if (player.jumping == true && player.standing == true)
                    {
                        player.yv = -7;
                        /*При прыжке персонаж не стоит*/
                        player.standing = false;
                    }

                    /*Гравитация*/
                    player.yv += player.accel;
                    player.y += player.yv
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

                    //Ограничение перемещения игрока краями экрана
                    if (player.x + player.xv + player.width/6 <= 0)
                        player.x = -player.width/6;
                    if (player.x >= background.width - player.width + player.width/6)
                        player.x = background.width - player.width + player.width/6;
                    }

        }
    }
}
