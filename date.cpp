#include "date.h"
#include "database.h"

Date::Date(QObject *parent)
    : QSqlQueryModel(parent)
{
}

    QVariant Date::data(const QModelIndex& index, int role) const
    {
        int columnId = role - Qt::UserRole;
        QModelIndex modelIndex = this->index(index.row(), columnId);
        return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }

    QHash<int,QByteArray> Date::roleNames() const{
        QHash<int,QByteArray> roles;
        roles[(int)Role::IdRole] = "id";
        roles[(int)Role::DayRole] = "day";
        roles[(int)Role::LStartRole] = "lessonStart";
        roles[(int)Role::LCountRole] = "lessonCount";
        roles[(int)Role::ClassIdRole] = "classID";
        return roles;
    }
    void Date::updateModel(int loginID)
    {
       QString index = QString::number(loginID);
       this->setQuery("SELECT id, " DATES_DAY ", " DATES_LSTART ", " DATES_LCOUNT " FROM " DATES " WHERE " LOGIN_ID "=" +index );
    }

    int Date::getId(int row) const
    {
        return this->data(this->index(row, 0), (int)Role::IdRole).toInt();
    }
    int Date::todaysDayOfWeek(){
     QDateTime date;
     QDate day = date.currentDateTime().date();
     int today = day.dayOfWeek();
     qDebug() << today;
     return today;
     }
    void Date::todaysLessons(){
        qDebug() << "działam!";
        int day = Date::todaysDayOfWeek();
        QSqlQuery query;
        query.prepare("SELECT " CLASSES_ID " FROM " DATES "WHERE " DATES_DAY "=" +(QString)(day-1)+ " ORDER BY " DATES_LSTART );
        query.exec();
       while(query.next()){
            int index = query.value(0).toInt();
            QSqlQuery findClasses;
            findClasses.prepare("SELECT " CLASSES_NAME " FROM " CLASSES " WHERE " CLASSES_ID "="+(QString)index);
            findClasses.exec();
            findClasses.next();
            QString name = findClasses.value(0).toString();
            qDebug() << name;
        }
    }
