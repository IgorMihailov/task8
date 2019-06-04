#ifndef CHECKCOLLISION_H
#define CHECKCOLLISION_H

#include <QObject>
#include <iostream>
#include <string>
#include <cstdio>
#include <fstream>
#include <QFile>
#include <QDebug>
#include <cstdlib>
#include <algorithm>
using namespace std;

class functions : public QObject
{
    Q_OBJECT
public:
    explicit functions(QObject *parent = nullptr);

    Q_INVOKABLE bool check(int plx, int ply, int plh, int plw, int obx, int oby, int obh, int obw);
    Q_INVOKABLE void saveresult(int score, QString name);
    Q_INVOKABLE QString loadresult();
    Q_INVOKABLE void sorting();

signals:

public slots:
};

#endif // CHECKCOLLISION_H
