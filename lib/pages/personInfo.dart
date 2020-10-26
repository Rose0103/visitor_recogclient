import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/config/param.dart';

class personInfo{
  personInfo(this.personName, this.idCardNo, this.cellphoneNo,this.companyName,this.selected);
  String personName=""; //姓名
  String idCardNo="";  //身份证号
  String companyName="";  //单位名称
  String cellphoneNo="";//手机号码
  bool  selected=false; //是否选中
}

class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data);

  final List<personInfo> data;

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
      cells: [
        DataCell(Row(
          children: <Widget>[
            InkWell(
              child:Container(
                alignment: Alignment.center,
                width: ScreenUtil().setSp(80),
                height: ScreenUtil().setSp(40),
                child: Text("修改",style: TextStyle(color: Colors.blue, fontSize: ScreenUtil.getInstance().setSp(20))),
              ),
              onTap: () {
                tableindex = index;
                updateflatButton.onPressed();
              },
            ),
            InkWell(
              child:Container(
                alignment: Alignment.center,
                width: ScreenUtil().setSp(80),
                height: ScreenUtil().setSp(40),
                child: Text("删除",style: TextStyle(color: Colors.red, fontSize: ScreenUtil.getInstance().setSp(20))),
              ),
              onTap: () {
                tableindex = index;
                deleteflatButton.onPressed();
              },
            )
          ],
        )),
        DataCell(Text('${index+1}',style: TextStyle(fontSize: ScreenUtil().setSp(20)),)),
        DataCell(Text('${data[index].personName}',style: TextStyle(fontSize: ScreenUtil().setSp(20)),)),
        DataCell(Text('${data[index].idCardNo}',style: TextStyle(fontSize: ScreenUtil().setSp(20)),)),
        DataCell(Text('${data[index].cellphoneNo}',style: TextStyle(fontSize: ScreenUtil().setSp(20)),)),
        DataCell(Text('${data[index].companyName}',style: TextStyle(fontSize: ScreenUtil().setSp(20)),)),
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