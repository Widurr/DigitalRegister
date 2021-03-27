#ifndef GROUPMODEL_H
#define GROUPMODEL_H

#include <QSqlQueryModel>

class GroupModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit GroupModel(QObject *parent = nullptr);

    enum class Role
    {
        IdRole = Qt::UserRole,
        nameRole,
        studentIDsRole
    };

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateModel(int loginID);
    int getId(int row) const;
    int getterId(QString groupName) const;
    QString getStudentIDs(int row) const;
    QString getGroupName(int row) const;

};

#endif // GROUPMODEL_H
