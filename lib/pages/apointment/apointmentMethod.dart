import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visitor_recogclient/common/database_helper.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/model/httpmodel/aporve.dart';
import 'package:visitor_recogclient/model/httpmodel/recordModel.dart';
import 'package:visitor_recogclient/model/httpmodel/recordsModel.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/apointment/ApoinmentDilog.dart';
import 'package:visitor_recogclient/pages/apointment/IdcardDilog.dart';
import 'package:visitor_recogclient/pages/apointment/apointmentTijiaoDilog.dart';
import 'package:visitor_recogclient/pages/apointment/outExcel.dart';
import 'package:visitor_recogclient/pages/apointment/writerCarNumber.dart';
import 'package:visitor_recogclient/service/service_method.dart';

import '../ProgressDialog.dart';

class ApointmentMethod{
  static List<Records> recordlist = new List<Records>();//存放预约记录
  static Appointment appointment;//主来访人信息
  static List<Visitorsdb> data = new List<Visitorsdb>();//来访人员信息
  static String recordids;//记录id
  static BuildContext contexts;

  static void showDilogrz(){
    showMessage(contexts, '请先认证主来访人！');
  }

  //根据人员ID查询人员信息
  static Future getinfobyuserid(String visitor,BuildContext context) async {
    recordlist.clear();
    String parms = "?visitor="+visitor+"&filterVisitMethod=LOCAL_REGISTER";
    await requestGet('getinfobyuserid',context, parms).then((val) async{
      if (val.toString() == "false") {
        return;
      }
      if (val != null) {
        visitorDataModel visitorData = visitorDataModel.fromJson(val);
        if (visitorData.code == 0) {
          recordlist = visitorData.data.records;
          ProgressDialog.dismiss(context);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          isselect = true;
          selectAppointmentDialog(context,recordlist);
          if(recordlist.isNotEmpty){
            imagesrc = recordlist[0].visitor.data.userId.data.avatar;
          }
//        }else if(visitorData.code==40001){
//          showMessage(context, visitorData.msg);
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) =>LoginWidget()));
        }else{
          showMessage(context, visitorData.msg);
          ProgressDialog.dismiss(context);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
        }
      }
    });
  }

  //根据记录ID查询预约及同行人员信息
  static Future getdetailinfo(String record,BuildContext context) async {
    recordids = record;
    contexts = context;
    isselect = true;
    String parms = "?id="+record+"&scheduleType=MYSELF";
    await requestGet('getdetailinfo',context, parms).then((val) async{
      if (val.toString() == "false") {
        return;
      }
      if (val != null) {
        RecordModelDate recordModelDate = RecordModelDate.fromJson(val);
        if (recordModelDate.code == 0) {
          data = new List<Visitorsdb>();
          List<RecordModelDateDataInterviewPartnerReturnDtoList> interviewPartnerReturnDtoList = recordModelDate.data.interviewPartnerReturnDtoList;
          for(int i=0;i<interviewPartnerReturnDtoList.length+1;i++){
            if(i==0){
              data.add(new Visitorsdb(
                  i,
                  recordModelDate.data.visitor.data.userId.data.name,
                  recordModelDate.data.visitor.data.userId.data.idCard,
                  recordModelDate.data.visitor.data.userId.data.mobile,
                  recordModelDate.data.visitor.data.tenantCode.data==null?"":
                  recordModelDate.data.visitor.data.tenantCode.data.name,
                  '2'
              ));
            }else{
              data.add(new Visitorsdb(
                  i,
                  interviewPartnerReturnDtoList[i-1].partnerName,
                  interviewPartnerReturnDtoList[i-1].partnerIdCard,
                  '',
                  '',
                  '2'
              ));
            }
          }
          String licenseNumber = "";
          if(recordModelDate.data.licenseNumber.isEmpty){
            licenseNumber = "无";
          }else{
            for(int i=0;i<recordModelDate.data.licenseNumber.length;i++){
              if(i==recordModelDate.data.licenseNumber.length-1){
                licenseNumber = licenseNumber+recordModelDate.data.licenseNumber[i];
              }else{
                licenseNumber = licenseNumber+recordModelDate.data.licenseNumber[i]+"、";
              }
            }
          }
          appointment = new Appointment(
              recordModelDate.data.intervieweeName,
              recordModelDate.data.reservationIncident,
              licenseNumber,
              recordModelDate.data.partnerNumber.toString(),
              "无"
          );
          isvis = true;
          ProgressDialog.dismiss(context);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          isselect = false;
          Navigator.pop(context,true);
//        }else if(recordModelDate.code==40001){
//          showMessage(context, recordModelDate.msg);
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) =>LoginWidget()));
        }else{
          ProgressDialog.dismiss(context);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          showMessage(context, recordModelDate.msg);
        }
      }
    });
  }


  //认证
  static Future approve(BuildContext context,{int index,int personid}) async {
    String parms;
    if(personid==null){
      parms = "?recordId="+recordids;
    }else{
      parms = "?recordId="+recordids+"&personId="+personid.toString();
    }
    await requestPut('approve',context, parms).then((val) async{
      if (val.toString() == "false") {
        return;
      }
      if (val != null) {
        AproveDataModel aproveDataModel = AproveDataModel.fromJson(val);
        if(aproveDataModel.isSuccess){
          if(personid!=null){
            data[index].visitorsTableIsRecog = '1';
            isvis = true;
          }
          // countDownTimer.cancel();
          // countDownTimer = null;
//          Navigator.pop(context);
          isRZ = true;
          showMessage(context, '认证成功!');
          //数据库保存一份
          var db = new DatabaseHelper();
          int recordid = await db.saveRecord(
              new MainInfo(data[0].visitorsTablename,data[0].visitorsTableidcard,"","",data[0].visitorsTabletel , appointment.appointment_name ,appointment.appointment_reason,visitMethod=="MOBILE_LOCAL_REGISTER"?3:2, appointment.appointment_car,appointment.appointment_remarks,data.length-1,DateTime.now().toString().split('.')[0]) );
          for(int i=0;i<data.length;i++) {
            int personId = await db.savePersonData(
                new Visitorsdb(recordid,data[i].visitorsTablename,data[i].visitorsTableidcard , data[i].visitorsTabletel , data[i].visitorsTableaddr ,"" ));
            print(personId);
          }
        }
        if(aproveDataModel.code<0){
          ProgressDialog.dismiss(context);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          showMessage(context, aproveDataModel.msg);
        }
//        if(aproveDataModel.code==40001){
//          showMessage(context, aproveDataModel.msg);
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) =>LoginWidget()));
//        }
        Navigator.pop(context);
        countTimer.cancel(); // 取消重复计时
        countTimer = null;
        ProgressDialog.dismiss(context);
      }
    });
  }

  //选择预约记录
  static void selectAppointmentDialog(BuildContext context,List list){
    showGeneralDialog(
      context: context,
      // ignore: missing_return
      pageBuilder: (context, anim1, anim2) {},
      barrierColor: Colors.grey.withOpacity(.4),
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 125),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
            scale: anim1.value,
            child: Opacity(
                opacity: anim1.value,
                child: AlertWidget(
                  recordList: list,
                )
            )
        );
      }
    );
  }

  //确认提交
  static void tijiaoApointmentDialog(BuildContext context){
    showGeneralDialog(
        context: context,
        // ignore: missing_return
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.grey.withOpacity(.4),
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 125),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: AlertTijiaoWidget()
              ));
        });
  }

  //输入车牌号
  static void writerCar(BuildContext context,TextEditingController _carNoController){
    showGeneralDialog(
        context: context,
        // ignore: missing_return
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.grey.withOpacity(.4),
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 125),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: WriterCarNumber(_carNoController)
              ));
        });
  }

  //开启身份证识别
  static void idcardApointmentDialog(BuildContext context,int type){
    showGeneralDialog(
        context: context,
        // ignore: missing_return
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.grey.withOpacity(.4),
        barrierDismissible: false,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 125),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: IdCardSubmitWidget(type)
              ));
        });
  }

  //导出Excel
  static void outExcels(BuildContext context){
    showGeneralDialog(
        context: context,
        // ignore: missing_return
        pageBuilder: (context, anim1, anim2) {},
        barrierColor: Colors.grey.withOpacity(.4),
        barrierDismissible: false,
        barrierLabel: "",
        transitionDuration: Duration(milliseconds: 125),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                  opacity: anim1.value,
                  child: OutExcel()
              ));
        });
  }
}