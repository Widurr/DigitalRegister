#ifndef CLASSES_H
#define CLASSES_H

#include <QSqlQueryModel>

class Classes : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(int activeClassID READ activeClassID WRITE setactiveClassID NOTIFY activeClassIDChanged)
    
public:
    explicit Classes(QObject *parent = nullptr);

    enum class Role{
        IdRole = Qt::UserRole,
        ClassNameRole,
        LoginIDRole,
        GroupIDRole
    };
     QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

     virtual QHash<int, QByteArray> roleNames() const override;

public slots:
     void updateModel(int loginID);
     int getId(int row) const;
     void setactiveClassID(int index);
     int activeClassID(){
         return m_classID;
     }
     QString getClassName(int row) const;
signals:
     void activeClassIDChanged();
private:
     int m_classID = -1;
};

#endif // CLASSES_H
