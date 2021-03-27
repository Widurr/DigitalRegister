#include "groupmodel.h"
#include "database.h"

GroupModel::GroupModel(QObject *parent)
    : QSqlQueryModel(parent)
{
    this->updateModel(1);
}


QVariant GroupModel::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> GroupModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names[(int)Role::IdRole] = "id";
    names[(int)Role::nameRole] = "groupName";
    names[(int)Role::studentIDsRole] = "studentIDs";
    return names;
}

void GroupModel::updateModel(int loginID)
{
    QString index = QString::number(loginID);
    this->setQuery("SELECT id, " GROUPS_NAME ", " GROUPS_STUDENTS " FROM " GROUPS " WHERE " LOGIN_ID "=" +index );
    qDebug() << "Current groups count: " + QString::number(this->rowCount());
}

int GroupModel::getId(int row) const
{
    return this->data(this->index(row, 0), (int)Role::IdRole).toInt();
}

QString GroupModel::getStudentIDs(int row) const
{
    return this->data(this->index(row, 0), (int)Role::studentIDsRole).toString();
}

QString GroupModel::getGroupName(int row) const
{
    return this->data(this->index(row, 0), (int)Role::nameRole).toString();
}
int GroupModel::getterId(QString groupName) const{
    QSqlQuery query;
    query.prepare("SELECT id FROM " GROUPS " WHERE " GROUPS_NAME"=:NAME");
    query.bindValue(":NAME", groupName);
    query.exec();
    query.next();
    int id = query.value(0).toInt();

    return id;
}
