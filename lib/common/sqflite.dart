import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlFite{
  static String _data = "暂无数据";
  ///创建数据库db
  static createDb(String dbName,int vers,String dbTables) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径：$path数据库版本$vers");
    //打开数据库
    await openDatabase(
        path,
        version:vers,
        onUpgrade: (Database db, int oldVersion, int newVersion) async{
          //数据库升级,只回调一次
          print("数据库需要升级！旧版：$oldVersion,新版：$newVersion");
        },
        onCreate: (Database db, int vers) async{
          //创建表，只回调一次
          await db.execute(dbTables);
          await db.close();

        }
    );
    _data = "成功创建数据库db！\n数据库路径: $path \n数据库版本$vers";
  }


  ///增
  static add(String dbName,String sql) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径：$path");

    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();

    _data = "插入数据成功！";
  }


  ///删
  static delete(String dbName,String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawDelete(sql);
    await db.close();
    if (count > 0) {
      _data = "执行删除操作完成，该sql删除条件下的数目为：$count";
    } else {
      _data = "无法执行删除操作，该sql删除条件下的数目为：$count";
    }
  }

  ///改
  static update(String dbName,String sql,List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql,arg);//修改条件，对应参数值
    await db.close();
    if (count > 0) {
      _data = "更新数据库操作完成，该sql删除条件下的数目为：$count";
    } else {
      _data = "无法更新数据库，该sql删除条件下的数目为：$count";
    }
  }


  ///查条数
  static getQueryNum(String dbName,String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = Sqflite.firstIntValue(await db.rawQuery(sql));
    await db.close();
    return count;
  }

  ///查全部
  static query(String dbName,String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    List<Map> list = await db.rawQuery(sql);
    await db.close();
    _data = "数据详情：$list";
  }
}
