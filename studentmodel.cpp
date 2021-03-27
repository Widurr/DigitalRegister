#include "studentmodel.h"
#include "database.h"

#include <QSqlQueryModel>

StudentModel::StudentModel(QObject *parent)
    : QSqlQueryModel(parent)
{
    this->updateModel(1);
}


QVariant StudentModel::data(const QModelIndex& index, int role) const
{
    if(role == (int)Role::checkedRole)
    {
        return QVariant(isChecked(index.row()));
    }

    int columnId = role - Qt::UserRole;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

bool StudentModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(role == (int)Role::checkedRole)
    {
        if(value.toBool() && !isChecked(index.row()))
        {
            check(index.row());
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
        else if(isChecked(index.row()))
        {
            uncheck(index.row());
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
    }
    return false;
}

QString StudentModel::checkedList() const
{
    QString str;
    for(auto& i : checked)
    {
        str += QString::number(i);
        str += ',';
    }
    return str;
}

QHash<int,QByteArray> StudentModel::roleNames() const{
    QHash<int,QByteArray> roles;
    roles[(int)Role::IdRole] = "id";
    roles[(int)Role::FNameRole] = "fname";
    roles[(int)Role::LNameRole] = "lname";
    roles[(int)Role::PhoneRole] = "phone";
    roles[(int)Role::AddressRole] = "address";
    roles[(int)Role::DescriptionRole] = "description";
    roles[(int)Role::LoginIDRole] = "loginID";
    roles[(int)Role::checkedRole] = "checkedRole";
    return roles;
}



void StudentModel::updateModel(int loginID)
{
    QString index = QString::number(loginID);
    this->setQuery("SELECT id, " TABLE_FIRSTNAME ", " TABLE_LASTNAME ", " TABLE_PHONENUMBER " FROM " TABLE " WHERE " LOGIN_ID "=" +index );
}

void StudentModel::updateModel(int loginID, const QString &studentIDs)   // funkcja uaktualnia model, aby wyświetlał tylko rekordy zgodne z id zawartym w stringu
{
    QString index = QString::number(loginID);
    QString strWhere = " WHERE id IN (" + studentIDs.left(studentIDs.length()-1) + ")";
    strWhere += "AND " LOGIN_ID "=" + index;
    qDebug() << strWhere;
    this->setQuery("SELECT id, " TABLE_FIRSTNAME ", " TABLE_LASTNAME ", " TABLE_PHONENUMBER " FROM " TABLE + strWhere);
}

int StudentModel::getId(int row) const
{
    return this->data(this->index(row, 0), (int)Role::IdRole).toInt();
}


void StudentModel::uncheckAll()
{
    checkedDebug();
    int size = this->rowCount();
    for(int i = 0; i < size; i++)
    {
        setData(this->index(i, 0), QVariant(false), (int)Role::checkedRole);
    }
    checkedDebug();
    //emit dataChanged(this->index(0, 0), this->index(this->rowCount(), 0), QVector<int>() << (int)Role::checkedRole);
}

void StudentModel::checkAll()
{
    //beginResetModel();
    checkedDebug();
    int size = this->rowCount();
    for(int i = 0; i < size; i++)
    {
        setData(this->index(i, 0), QVariant(true), (int)Role::checkedRole);
    }
    checkedDebug();
    //endResetModel();
    //emit dataChanged(this->index(0, 0), this->index(this->rowCount(), 0), QVector<int>() << (int)Role::checkedRole);
}

bool StudentModel::isChecked(int row) const
{
    int id = this->getId(row);
    return checked.contains(id);
}
void StudentModel::check(int row)
{
    int id = this->getId(row);
    checked.append(id);
    emit dataChanged(this->index(row, 0), this->index(row, 0), QVector<int>() << (int)Role::checkedRole);
}
void StudentModel::uncheck(int row)
{
    int id = this->getId(row);
    for(int i = 0; i < checked.length(); i++)
    {
        if(checked[i] == id)
        {
            checked.remove(i);
            break;
        }
    }
    emit dataChanged(this->index(row, 0), this->index(row, 0), QVector<int>() << (int)Role::checkedRole);
}

void StudentModel::checkedDebug() const
{
    QString str = "Length: ";
    str += QString::number(checked.length());
    str += " IDs = ";
    for(auto& i : checked)
    {
        str += QString::number(i);
        str += ", ";
    }
    qDebug() << str.left(str.length()-2);
}

