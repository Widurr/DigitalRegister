#ifndef DATE_H
#define DATE_H

#include <QObject>
#include <QSqlQueryModel>
#include <QDate>
#include <QDateTime>

class Date : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit Date(QObject *parent = nullptr);

    enum class Role{
        IdRole = Qt::UserRole,
        DayRole,
        LStartRole,
        LCountRole,
        ClassIdRole
    };

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

    int closestLesson();
    bool anythingToday();

public slots:
    static int todaysDayOfWeek();
     void todaysLessons();
     void updateModel(int classID);
     int getId(int row) const;
signals:

};

#endif // DATE_H
