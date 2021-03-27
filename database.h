#ifndef DATABASE_H
#define DATABASE_H

#include "filemanager.h"

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "NameDataBase"
#define DATABASE_NAME       "Name.db"

// Table of students
#define TABLE                   "informacje"
#define TABLE_FIRSTNAME             "firstName"
#define TABLE_LASTNAME               "lastName"
#define TABLE_PHONENUMBER              "phoneNumber"
#define TABLE_ADDRESS                    "address"
#define TABLE_DESCRIPTION               "description"
#define TABLE_ID                    "studentID"

// Table containing account's data
#define LOGIN                      "login"
#define LOGIN_USER                 "username"
#define LOGIN_PASSWORD             "userpassword"
#define LOGIN_ID                    "loginID"

// Table containing data of classes
#define CLASSES                      "classes"
#define CLASSES_NAME                 "classname"
#define CLASSES_ID                   "classID"

// Table containing data of groups
#define GROUPS                     "groups"
#define GROUPS_NAME                "groupName"
#define GROUPS_STUDENTS            "studentIDs"
#define GROUP_ID                    "groupID"

// Table containg data of dates
#define DATES                       "dates"
#define DATES_DAY                   "day"
#define DATES_LSTART                "lessonStart"
#define DATES_LCOUNT                 "lessonCount"

// Table containing data of grades

#define GRADES                      "grades"
#define GRADE_TITLE                 "gradeTitle"
#define GRADE_VALUE                 "gradeValue"
#define GRADE_WEIGHT                "gradeWeight"
#define GRADE_DESCRIPTION           "gradeDesc"

class DataBase : public QObject
{
    Q_OBJECT
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase();
    void connectToDataBase();



    bool exportStudentsToFile(QSqlQuery &query, int querysize, int dataRange, const QString &filename);
private:
    QSqlDatabase    db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();


public slots:
    bool inserIntoStudentTable(const QVariantList &data);      // Adding entries to the table
    bool inserIntoLoginTable(const QVariantList &data);
    bool inserIntoGroupTable(const QVariantList &data);
    bool inserIntoClassTable(const QVariantList &data);
    bool inserIntoDateTable(const QVariantList &data);
    bool inserIntoDateTable(const int &day, const QString &lStart, const int &lCount, const int &classID);
    bool inserIntoGroupTable(const QString &groupName, const QString &studentIDs, const int &loginID);
    bool inserIntoTable(const QString &firstName, const QString &lastName, const QString &phoneNumber, const int &loginID); // student
    bool inserIntoTable(const QString &username, const QString &userpassword);  // login
    bool inserIntoClassTable(const QString &className, const int &loginID, const int &groupID);
    bool removeRecord(const int id); // Removing records from the table on its id
    bool  dbIsEmpty();
    bool removeRecordGr(const int id);

    bool importStudentsFromFile(int loginID, const QString & filename);
    bool exportStudentsToFile(int loginID, const QString & filename);
    bool exportStudentsToFile(int loginID, const QString & filename, const QString & studentIDs);
};

#endif // DATABASE_H
