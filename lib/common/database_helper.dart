import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';

class DatabaseHelper{
  static Database _db;
  //记录表
  final String recordtable = 'visitRecordTable';
  final String visitTableColumnId = 'id';
  final String visitTableMainPersonName="mainname"; //主来访人姓名
  final String visitTableMainPersonIDCardNo="idcard";  //身份证号
  final String visitTableMainPersoncellphoneNo="cellphone";//手机号码
  final String visitTablevisitor="visitor";  //拜访对象
  final String visitTablevisitorReason="reason"; //拜访事由
  final String visitTablecarNo="car_no";     //车牌号
  final String visitTableComments="comments";  //备注
  final String visitTablePersonNum="personcount";
  final String visitTablevisitType="type"; //1，现场登记 2.预约访问
  final String visitTabledatetime="updatetime";    //时间
  final String visitAddress = "address";//住址
  final String toBase64 = "base64";//照片base64码

  //详细人员表
  final String visitorsTable='personTable';
  final String visitorsTableID='id';
  final String visitorsTableRecordId='recordid';
  final String visitorsTablename='name';
  final String visitorsTableidcard='idcard';
  final String visitorsTabletel='cellphone';
  final String visitorsTableaddr='company';
  final String visitorsTableIsRecog='recogflag';


  Future<Database> get db async{
    if(_db != null){
      return _db;
    }

    _db = await intDB();
    return _db;
  }


  intDB() async{
    //Directory documentDirectory = await getApplicationDocumentsDirectory();
    Directory documentDirectory = await getExternalStorageDirectory();
    String path = join(documentDirectory.path , 'visitor.db');
    var myOwnDB = await openDatabase(path,version: 1,
        onCreate: _onCreate);
    return myOwnDB;
  }

  //创建表
  void _onCreate(Database db , int newVersion) async{
    var sql = "CREATE TABLE $recordtable ($visitTableColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$visitTableMainPersonName VARCHAR(20), $visitTableMainPersonIDCardNo VARCHAR(18),  "
        "$visitTableMainPersoncellphoneNo VARCHAR(15),$visitTablevisitor VARCHAR(20),"
        " $visitTablevisitorReason VARCHAR(100), $visitAddress VARCHAR(100), $toBase64 mediumtext, $visitTablevisitType INTEGER , "
        "$visitTablecarNo VARCHAR(20), $visitTableComments VARCHAR(100), "
        "$visitTablePersonNum INTEGER,$visitTabledatetime  TIMESTAMP default (datetime('now', 'localtime')))";
    await db.execute(sql);

    var sql2 = "CREATE TABLE $visitorsTable ($visitorsTableID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $visitorsTableRecordId INTEGER ,  $visitorsTablename VARCHAR(20),  $visitorsTableidcard VARCHAR(18),$visitorsTabletel VARCHAR(15) , "
        " $visitorsTableaddr VARCHAR(100) , $visitorsTableIsRecog INTEGER)";
    await db.execute(sql2);

  }

