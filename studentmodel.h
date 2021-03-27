#pragma once

#include <QSqlQueryModel>


class StudentModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString checked READ checkedList)

public:
    explicit StudentModel(QObject* parent = nullptr);

    enum class Role
    {
        IdRole = Qt::UserRole,
        FNameRole,
        LNameRole,
        PhoneRole,
        AddressRole,
        DescriptionRole,
        LoginIDRole,
        checkedRole
    };

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    QString checkedList() const;

protected:
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateModel(int loginID);
    void updateModel(int loginID, const QString& studentIDs);    // Shows only items which IDs are stored in the string
    int getId(int row) const;
    void uncheckAll();
    void checkAll();
private:
    QVector<int> checked;
    bool isChecked(int index) const;
    void check(int index);
    void uncheck(int index);
    void checkedDebug() const;
};

