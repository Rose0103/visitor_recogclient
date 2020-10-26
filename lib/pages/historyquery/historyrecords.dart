import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:visitor_recogclient/pages/historyquery/historydetailPage.dart';

class RecordDataTableSource extends DataTableSource {
  RecordDataTableSource(this.context,this.data);
  BuildContext context;
  final List<MainInfo> data;

  @override
  DataRow getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index,
//      selected: data[index].selected,
//      onSelectChanged: (selected) {
//        data[index].selected = selected;
//        notifyListeners();
//      },
      cells: none?[
            DataCell(FlatButton( child: Text("详情",style: TextStyle(
                color: Colors.orange,
                fontSize: ScreenUtil.getInstance().setSp(20))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryDetailPage(data[index],"1")));
              },)),
              DataCell(Text('${data[index].visitTabledatetime.split(".")[0]}',style: TextStyle(fontSize:ScreenUtil().setSp(20)),)),
              DataCell(Text('${data[index].visitTableMainPersonName}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTableMainPersonIDCardNo}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTableMainPersoncellphoneNo}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitAddress}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTablevisitor}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTablevisitorReason}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(data[index].visitTablevisitType==1?Text('现场登记',style: TextStyle(fontSize:ScreenUtil().setSp(20)))
                  :(data[index].visitTablevisitType==2?Text("预约访问",style: TextStyle(fontSize:ScreenUtil().setSp(20)))
                    :Text("现场登记(手机)",style: TextStyle(fontSize:ScreenUtil().setSp(20))))),
          ]:[
              DataCell(FlatButton( child: Text("详情",style: TextStyle(
                  color: Colors.orange,
                  fontSize: ScreenUtil.getInstance().setSp(20))),
              onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistoryDetailPage(data[index],"1")));
              },)),
              DataCell(Text('${data[index].visitTabledatetime.split(".")[0]}',style: TextStyle(fontSize:ScreenUtil().setSp(20)),)),
              DataCell(Text('${data[index].visitTableMainPersonName}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTableMainPersonIDCardNo}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTableMainPersoncellphoneNo}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTablevisitor}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(Text('${data[index].visitTablevisitorReason}',style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
              DataCell(data[index].visitTablevisitType==1?Text('现场登记',style: TextStyle(fontSize:ScreenUtil().setSp(20)))
                  :Text("预约访问",style: TextStyle(fontSize:ScreenUtil().setSp(20)))),
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