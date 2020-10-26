
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/model/VisitorsModel.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';

//来访人员
class VisitorsPage extends StatelessWidget{

  List<Visitorsdb> _data;
  bool dj;

  VisitorsPage(this._data,{this.dj=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setSp(1047),
//      height: ScreenUtil().setSp(440),
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setSp(dj?0:30),//30
        ScreenUtil().setSp(dj?0:30),//30
        ScreenUtil().setSp(dj?0:60),//60
        ScreenUtil().setSp(0),
      ),
//      padding: EdgeInsets.only(left: ScreenUtil().setSp(200)),
      child: SingleChildScrollView(
        child: VisitorsTable(context),
      )
    );
  }

  //同行人员记录表
  Widget VisitorsTable(BuildContext context){
    return Container(
      child: PaginatedDataTable(
        header: Row(
          children: <Widget>[
            Container(
              padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
              width: ScreenUtil().setSp(5),
              height: ScreenUtil().setSp(40),
              child: Image.asset('assets/images/icon17.png',fit: BoxFit.fill,),
            ),
            Text('    来访人员 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
          ],
        ),
        rowsPerPage:4,
        columns: [
          DataColumn(label: Text('序号',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(22)))),
          DataColumn(label: Text('姓名',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(22)))),
          DataColumn(label: Text('身份证号',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(22)))),
          DataColumn(label: Text('手机号码',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(22)))),
          DataColumn(label: Text('单位名称',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(22)))),
//          DataColumn(label: Text('认证结果')),
        ],
        source: VisitorsDataTableSource(_data,context),
      ),
    );
  }
}