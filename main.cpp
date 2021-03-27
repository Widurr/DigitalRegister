#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include <studentmodel.h>
#include <groupmodel.h>
#include <account.h>
#include <QQuickView>
#include <classes.h>
#include <date.h>

#include "themelist.h"
#include "database.h"
#include "backend.h"
#include <QIcon>
#include <QThread>


int main(int argc, char *argv[])
{


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<BackEnd>("io.qt.backend",1,0,"BackEnd");
    QGuiApplication app(argc, argv);

    qmlRegisterType<Account>("account", 1, 0, "Account");

    qmlRegisterUncreatableType<ThemeList>("theme_list", 1, 0, "ThemeList", "ThemeList should not be created in QML");

    qmlRegisterType<StudentModel>("student", 1, 0, "StudentModel");
    qmlRegisterType<GroupModel>("groups", 1, 0, "GroupModel");
    qmlRegisterType<DataBase>("database", 1, 0, "DataBase");
    qmlRegisterType<Date>("date", 1, 0, "Date");
    app.setWindowIcon(QIcon("://icon.png"));


    DataBase database;
    database.connectToDataBase();
    StudentModel studentModel;
    Account account;
    GroupModel groupModel;
    ThemeList themeList;
    Classes classes;
    Date dateModel;

    QQmlApplicationEngine engine;


    engine.rootContext()->setContextProperty("database", &database);
    engine.rootContext()->setContextProperty("myModel", &studentModel);
    engine.rootContext()->setContextProperty("theGroupModel", &groupModel);
    engine.rootContext()->setContextProperty("account", &account);
    engine.rootContext()->setContextProperty("themeList", &themeList);
    engine.rootContext()->setContextProperty("classes", &classes);
    engine.rootContext()->setContextProperty("dateModel", &dateModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
