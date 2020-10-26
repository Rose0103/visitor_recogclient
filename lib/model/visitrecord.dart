import 'VisitorsModel.dart';
import 'RecordInfo.dart';

class MainInfo{

  int visitTableColumnId ;
  String visitTableMainPersonName; //主来访人姓名
  String visitTableMainPersonIDCardNo;  //身份证号
  String visitTableMainPersoncellphoneNo;//手机号码
  String visitTablevisitor;  //拜访对象
  String visitTablevisitorReason; //拜访事由
  String visitTablecarNo;     //车牌号
  String visitTableComments;  //备注
  int visitTablePersonNum;   //同行人数
  int visitTablevisitType; //1，现场登记 2.预约访问,3.现场登记(手机)
  String visitTabledatetime;    //时间
  String visitAddress;//住址
  String toBase64;//照片base64码

  MainInfo(this.visitTableMainPersonName,this.visitTableMainPersonIDCardNo,this.visitAddress,this.toBase64,
      this.visitTableMainPersoncellphoneNo,this.visitTablevisitor,this.visitTablevisitorReason,
      this.visitTablevisitType,this.visitTablecarNo,this.visitTableComments,this.visitTablePersonNum,
      this.visitTabledatetime );
  MainInfo.map(dynamic obj){
    //this.visitTableColumnId = obj['id'];
    this.visitTableMainPersonName = obj['mainname'];
    this.visitTableMainPersonIDCardNo = obj['idcard'];
    this.visitTableMainPersoncellphoneNo = obj['cellphone'];
    this.visitTablevisitor = obj['visitor'];
    this.visitTablevisitorReason = obj['reason'];
    this.visitAddress = obj['address'];
    this.toBase64 = obj['base64'];
    this.visitTablevisitType = obj['type'];
    this.visitTablecarNo= obj['car_no'];
    this.visitTableComments =obj['comments'];
    this.visitTablePersonNum=obj['personcount'];
    this.visitTabledatetime = obj['updatetime'];
  }

 // int get _visitTableColumnId =>visitTableColumnId;
  String get _visitTableMainPersonName=>visitTableMainPersonName;
  String get _visitTableMainPersonIDCardNo=>visitTableMainPersonIDCardNo;
  String get _visitTableMainPersoncellphoneNo=>visitTableMainPersoncellphoneNo;
  String get _visitTablevisitor=>visitTablevisitor;
  String get _visitTablevisitorReason=>visitTablevisitorReason;
  int get _visitTablevisitType=>visitTablevisitType;
  String get _visitTablecarNo=>visitTablecarNo;
  String get _visitTableComments=>visitTableComments;
  int get _visitTablePersonNum=>visitTablePersonNum;
  String get _visitTabledatetime=>visitTabledatetime;
  String get _visitAddress=>visitAddress;
  String get _toBase64=>toBase64;

  Map<String , dynamic> toMap(){
    var map = new Map<String , dynamic>();
   // map['id'] = _visitTableColumnId;
    map['mainname'] = _visitTableMainPersonName;
    map['idcard'] = _visitTableMainPersonIDCardNo;
    map['cellphone'] = _visitTableMainPersoncellphoneNo;
    map['visitor'] = _visitTablevisitor;
    map['reason'] = _visitTablevisitorReason;
    map['type'] = _visitTablevisitType;
    map['car_no']=_visitTablecarNo;
    map['comments']=_visitTableComments;
    map['personcount']=_visitTablePersonNum;
    map['updatetime'] = _visitTabledatetime;
    map['address'] = _visitAddress;
    map['base64'] = _toBase64;
    return map;
  }

  MainInfo.fromMap(Map<String , dynamic>map){
    this.visitTableColumnId = map['id'];
    this.visitTableMainPersonName = map['mainname'];
    this.visitTableMainPersonIDCardNo = map['idcard'];
    this.visitTableMainPersoncellphoneNo = map['cellphone'];
    this.visitTablevisitor = map['visitor'];
    this.visitTablevisitorReason = map['reason'];
    this.visitTablevisitType = map['type'];
    this.visitTablecarNo=map['car_no'];
    this.visitTableComments=map['comments'];
    this.visitTablePersonNum=map['personcount'];
    this.visitTabledatetime = map['updatetime'];
    this.visitAddress = map['address'];
    this.toBase64 = map['base64'];
  }

}

class Visitorsdb{


//  final String visitorsTableID='id';
//  final String visitorsTableRecordId='recordid';
//  final String visitorsTablename='name';
//  final String visitorsTableidcard='idcard';
//  final String visitorsTabletel='cellphone';
//  final String visitorsTableaddr='company';
//  final String visitorsTableIsRecog='recogflag';

 // int visitorsTableID ;     //主键id
  int visitorsTableRecordId; //记录id
  String visitorsTablename;  //姓名
  String visitorsTableidcard;  //身份证号
  String visitorsTabletel;//手机号码
  String visitorsTableaddr;  //公司
  String visitorsTableIsRecog; //是否认证


  Visitorsdb(this.visitorsTableRecordId ,
      this.visitorsTablename,this.visitorsTableidcard,this.visitorsTabletel,this.visitorsTableaddr,this.visitorsTableIsRecog );
  Visitorsdb.map(dynamic obj){
   // this.visitorsTableID = obj['id'];
    this.visitorsTableRecordId = obj['recordid'];
    this.visitorsTablename = obj['name'];
    this.visitorsTableidcard = obj['idcard'];
    this.visitorsTabletel = obj['cellphone'];
    this.visitorsTableaddr = obj['company'];
    this.visitorsTableIsRecog = obj['recogflag'];
  }

 // int get _visitorsTableID =>visitorsTableID;
  int get _visitorsTableRecordId=>visitorsTableRecordId;
  String get _visitorsTablename=>visitorsTablename;
  String get _visitorsTableidcard=>visitorsTableidcard;
  String get _visitorsTabletel=>visitorsTabletel;
  String get _visitorsTableaddr=>visitorsTableaddr;
  String get _visitorsTableIsRecog=>visitorsTableIsRecog;


  Map<String , dynamic> toMap(){
    var map = new Map<String , dynamic>();
   // map['id'] = _visitorsTableID;
    map['recordid'] = _visitorsTableRecordId;
    map['name'] = _visitorsTablename;
    map['idcard'] = _visitorsTableidcard;
    map['cellphone'] = _visitorsTabletel;
    map['company'] = _visitorsTableaddr;
    map['recogflag'] = _visitorsTableIsRecog;
    return map;
  }

  Visitorsdb.fromMap(Map<String , dynamic>map){
  //  this.visitorsTableID = map['id'];
    this.visitorsTableRecordId = map['recordid'];
    this.visitorsTablename = map['name'];
    this.visitorsTableidcard = map['idcard'];
    this.visitorsTabletel = map['cellphone'];
    this.visitorsTableaddr = map['company'];
    this.visitorsTableIsRecog = map['recogflag'];
  }

}