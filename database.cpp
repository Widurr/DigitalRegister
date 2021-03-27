#include "database.h"
#include "studentmodel.h"
#include <QSqlQueryModel>
#include <QSqlRecord>

DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

DataBase::~DataBase()
{

}

void DataBase::connectToDataBase()
{
    if(!QFile("C:/example/" DATABASE_NAME).exists()){
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}
bool DataBase::restoreDataBase()
{
    if(this->openDataBase()){
        return this->createTable();
    }
    else
    {
        qDebug() << "Failed to restore the database";
        return false;
    }
    return false;
}

bool DataBase::openDataBase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE"); //
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName("C:/example/" DATABASE_NAME);
    return db.open();
}

void DataBase::closeDataBase()
{
    db.close();
}

bool DataBase::createTable()
{
    QSqlQuery query;
    // creating Login table
    if(!query.exec(  "CREATE TABLE " LOGIN " ("
                     "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                     LOGIN_USER    " VARCHAR(255)    NOT NULL,"
                     LOGIN_PASSWORD     " VARCHAR(255)    NOT NULL"
                 " )")){
        qDebug() << "DataBase: error of create " << LOGIN;
        qDebug() << query.lastError().text();
        return false;
    }
    // creating Students tabble
    else if(!query.exec("CREATE TABLE " TABLE " ("
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                        TABLE_FIRSTNAME     " VARCHAR(255)    NOT NULL,"
                        TABLE_LASTNAME     " VARCHAR(255)    NOT NULL,"
                        TABLE_PHONENUMBER       " VARCHAR(255)    NOT NULL,"
                        TABLE_ADDRESS            " VARCHAR(255),"
                        TABLE_DESCRIPTION       " VARCHAR(255),"
                        LOGIN_ID " INTEGER,"
                        "FOREIGN KEY (" LOGIN_ID ") REFERENCES " LOGIN "(id)"
                    " )") ){
                               qDebug() << "DataBase: error of create " << TABLE;
                               qDebug() << query.lastError().text();
                               return false;
    }
    // creating Classes table
   else if(!query.exec("CREATE TABLE " CLASSES " ("
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                        CLASSES_NAME     " VARCHAR(255)    NOT NULL, "
                        LOGIN_ID " INTEGER, "
                        GROUP_ID " INTEGER, "
                        "FOREIGN KEY (" LOGIN_ID ") REFERENCES " LOGIN "(id), "
                        "FOREIGN KEY (" GROUP_ID ") REFERENCES " GROUPS "(id)"
                        " )")){
        qDebug() << "DataBase: error of create " << CLASSES;
        qDebug() << query.lastError().text();
        return false;
    }
    // creating Groups table
    else if(!query.exec("CREATE TABLE " GROUPS " ("
                         "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                         GROUPS_NAME     " VARCHAR(255)    NOT NULL,"
                         GROUPS_STUDENTS     " VARCHAR(255)    NOT NULL,"
                         LOGIN_ID " INTEGER,"
                         "FOREIGN KEY (" LOGIN_ID ") REFERENCES " LOGIN "(id)"
                    " )"))
     {
         qDebug() << "DataBase: error of create " << GROUPS;
         qDebug() << query.lastError().text();
         return false;
     }
    //creating Dates table
    else if(!query.exec("CREATE TABLE " DATES " ("                      // FIXME: Check if that's correct format for it
                         "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                         DATES_DAY     " INTEGER    NOT NULL,"
                         DATES_LSTART     " VARCHAR(255)    NOT NULL,"
                         DATES_LCOUNT    " INTEGER    NOT NULL,"
                         CLASSES_ID " INTEGER,"
                         "FOREIGN KEY (" CLASSES_ID ") REFERENCES " CLASSES "(id)"
                    " )"))
     {
         qDebug() << "DataBase: error of create " << DATES;
         qDebug() << query.lastError().text();
         return false;
     }
    //creating Grades table
   else if(!query.exec("CREATE TABLE " GRADES " ("                      // FIXME: Check if that's correct format for it
                         "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                         GRADE_TITLE    " VARCHAR(255)    NOT NULL,"
                         GRADE_VALUE     " VARCHAR(255)    NOT NULL,"
                         GRADE_WEIGHT     " VARCHAR(255)    NOT NULL,"
                         GRADE_DESCRIPTION     " VARCHAR(255) ,"
                         CLASSES_ID " INTEGER,"
                         TABLE_ID " INTEGER,"
                         "FOREIGN KEY (" CLASSES_ID ") REFERENCES " CLASSES "(id), "
                        "FOREIGN KEY (" TABLE_ID ") REFERENCES " TABLE "(id)"
                    " )"))
     {
         qDebug() << "DataBase: error of create " << GRADES;
         qDebug() << query.lastError().text();
         return false;
     }
    return true;
}

