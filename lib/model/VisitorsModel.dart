import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';

class VisitorsDataTableSource extends DataTableSource {
  VisitorsDataTableSource(this.data,this.context);
  BuildContext context;
  List<Visitorsdb> data;
  DataRow getRow(int index) {
    if(data.length==0){
      return null;
    }
    if (index >= data.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index+1}',style: TextStyle(fontSize:ScreenUtil().setSp(22)))),
        DataCell(Text('${data[index].visitorsTablename}',style: TextStyle(fontSize:ScreenUtil().setSp(22)))),
        DataCell(Text('${data[index].visitorsTableidcard}',style: TextStyle(fontSize:ScreenUtil().setSp(22)))),
        DataCell(Text('${data[index].visitorsTabletel}',style: TextStyle(fontSize:ScreenUtil().setSp(22)))),
        DataCell(Text('${data[index].visitorsTableaddr}',style: TextStyle(fontSize:ScreenUtil().setSp(22)))),
//        DataCell(data[index].visitorsTableIsRecog=='1'?
//          Text('已认证',style: TextStyle(fontSize:ScreenUtil().setSp(18),color: Colors.green),)
//            :
//          (data[index].visitorsTableIsRecog=='2'?
//            FlatButton(
//            child: Text('未认证',style: TextStyle(fontSize:ScreenUtil().setSp(18),color: Colors.red),),
//            onPressed: (){
//              if(isRZ){
//                ApointmentMethod.approve(context,index: index,personid: data[index].visitorsTableRecordId);
//              }else{
//                ApointmentMethod.showDilogrz();
//              }
//            },)
//              :
//            Text(''))
//        )
      ],
    );
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }
}