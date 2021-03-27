#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT
public:
    FileManager(QObject *parent = nullptr);

private:
    const QString header = "First Name; Last Name; Phone Number; Address; Description";

public:
    QList<QStringList> * importStudentsFromFile(const QString & filename);
    bool exportStudentsToFile(const QString & filename, const QList<QStringList> & data);
    bool debugWriteToFile(const QStringList &list);
private:
};

#endif // FILEMANAGER_H
