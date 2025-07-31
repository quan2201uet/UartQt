#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "datamanager.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    qmlRegisterType<DataManager>("com.example.backend", 1, 0, "DataSerialManager");
    DataManager dataManager;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dataManager", &dataManager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
