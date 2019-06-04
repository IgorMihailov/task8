#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "functions.h"


int main(int argc, char *argv[])
{
    functions col;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    engine.rootContext() -> setContextProperty("col", &col);


    return app.exec();
}
