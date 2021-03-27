#include "themelist.h"

#include <QMap>
#include <QDebug>

ThemeList::ThemeList(QObject *parent) : QObject(parent)
{
    // creating the list
    mList = new QList<QMap<QString, QString>*>();
    
    // dark blue
    QMap<QString, QString>* qmap = new QMap<QString, QString>();
    (*qmap)["background"] = "#1e1e1e";
    (*qmap)["background2"] = "#131845";
    (*qmap)["foreground"] = "#cccccc";
    (*qmap)["foreground2"] = "#1e1e1e";
    (*qmap)["error"] = "#f22222";
    (*qmap)["accent"] = "#009dff";
    (*qmap)["accent2"] = "#1036a0";

    mList->append(qmap);

    // light blue
    qmap = new QMap<QString, QString>();
    (*qmap)["background"] = "#e0e0e0";
    (*qmap)["background2"] = "#cccccc";
    (*qmap)["foreground"] = "#222222";
    (*qmap)["foreground2"] = "#cccccc";
    (*qmap)["error"] = "#f22222";
    (*qmap)["accent"] = "#1036a0";
    (*qmap)["accent2"] = "#009dff";

    mList->append(qmap);
}

ThemeList::~ThemeList()
{
    qDeleteAll(*mList);
    mList->clear();
    delete mList;
}

bool ThemeList::setCurrentTheme(int num)
{
    if(num < 0)
    {
        qDebug() << "No such theme - num is lower than zero";
        return false;
    }
    if(num >= mList->length())
    {
        qDebug() << "No such theme - num is higher than the number of themes";
        return false;
    } else
    {
        currentTheme = num;
        colorChanged();
        return true;
    }
}

QString ThemeList::returnColor(const QString &color) const
{
    return (*(*mList)[currentTheme])[color];
}

