#!/bin/bash

#保存备份个数，备份31天数据
number=31
#备份保存路径
backup_dir=/root/backup-db
#日期
dd=`date +%Y-%m-%d_%H:%M:%S`
#备份工具
tool=mysqldump
#用户名
username=root
#密码
password=123456
#将要备份的数据库
database_name="--all-databases mysql wordpress alistdb"

for db in $database_name
do

#如果是 "--all-databases"，则更改为 "alldb"
folder=$db
if [ "$db" == "--all-databases" ]
then
    folder="alldb"
fi

#如果文件夹不存在则创建
if [ ! -d $backup_dir/$folder ];
then
    mkdir -p $backup_dir/$folder;
fi

#简单写法 mysqldump -u root -p123456 users > /root/mysqlbackup/users-$filename.sql
$tool -u $username -p$password $db | gzip > $backup_dir/$folder/$folder-$dd.sql.gz

#写创建备份日志
echo "create $backup_dir/$folder/$folder-$dd.dupm" >> $backup_dir/log.txt

#找出需要删除的备份
delfile=`ls -l -crt $backup_dir/$folder/*.gz | awk '{print \$9 }' | head -1`
#判断现在的备份数量是否大于$number
count=`ls -l -crt $backup_dir/$folder/*.gz | awk '{print \$9 }' | wc -l`
if [ $count -gt $number ]
then
  #删除最早生成的备份，只保留number数量的备份
  rm $delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/log.txt
fi
done
