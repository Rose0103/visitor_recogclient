
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/apointment/writerPerson.dart';
import 'package:visitor_recogclient/pages/authentication/IDcardAuthentication.dart';

import '../inputInfoPage.dart';

// ignore: must_be_immutable
class IdCardSubmitWidget extends StatefulWidget {

  int type ;//区别现场登记和身份证认证

  IdCardSubmitWidget(this.type);

  @override
  _IdCardSubmitWidgetState createState() => _IdCardSubmitWidgetState(type);
}

class _IdCardSubmitWidgetState extends State<IdCardSubmitWidget>{
  String title = '正在读卡中,请稍后...';
  String djsText = '10';
  int type ;//区别现场登记和身份证认证
  _IdCardSubmitWidgetState(this.type);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      new Timer(const Duration(milliseconds: 1000), () {
        djsGet();
        if(type==1){
          IDcardAuthenticationPageState.raisedButton.onPressed();
        }else if(type==2){
          WriterPersonState.raisedButton.onPressed();
        }
      });
    });
  }

  //倒计时
  djsGet() {
    countTimers?.cancel(); //如果已存在先取消置空
    countTimers = null;
    countTimers = new Timer.periodic(new Duration(seconds: 1), (t) {
      if (10 - t.tick > 0) {
        setState(() {
          djsText = "${10 - t.tick}";
        });
      } else {
        countTimers.cancel();
        countTimers = null;
        isselect = false;
        Navigator.pop(context);
        showMessage(context, '未识别出身份证信息,请重试!');
      }
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
              SizedBox(height: ScreenUtil().setSp(20),),
              Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.w600),),
              SizedBox(height: ScreenUtil().setSp(20),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('倒计时 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                  Text(djsText,style: TextStyle(fontWeight:FontWeight.w600,color:Color.fromRGBO(255,182,0,1),fontSize: ScreenUtil().setSp(36)),),
                  Text(' s',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                ],
              ),
              Divider(height: ScreenUtil().setSp(20),),
            ],
          ),
        ),
      ),
    );
  }
}
