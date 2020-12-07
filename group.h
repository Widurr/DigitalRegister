#ifndef GROUP_H
#define GROUP_H

#include <QObject>
#include <QVector>

class Group
{
public:
    Group();
    //Group(const Group& other);

    QString groupName;
    int ID() const {return id;}

    void setStudentIDs(const QVector<int>& students);
    QString getStudentIDs() const;

    static QString vectorToString(const QVector<int>& students);
private:
    QString studentIDs;
    static int getCurrentID();

    int id;

    static QVector<int> stringToVector(const QString& str);

};

#endif // GROUP_H
