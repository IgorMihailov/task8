#include "functions.h"

//Функция вывода таблицы рекордов
QString functions::loadresult()
{
    QFile file("../GAME/leaderboard.txt");
    QString block;
    int i = 0;
    if ((file.exists())&&(file.open(QIODevice::ReadOnly)))
    {
        while(i < 10)
           {
               block = block+file.readLine();
               i++;
           }
    }
    file.close();
    return block;
}
