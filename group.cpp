#include "group.h"

Group::Group()
{
    id = getCurrentID();
}

void Group::setStudentIDs(const QVector<int>& students)
{
    studentIDs = Group::vectorToString(students);
}

QString Group::getStudentIDs() const
{
    return studentIDs;
}

int Group::getCurrentID()
{
    static int i = 0;
    ++i;
    return i;
}

QVector<int> Group::stringToVector(const QString& str)
{
    QVector<int> vec;
    const auto& arr = str.split(",");
    for(auto& i : arr)
    {
        vec.append(i.toInt());
    }
    return vec;
}

QString Group::vectorToString(const QVector<int>& students)
{
    QString str;
    for(auto& i : students)
    {
        str += QString::number(i);
        str += ',';
    }
    return str;
}
