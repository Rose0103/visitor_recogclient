//展示访客信息
//现场资料填写界面
//选择现场登记还是现场认证

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/pages/container/AppointmentRecord.dart';
import 'package:visitor_recogclient/common/database_helper.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import '../../base64ToImage.dart';
import '../container/VisitorsPage.dart';

// ignore: must_be_immutable
class HistoryDetailPage extends StatefulWidget {
  MainInfo info;
  int recordId;
  String shows;
  String visName;

  HistoryDetailPage(this.info,this.shows,{this.recordId,this.visName});

  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState(this.info,this.shows,recordId:recordId,visName: visName);
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {

  MainInfo info;
  int recordId;
  String shows;
  String visName;
  Image imagecontainer;

  _HistoryDetailPageState(this.info,this.shows,{this.recordId,this.visName});

  List<Visitorsdb> _data = new List<Visitorsdb>();//来访人员信息
  Appointment appointment;//预约人员信息

  @override
  void initState() {
    super.initState();
    initImage();
    appointment = new Appointment(info.visitTablevisitor ,info.visitTablevisitorReason, info.visitTablecarNo, info.visitTablePersonNum.toString(), info.visitTableComments);
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      var db = new DatabaseHelper();
      if(info.visitTableColumnId==null){
        _data = await db.getPersonDataByRecordID(recordId);
      }else{
        _data = await db.getPersonDataByRecordID(info.visitTableColumnId);
      }
      setState(() {

      });
    });
  }

  //加载人脸图片
  void initImage() async {
//    int a = info.toBase64.length~/4000;
//    print(a);
//    for(int i=0;i<=a;i++){
//      if(i==a){
//        print(info.toBase64.substring(i*4000,info.toBase64.length));
//      }else{
//        print(info.toBase64.substring(i*4000,(i+1)*4000));
//      }
//    }
    if(info.toBase64!=null&&info.toBase64!=""){
      imagecontainer = await Base64ToImage.base642Images(info.toBase64);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                leading: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Image.asset("assets/images/back.png",fit: BoxFit.fill,),
                        Text(' 返回',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
                centerTitle: true,
                title: Text(
                  '记录查询详情',
                  style: TextStyle(color: Colors.black,
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight:FontWeight.w700),
                ),
                backgroundColor: Colors.white,
                elevation: 8.0,
                brightness: Brightness.light,
              ),
              preferredSize: Size.fromHeight(68)
          ),
          body: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: ScreenUtil().setSp(1246),
                  height: ScreenUtil().setSp(688),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/BG.png"),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
                            color: Colors.black12,//投影颜色
                            blurRadius: ScreenUtil().setSp(12)//投影距离
                        )
                      ]
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setSp(1246),
                        //height: ScreenUtil().setSp(200),
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setSp(60),
                          ScreenUtil().setSp(40),
                          ScreenUtil().setSp(60),
                          ScreenUtil().setSp(0),
                        ),
                        child: AppointmentRecord(appointment,showButton: shows,visitName: visName,),//预约记录
                      ),
                      VisitorsPage(_data)//来访人员
                    ],
                  ),
                ),
              ),
              Positioned(
                right: ScreenUtil().setSp(160),
                top: ScreenUtil().setSp(80),
                child: Container(
                  height: ScreenUtil().setSp(140),
                  width: ScreenUtil().setWidth(210),
                  color: Colors.lightBlueAccent,
                  child: info.toBase64==""?Text(""):imagecontainer,
                ),
              )
            ],
          ),
        )
    );
  }

}
