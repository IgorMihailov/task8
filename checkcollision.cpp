#include "functions.h"
functions::functions(QObject *parent) : QObject(parent)
{

}

//Функция проверки коллизии с объектами
bool functions::check(int plx, int ply, int plh, int plw, int obx, int oby, int obh, int obw)
{
    if (oby + obh < ply + plh &&
            oby + obw > ply &&
            plx < obx + obw &&
            plx > obx - plw)
        return true;
    return false;
}
