#include "functions.h"

//Функция сохранения таблицы рекордов
void functions::saveresult(int score, QString name)
{
    QFile file("../GAME/leaderboard.txt");

    // Если файл успешно открыт для записи в текстовом режиме
    if(file.open(QIODevice::Append | QIODevice::Text))
        {
            QTextStream writeStream(&file);
            writeStream << score <<" "<< name << endl;
            file.close();
        }

}
