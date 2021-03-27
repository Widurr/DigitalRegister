#include "filemanager.h"
#include <QFile>

#include <QDebug>
#include <QTextCodec>

FileManager::FileManager(QObject *parent)
    :QObject(parent)
{

}


QList<QStringList> * FileManager::importStudentsFromFile(const QString & filename)
{
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));

    // removing "file:///" from the begining of the name, because it is added if it was an url
    QString fn = filename;
    if(filename.startsWith("file:///"))
        fn = filename.right(filename.length()-8);

    // Opening the file
    QFile file(fn);
    if (!file.exists())
    {
        qDebug() << "File " << fn << " not found";
        return nullptr;
    }
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "File " << fn << " could not be opened";
        return nullptr;
    }

    QList<QStringList> * listlist = new QList<QStringList>(); // creating the list that will be returned

    QTextStream in(&file);
    //in.setCodec("UTF-8");
    QString line;
    QStringList list;
    while (!in.atEnd())
    {
        line = in.readLine();

        // Processing the line
        list = line.split(QRegExp("[,;\t] ?"));       // 0 - fName; 1 - lName; 2 - phoneNumber; 3 - address; 4 - description;
        listlist->append(list);

    }
    file.close();

    return listlist;
}

bool FileManager::exportStudentsToFile(const QString &filename, const QList<QStringList> & data)
{
    // removing "file:///" from the begining of the name, because it is added if it was an url
    QString fn = filename;
    if(filename.startsWith("file:///"))
        fn = filename.right(filename.length()-8);

    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));   // it's necessary in order to have any special characters
    // opening the file
    QFile file(fn);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << "File " << fn << " could not be opened";
        return false;
    }

    // writing to file
    QTextStream out(&file);
    QString temp;
    for(int i = 0; i < data.length(); i++)
    {
        temp = "";
        for(int j = 0; j < data[i].length(); j++)
        {
            temp += data[i][j] + ',';
        }

        out <<temp << '\n';
    }
    file.close();

    return true;
}

bool FileManager::debugWriteToFile(const QStringList &list)
{
    QFile file("C:\\example\\debugTest.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QTextStream out(&file);
    for(auto & i : list)
    {
        out << i;
    }
    return true;
}