  //增加主记录表数据
  Future<int> saveRecord( MainInfo info) async{
    var dbClient = await  db;
    int result = await dbClient.insert("$recordtable", info.toMap());
    return result;
  }
  //查询主记录表数据
  Future<List<MainInfo>> getAllRecords() async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $recordtable ORDER BY $visitTabledatetime DESC";
    List result = await dbClient.rawQuery(sql);
    List<MainInfo> mainInfolist=new List();
    for(int i=0;i<result.length;i++) {
      MainInfo info=MainInfo.fromMap(result[i]);
      mainInfolist.add(info);
    }
    return mainInfolist;
  }

  Future<int> getCount() async{
    var dbClient = await  db;
    var sql = "SELECT COUNT(*) FROM $recordtable";
    return  Sqflite.firstIntValue(await dbClient.rawQuery(sql)) ;
  }

  //根据日期查询
  Future<List<MainInfo>> getRecordsByTime(String time) async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $recordtable WHERE $visitTabledatetime LIKE '$time%'";
    List result  = await dbClient.rawQuery(sql);
    List<MainInfo> mainInfoList=new List();
    for(int i=0;i<result.length;i++) {
      MainInfo info=MainInfo.fromMap(result[i]);
      mainInfoList.add(info);
    }
    return  mainInfoList; ;
  }

  //根据日期段查询
  Future<List<MainInfo>> getRecordsByTimes(String startTime,String endTime) async{
    var dbClient = await db;
    String end = endTime+" 23:59:59";
    var sql = "SELECT * FROM $recordtable WHERE $visitTabledatetime >= '$startTime' AND $visitTabledatetime <= '$end'";
    List result  = await dbClient.rawQuery(sql);
    List<MainInfo> mainInfoList=new List();
    for(int i=0;i<result.length;i++) {
      MainInfo info=MainInfo.fromMap(result[i]);
      mainInfoList.add(info);
    }
    return  mainInfoList; ;
  }

  //根据主来访人姓名查询
  Future<List<MainInfo>> getRecordsByName(String name) async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $recordtable WHERE $visitTableMainPersonName LIKE '$name%'";
    List result  = await dbClient.rawQuery(sql);
    List<MainInfo> mainInfolist=new List();
    for(int i=0;i<result.length;i++) {
      MainInfo info=MainInfo.fromMap(result[i]);
      mainInfolist.add(info);
    }
    return  mainInfolist; ;
  }

  //根据日期和主来访人姓名查询
  Future<List<MainInfo>> getRecordsByNameAndTime(String name,String time) async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $recordtable WHERE $visitTableMainPersonName LIKE '$name%' AND $visitTabledatetime LIKE '$time%'";
    List result  = await dbClient.rawQuery(sql);
    List<MainInfo> mainInfoList=new List();
    for(int i=0;i<result.length;i++) {
      MainInfo info=MainInfo.fromMap(result[i]);
      mainInfoList.add(info);
    }
    return  mainInfoList; ;
  }

  //清空表数据
  Future deleteRecordsAll() async{
    var dbClient = await  db;
    var sql = "DELETE FROM $recordtable";
    List result  = await dbClient.rawQuery(sql);
    return  result; ;
  }

  //更新主记录表数据
  Future<int> updateRecord(MainInfo info,int id) async{
    var dbClient = await  db;
    return  await dbClient.update(
        recordtable ,info.toMap(), where: "$visitTableColumnId = ?" , whereArgs: [id]
    );
  }
  //删除主记录表数据
  Future<int> deleteRecord(int id) async{
    var dbClient = await  db;
    return  await dbClient.delete(
        recordtable , where: "$visitTableColumnId = ?" , whereArgs: [id]
    );
  }


  //增加人员表数据
  Future<int> savePersonData( Visitorsdb info) async{
    var dbClient = await  db;
    int result = await dbClient.insert("$visitorsTable", info.toMap());
    return result;
  }
  //查询人员表数据
  Future<List<Visitorsdb>> getAllPersonDatas() async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $visitorsTable";
    List result = await dbClient.rawQuery(sql);
    List<Visitorsdb> visitorsdblist=new List();
    for(int i=0;i<result.length;i++)
    {
      Visitorsdb info=Visitorsdb.fromMap(result[i]);
      visitorsdblist.add(info);
    }
    return visitorsdblist;
  }

  Future<int> getPersonCount() async{
    var dbClient = await  db;
    var sql = "SELECT COUNT(*) FROM $visitorsTable";
    return  Sqflite.firstIntValue(await dbClient.rawQuery(sql)) ;
  }

  Future<List<Visitorsdb>> getPersonDataByRecordID(int recordid) async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $visitorsTable WHERE $visitorsTableRecordId = $recordid";
    List result  = await dbClient.rawQuery(sql);
    List<Visitorsdb> visitorsdblist=new List();
    for(int i=0;i<result.length;i++)
    {
      Visitorsdb info=Visitorsdb.fromMap(result[i]);
      visitorsdblist.add(info);
    }
    return visitorsdblist;
  }

  //更新人员表数据
  Future<int> updatePersonData(MainInfo info,int id) async{
    var dbClient = await  db;
    return  await dbClient.update(
        visitorsTable ,info.toMap(), where: "$visitorsTableID = ?" , whereArgs: [id]
    );
  }
  //删除人员表数据
  Future<int> deletePersonData(int id) async{
    var dbClient = await  db;
    return  await dbClient.delete(
        visitorsTable , where: "$visitorsTableID = ?" , whereArgs: [id]
    );
  }


  Future close() async{
    var dbClient = await  db;
    return  await dbClient.close();
  }


}