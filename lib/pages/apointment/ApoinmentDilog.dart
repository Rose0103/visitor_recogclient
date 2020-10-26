
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/httpmodel/recordsModel.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';

import 'apointmentMethod.dart';

// ignore: must_be_immutable
class AlertWidget extends StatefulWidget {
  List<Records> recordList;
  AlertWidget({this.recordList});

  @override
  _AlertWidgetState createState() => _AlertWidgetState(
    recordlist: recordList
  );
}

class _AlertWidgetState extends State<AlertWidget>{
  String title = '请选择一条预约记录';
  String  confirm = '确定';
  var value;
  List<Records> recordlist;
  String hintstr = '';
  String itemstr = '';
  String visitState;//预约记录状态

  String recordid;
  int inde;

  List<DropdownMenuItem> items = new List<DropdownMenuItem>();

  @override
  void initState() {
    super.initState();
    _inititems();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  //初始化列表
  void _inititems(){
    if(recordlist==null||recordlist.isEmpty){
      hintstr = '当日没有预约记录!';
    }else{
      hintstr = '   请选择(主来访人-受访人-预约时间-状态)';
      for(int i=0;i<recordlist.length;i++){
        itemstr = "${i+1}：${recordlist[i].visitor.data.name}-${recordlist[i].intervieweeName}-${recordlist[i].reservationTime}-${recordlist[i].visitStatus.desc}";
        items.add(
            new DropdownMenuItem(
                child: Text(itemstr,
                  style: TextStyle(fontSize:ScreenUtil().setSp(24),color:Colors.black),),
                value: itemstr)
        );
      }
    }
  }

  _AlertWidgetState({this.recordlist});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(200.0),
              ScreenUtil().setSp(0.0),
              ScreenUtil().setSp(200.0),
              ScreenUtil().setSp(0.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16,),
              Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
              Container(
                margin: EdgeInsets.only(top: 16),
                height: ScreenUtil().setSp(50),
                child:DropdownButton(
                  items: items.map<DropdownMenuItem>((item) {
                    return item;
                  }).toList(),
                  hint:new Text(hintstr),// 当没有初始值时显示
                  onChanged: (selectValue){//选中后的回调
                    setState(() {
                      value = selectValue;
                      inde = int.parse(value.substring(0,1));
                      recordid = recordlist[inde-1].id;
                      visitState = recordlist[inde-1].visitStatus.code;
                      visitMethod = recordlist[inde-1].visitMethod.code;
                    });
                  },
                  value: value,// 设置初始值，要与列表中的value是相同的
                  elevation: 10,//设置阴影
                  style: new TextStyle(//设置文本框里面文字的样式
                      color: Color.fromRGBO(255,182,0,1),
                      fontSize: ScreenUtil().setSp(24)
                  ),
                  iconSize: 30,//设置三角标icon的大小
                  underline: Container(height: 1,color: Color.fromRGBO(255,182,0,1),),// 下划线
                ),
              ),
              SizedBox(height: 16,),
              Divider(height: 1,),
              Container(
                height: ScreenUtil().setSp(50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: FlatButton(
                            child: Text('取消',style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600)),
                            onPressed: (){
                              isvis = false;
                              isselect = false;
                              Navigator.pop(context);
                            }
                          ),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1,color: Color(0xffEFEFF4))),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Text(confirm,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600)),
                        onPressed: (){
                          if(recordid==null){
                            if(hintstr == '当日没有预约记录!'){
                              Navigator.pop(context);
                              isselect = false;
                            }else{
                              showMessage(context, '请选择一条预约记录');
                              isselect = true;
                            }
                          }else{
                            if(visitState=="FINISHED_APPOINT"){
                              showMessage(context, '无法选择已履约记录');
                            }else{
                              showProgressDialog(context);
                              ApointmentMethod.getdetailinfo(recordid,context);
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
