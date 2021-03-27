#ifndef THEMELIST_H
#define THEMELIST_H

#include <QObject>

class ThemeList : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString background READ background NOTIFY colorChanged)
    Q_PROPERTY(QString background2 READ background2 NOTIFY colorChanged)
    Q_PROPERTY(QString foreground READ foreground NOTIFY colorChanged)
    Q_PROPERTY(QString foreground2 READ foreground2 NOTIFY colorChanged)
    Q_PROPERTY(QString error READ error NOTIFY colorChanged)
    Q_PROPERTY(QString accent READ accent NOTIFY colorChanged)
    Q_PROPERTY(QString accent2 READ accent2 NOTIFY colorChanged)

public:
    explicit ThemeList(QObject *parent = nullptr);

    ~ThemeList();

public slots:

    bool setCurrentTheme(int num);

signals:
    void colorChanged();

private:
    QList<QMap<QString, QString>*> * mList;
    int currentTheme = 0;

    QString returnColor(const QString & color) const;

    QString background() const {return returnColor("background");}
    QString background2() const {return returnColor("background2");}
    QString foreground() const {return returnColor("foreground");}
    QString foreground2() const {return returnColor("foreground2");}
    QString error() const {return returnColor("error");}
    QString accent() const {return returnColor("accent");}
    QString accent2() const {return returnColor("accent2");}

};

#endif // THEMELIST_H
