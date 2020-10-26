import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/pages/ProgressDialog.dart';

void showMessage(BuildContext context,String text) async{
  Fluttertoast.showToast(
      msg: text,
      fontSize: 30,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: floaststaytime,
      backgroundColor: Color.fromRGBO(255,182,0,1),
      textColor: Colors.pink);
  return;
}

void showMessage2(String text) async{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: floaststaytime,
      backgroundColor: Color.fromRGBO(255,182,0,1),
      textColor: Colors.pink);
  return;
}

//加载提示框
void showProgressDialog(BuildContext context){
  ProgressDialog.showProgress(context, child: SpinKitFadingCircle(
    itemBuilder: (_, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255,182,0,1),
        ),
      );
    },
  ));
  int seconds = 0;
  countTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
    if(seconds >= 10){
      countTimer.cancel(); // 取消重复计时
      showMessage(context,'服务器异常！');
      ProgressDialog.dismiss(context);
    }
    seconds++;// 秒数+1
  });
}

////加载提示框
//void showidcardProgressDialog(BuildContext context){
//  ProgressDialog.showProgress(context, child: SpinKitFadingCircle(
//    itemBuilder: (_, int index) {
//      return IdcardTijiaoWidget();
//    },
//  ));
//}
