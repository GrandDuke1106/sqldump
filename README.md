# sqldump
一个sh脚本，指定数据库以及全部数据库并分文件夹备份。用于mysql以及mariadb

---

可以自行修改以下变量，sh文件中也有详细注释，可以自行修改。

```bash
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
```

如果想修改全部数据库的备份名称，可以自行修改25行中的``alldb``。

```bash
#如果是 "--all-databases"，则更改为 "alldb"
folder=$db
if [ "$db" == "--all-databases" ]
then
    folder="alldb"
fi
```