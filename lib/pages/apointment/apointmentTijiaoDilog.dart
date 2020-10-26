
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';

import 'apointmentMethod.dart';

class AlertTijiaoWidget extends StatefulWidget {

  @override
  _AlertTijiaoWidgetState createState() => _AlertTijiaoWidgetState();
}

class _AlertTijiaoWidgetState extends State<AlertTijiaoWidget>{
  String title = '确认提交？提交后不可重新选择预约记录！';
  String  confirm = '确定';
  String hintstr = '';
  String itemstr = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

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
              SizedBox(height: 20,),
              Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              Divider(height: 1,),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setSp(0),
                              ScreenUtil().setSp(5),
                              ScreenUtil().setSp(0),
                              ScreenUtil().setSp(5)
                          ),
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
                          isselect = false;
                          showProgressDialog(context);
                          ApointmentMethod.approve(context);
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
