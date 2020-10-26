
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_printer_plugin/demo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';

//预约记录
// ignore: must_be_immutable
class AppointmentRecord extends StatelessWidget{

  Appointment appointment;
  String content;//通行二维码内容
  String showButton;
  String visitName;//主来访人姓名
  bool dj;
  String tel;//受访人电话

  AppointmentRecord(this.appointment,{this.content,this.showButton,this.tel,this.visitName,this.dj=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setSp(dj?803:560),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
              color: Colors.black12,//投影颜色
              blurRadius: ScreenUtil().setSp(20)//投影距离
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(35),
              ScreenUtil().setSp(5),
              ScreenUtil().setSp(0),
              ScreenUtil().setSp(0),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
                  width: ScreenUtil().setSp(5),
                  height: ScreenUtil().setSp(40),
                  child: Image.asset('assets/images/icon17.png',fit: BoxFit.fill,),
                ),
                Text('   记录信息 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                showButton=="1"?Text(""):(showButton=="2"?Row(children: <Widget>[qrPrinter(context),cellPhone(context)],):qrPrinter(context))
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setSp(dj?803:603),//603
            height: ScreenUtil().setSp(dj?100:196),//196
            margin: EdgeInsets.only(top: ScreenUtil().setSp(16)),
            child: GridView.count(
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(5),
                ScreenUtil().setSp(0),
                ScreenUtil().setSp(0),
                ScreenUtil().setSp(0),
              ),
              crossAxisCount: dj?2:1,//1
              childAspectRatio: dj?12:15,//子Widget宽高比例15
              children: dj?<Widget>[
                items('assets/images/icon11.png', ' 拜 访 人：', appointment.appointment_name.length>12?appointment.appointment_name.substring(0,12):appointment.appointment_name),
                Text(appointment.appointment_name.length>12?appointment.appointment_name.substring(12,appointment.appointment_name.length):"",
                  overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: ScreenUtil().setSp(22),fontWeight: FontWeight.w600),),
                items('assets/images/icon10.png', '来访事由：', appointment.appointment_reason),
                items('assets/images/icon9.png', ' 车 牌 号：', appointment.appointment_car),
                items('assets/images/icon8.png', '同行人数：', appointment.appointment_tcount),
                items('assets/images/icon15.png', '备       注：', appointment.appointment_remarks),
              ]:<Widget>[
                items('assets/images/icon11.png', ' 拜 访 人：', appointment.appointment_name),
                items('assets/images/icon10.png', '来访事由：', appointment.appointment_reason),
                items('assets/images/icon9.png', ' 车 牌 号：', appointment.appointment_car),
                items('assets/images/icon8.png', '同行人数：', appointment.appointment_tcount),
                items('assets/images/icon15.png', '备       注：', appointment.appointment_remarks),
              ]
            ),
          )
        ]
      )
    );
  }

  //预约记录信息
  Widget items(String img,String title,String content){
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
            width: ScreenUtil().setSp(44),
//            height: ScreenUtil().setSp(40),
            child: img==""?Text(""):Image.asset(img,fit: BoxFit.fill,),
          ),
          Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(22),color: Colors.black38,),),
          Text(content, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: ScreenUtil().setSp(22),fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  Widget cellPhone(BuildContext context){
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil().setSp(120)),
        child: RaisedButton(
            onPressed: (){
              launch("tel:$tel");
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
            child: Text(' 电话确认 ',style: TextStyle(fontSize: ScreenUtil().setSp(22))),
            //hoverColor: Theme.of(context).primaryColor,
            //splashColor: Colors.black12,
            color: Color.fromRGBO(255,182,0,1),
            textColor: Colors.white
        )
    );
  }

  Widget qrPrinter(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setSp(120)),
      child: RaisedButton(
        onPressed: (){
          String counts;
          if(appointment.appointment_tcount==null||appointment.appointment_tcount==""){
            counts = "0";
          }else{
            counts = appointment.appointment_tcount;
          }
          if(appointment!=null&&appointment.appointment_name!=''&&count<=int.parse(counts)+1){
            Demo.getQRPrinter(content, appointment.appointment_name, appointment.appointment_tcount,visitName);
            count++;
          }else{
            showMessage(context, '未获取到打印信息或超过最大打印次数！');
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
        child: Text(' 打印通行证 ',style: TextStyle(fontSize: ScreenUtil().setSp(22))),
        //hoverColor: Theme.of(context).primaryColor,
        //splashColor: Colors.black12,
        color: Color.fromRGBO(255,182,0,1),
        textColor: Colors.white
      )
    );
  }
}