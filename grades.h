#ifndef GRADES_H
#define GRADES_H

#include <QSqlQueryModel>
#include <QMetaEnum>

class Grades :  public QSqlQueryModel
{
    Q_OBJECT
public:
   explicit Grades(QObject *parent = nullptr);

    enum class Role{
        IdRole = Qt::UserRole,
        TitleRole,
        ValueRole,
        WeightRole,
        DescRole,
        ClassIdRole,
        StudentIdRole
    };
};

#endif // GRADES_H
