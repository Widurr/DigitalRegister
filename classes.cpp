#include "classes.h"
#include "database.h"

Classes::Classes(QObject *parent)
    : QSqlQueryModel(parent)
{

}
QVariant Classes::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}
QHash<int, QByteArray> Classes::roleNames() const
{
    QHash<int,QByteArray> names;
    names[(int)Role::IdRole] = "id";
    names[(int)Role::ClassNameRole] = "classname";
    names[(int)Role::LoginIDRole] = "loginID";
    names[(int)Role::GroupIDRole] = "groupID";
    return names;
}

void Classes::updateModel(int loginID)
{
    QString index = QString::number(loginID);
    this->setQuery("SELECT id, " CLASSES_NAME " FROM " CLASSES " WHERE " LOGIN_ID "=" +index );
    qDebug() << "Current classes count: " + QString::number(this->rowCount());
}

int Classes::getId(int row) const
{
    return this->data(this->index(row, 0), (int)Role::IdRole).toInt();
}

QString Classes::getClassName(int row) const
{
    return this->data(this->index(row, 0), (int)Role::ClassNameRole).toString();
}
void Classes::setactiveClassID(int index){
    m_classID = index;
}