bool DataBase::inserIntoStudentTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLE " ( " TABLE_FIRSTNAME ", "
                                             TABLE_LASTNAME ", "
                                             TABLE_PHONENUMBER", "
                                             LOGIN_ID   " ) "
                  "VALUES (:firstName, :lastName, :phoneNumber, :loginID)");

    query.bindValue(":firstName",       data[0].toString());
    query.bindValue(":lastName",       data[1].toString());
    query.bindValue(":phoneNumber",         data[2].toString());
    query.bindValue(":loginID",             data[3].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}
bool DataBase::inserIntoLoginTable(const QVariantList &data){
    QSqlQuery query;
    query.prepare("INSERT INTO " LOGIN" ( " LOGIN_USER ", "
                                            LOGIN_PASSWORD" )"
                   "VALUES (:username, :userpassword)");
    query.bindValue(":username", data[0].toString());
    query.bindValue(":userpassword", data[1].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << LOGIN;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}

bool DataBase::inserIntoGroupTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " GROUPS " ( " GROUPS_NAME ", "
                                             GROUPS_STUDENTS ", "
                                             LOGIN_ID   " ) "
                  "VALUES (:groupName, :students, :loginID)");

    query.bindValue(":groupName",       data[0].toString());
    query.bindValue(":students",       data[1].toString());
    query.bindValue(":loginID",             data[2].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << GROUPS;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}
bool DataBase::inserIntoDateTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " DATES " ( " DATES_DAY ", "
                                             DATES_LSTART ", "
                                             DATES_LCOUNT", "
                                             CLASSES_ID   " ) "
                  "VALUES (:day, :lessonStart, :lessonCount, :classID)");

    query.bindValue(":day",       data[0].toString());
    query.bindValue(":lessonStart",       data[1].toString());
    query.bindValue(":lessonCount",         data[2].toString());
    query.bindValue(":classID",             data[3].toString());

    if(!query.exec()){
        qDebug() << "error insert into " << DATES;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}
bool DataBase::inserIntoClassTable(const QVariantList &data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " CLASSES " ( " CLASSES_NAME ", "
                                             LOGIN_ID ", "
                                             GROUP_ID " ) "
                  "VALUES (:classname, :loginID, :groupID)");

    query.bindValue(":classname",       data[0].toString());
    query.bindValue(":loginID",       data[1].toString());
    query.bindValue(":groupID",         data[2].toString());
    if(!query.exec()){
        qDebug() << "error insert into " << CLASSES;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;

}

bool DataBase::inserIntoGroupTable(const QString &groupName, const QString &studentIDs, const int &loginID)
{
    QVariantList data;
    data.append(groupName);
    data.append(studentIDs);
    data.append(loginID);

    return inserIntoGroupTable(data);
}

bool DataBase::inserIntoTable(const QString &firstName, const QString &lastName, const QString &phoneNumber,const int &loginID)
{
    QVariantList data;
    data.append(firstName);
    data.append(lastName);
    data.append(phoneNumber);
    data.append(loginID);

    return inserIntoStudentTable(data);
}
bool DataBase::inserIntoDateTable(const int &day, const QString &lStart, const int &lCount, const int &classID)
{
    QVariantList data;
    data.append(day);
    data.append(lStart);
    data.append(lCount);
    data.append(classID);

    return inserIntoDateTable(data);
}
bool DataBase::inserIntoClassTable(const QString &className, const int &loginID, const int &groupID){
    QVariantList data;
    data.append(className);
    data.append(loginID);
    data.append(groupID);

    return inserIntoClassTable(data);
}

bool DataBase::inserIntoTable(const QString &username, const QString &userpassword){
    QVariantList data;
    data.append(username);
    data.append(userpassword);

    return inserIntoLoginTable(data);
}

bool DataBase::removeRecord(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}
bool DataBase::removeRecordGr(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " GROUPS " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }
    else return true;
}
bool DataBase::dbIsEmpty(){
    int num;
    QSqlQuery query("SELECT(SELECT COUNT(*) FROM " TABLE") AS COUNT");
    query.next();
    num = query.value(0).toInt();
    qDebug() << num;

    return num == 0;
}

bool DataBase::importStudentsFromFile(int loginID, const QString &filename)
{
    FileManager fm;
    QList<QStringList> * listlist = fm.importStudentsFromFile(filename);

    if (listlist == nullptr)
    {
        qDebug() << "FileManager could not instert data into database - listlist is a nullptr";
        return false;
    }

    for(auto& list : *listlist)
    {
        if(!this->inserIntoTable(list[0], list[1], list[2], loginID))       // 0 - fName; 1 - lName; 2 - phoneNumber; 3 - address; 4 - description;
        {
            qDebug() << "FileManager could not instert data into database";
            delete listlist;
            return false;
        }
    }
    delete listlist;
    return true;
}

bool DataBase::exportStudentsToFile(int loginID, const QString &filename)
{
    // getting the query we'll be using to extract data
    QString index = QString::number(loginID);
    QSqlQuery query("SELECT " TABLE_FIRSTNAME ", " TABLE_LASTNAME ", " TABLE_PHONENUMBER " FROM " TABLE " WHERE " LOGIN_ID "=" +index );

    // query.size() returns -1 so we have to find it another way
    QSqlQuery qsize("SELECT(SELECT COUNT(*) FROM " TABLE " WHERE " LOGIN_ID "=" + index + ") AS COUNT");
    qsize.next();
    int size = qsize.value(0).toInt();

    int dataRange = 3; // Number of columns read, in this case it's TABLE_FIRSTNAME, TABLE_LASTNAME, TABLE_PHONENUMBER, so it equals 3

    return exportStudentsToFile(query, size, dataRange, filename);
}

bool DataBase::exportStudentsToFile(int loginID, const QString &filename, const QString &studentIDs)
{
    // Getting the WHERE statement ready
    QString index = QString::number(loginID);
    QString strWhere = " WHERE id IN (" + studentIDs.left(studentIDs.length()-1) + ")";
    strWhere += "AND " LOGIN_ID "=" + index;
    qDebug() << strWhere;

    // creating a query
    QSqlQuery query("SELECT id, " TABLE_FIRSTNAME ", " TABLE_LASTNAME ", " TABLE_PHONENUMBER " FROM " TABLE + strWhere);
    int dataRange = 3; // Number of columns read, in this case it's TABLE_FIRSTNAME, TABLE_LASTNAME, TABLE_PHONENUMBER, so it equals 3

    // query.size() returns -1 so we have to find it another way
    QSqlQuery qsize("SELECT(SELECT COUNT(*) FROM " TABLE +strWhere + ") AS COUNT");
    qsize.next();
    int size = qsize.value(0).toInt();

    return exportStudentsToFile(query, size, dataRange, filename);
}

bool DataBase::exportStudentsToFile(QSqlQuery &query, int querysize, int dataRange, const QString &filename)
{
    // creating the list
    QList<QStringList> data;
    QStringList list;

    // saving data to the list
    for(int i = 0; i < querysize; i++)
    {
        query.next();
        for(int j = 0; j < dataRange; j++)
        {
            list.append(query.value(j).toString());
        }
        data.append(list);
        list.clear();
    }

    // saving to file (finally)
    FileManager fm;
    if(fm.exportStudentsToFile(filename, data))
        return true;

    qDebug() << "Could not export students to file";
    return false;
}
