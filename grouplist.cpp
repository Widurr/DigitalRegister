#include "grouplist.h"
#include "group.h"
#include <QDebug>

GroupList::GroupList(QObject *parent) : QObject(parent)
{
}

QVector<Group> GroupList::items() const
{
    return mItems;
}

bool GroupList::setItemAt(int index, const Group& item)
{
    if(index < 0 || index >= mItems.size())
        return false;

    const Group& oldItem = mItems.at(index);
    if (item.ID() == oldItem.ID() || item.groupName == oldItem.groupName)
        return false;

    mItems[index] = item;
    return true;
}

void GroupList::appendItem()
{
    emit preItemAppended();

    Group item;
    mItems.append(item);

    emit postItemAppended();
}

void GroupList::appendItem(QString name, QVector<int> students)
{
    emit preItemAppended();

    Group item;
    item.setStudentIDs(students);
    //qDebug() << Group::vectorToString(item.getStudentIDs());
    item.groupName = name;
    mItems.append(item);

    emit postItemAppended();
}

void GroupList::removeItem(int index)
{
    if(index < 0 || index >= mItems.size())
        return;

    emit preItemRemoved(index);

    mItems.removeAt(index);

    emit postItemRemoved();
}
