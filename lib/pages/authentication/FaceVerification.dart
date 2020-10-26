//人脸认证
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_printer_plugin/demo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/model/httpmodel/facedatamodel.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/apointment/apointmentMethod.dart';
import 'package:visitor_recogclient/pages/container/AppointmentRecord.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:visitor_recogclient/pages/facedetect/facedetectPage.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import 'package:visitor_recogclient/config/param.dart';
import '../container/VisitorsPage.dart';
import 'dart:io';

//人脸认证
class FaceVerificationPage extends StatefulWidget {
  @override
  FaceVerificationPageState createState() => FaceVerificationPageState();
}

class FaceVerificationPageState extends State<FaceVerificationPage> {

  Timer timer;//用于演示加载
  String djsText = '120';
  List<Visitorsdb> _data = new List<Visitorsdb>();//来访人员信息
  static final Appointment nullAppointment = new Appointment('', '', '', '', '');//预约人员信息
  Appointment appointment;//预约人员信息
  AppointmentRecord appointmentRecord;
  VisitorsPage visitorsPage;
  bool b = false;//禁止用户在3秒前点击按钮

  @override
  void initState() {
    super.initState();
    if(appointment != nullAppointment){
      _data.clear();
      appointment = nullAppointment;
      appointmentRecord = new AppointmentRecord(appointment);
      visitorsPage = new VisitorsPage(_data);
      isRZ = false;//判断认证是否成功
    }
    ApointmentMethod.recordlist.clear();
    djsGet();
    count = 0;//记录打印次数
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = new Timer(const Duration(milliseconds: 1000), () async {
        Map<PermissionGroup, PermissionStatus> cameras = await PermissionHandler().requestPermissions([PermissionGroup.camera]);
        print(cameras);
        PermissionStatus camera = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.camera);
        if (camera == PermissionStatus.granted) {
          //Fluttertoast.showToast(msg: "权限申请通过");onReceiveNotification
        } else {
          Fluttertoast.showToast(msg: "相机权限申请被拒绝");
        }
        isselect = true;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>FaceDetectPage()));
        b = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(facebol){
      ApointmentMethod.getinfobyuserid(userIds, context);
      facebol = false;
    }
    if(isvis){
      appointment = ApointmentMethod.appointment;
      _data = ApointmentMethod.data;
      appointmentRecord = new AppointmentRecord(appointment,content: ApointmentMethod.recordids);
      visitorsPage = new VisitorsPage(_data);
      isvis = false;
    }
    return Container(
        color: Colors.white,
        child: Scaffold(
            appBar: PreferredSize(
                child: AppBar(
                  leading: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Image.asset("assets/images/back.png",fit: BoxFit.fill,),
                          Text(' 返回',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)
                        ],
                      ),
                      onPressed: () {
                        if(countDownTimer != null) {
                          countDownTimer.cancel();
                          countDownTimer = null;
                        }
                        facePicPath = '';
                        Navigator.pop(context);
                      }
                  ),
                  centerTitle: true,
                  title: Text(
                    '人脸认证',
                    style: TextStyle(color: Colors.black,
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight:FontWeight.w700),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 8.0,
                  brightness: Brightness.light,
                ),
                preferredSize: Size.fromHeight(68)
            ),
            body: Container(
              width: ScreenUtil().setSp(1366),
              height: ScreenUtil().setSp(688),
//                padding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setSp(0),
//                  ScreenUtil().setSp(0),
//                  ScreenUtil().setSp(0),
//                  ScreenUtil().setSp(0),
//                ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/BG.png"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
                        color: Colors.black12,//投影颜色
                        blurRadius: ScreenUtil().setSp(12)//投影距离
                    )
                  ]
              ),
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child:SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setSp(1366),
                          height: ScreenUtil().setSp(60),
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setSp(72),
                            ScreenUtil().setSp(0),
                            ScreenUtil().setSp(60),
                            ScreenUtil().setSp(0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
                                width: ScreenUtil().setSp(55),
//                                height: ScreenUtil().setSp(80),
                                child: Image.asset('assets/images/icon16.png',fit: BoxFit.fill,),
                              ),
                              Text('只认证主来访人',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                              Container(
                                  width: ScreenUtil().setSp(760),
                                  child:Text('请将人脸对准谁想头',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),)
                              ),
                              Text('倒计时 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                              Text(djsText,style: TextStyle(fontWeight:FontWeight.w600,color:Color.fromRGBO(255,182,0,1),fontSize: ScreenUtil().setSp(36)),),
                              Text(' s',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setSp(1366),
                          height: ScreenUtil().setSp(270),
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setSp(60),
                            ScreenUtil().setSp(0),
                            ScreenUtil().setSp(60),
                            ScreenUtil().setSp(0),
                          ),
                          child: Row(
                            children: <Widget>[
                              cameraPage(),//摄像头窗口
                              appointmentRecord//预约记录
                            ],
                          ),
                        ),
                        VisitorsPage(_data)//来访人员
                      ],
                    ),
                  )
              ),
            )
        )
    );
  }

  //倒计时
  djsGet() {
    countDownTimer?.cancel(); //如果已存在先取消置空
    countDownTimer = null;
    countDownTimer = new Timer.periodic(new Duration(seconds: 1), (t) {
      if (120 - t.tick > 0) {
        //60-t.tick代表剩余秒数，如果大于0，设置yzmText为剩余秒数，否则重置yzmText，关闭countTimer
        setState(() {
          djsText = "${120 - t.tick}";
        });
      } else {
        countDownTimer.cancel();
        countDownTimer = null;
        facePicPath = '';
        Navigator.pop(context);
        if(isselect){
          Navigator.pop(context);
          isselect = false;
        }
      }
    });
  }

  //摄像头窗口
  Widget cameraPage(){
    return Container(
      width: ScreenUtil().setSp(560),
      height: ScreenUtil().setSp(300),
      margin: EdgeInsets.only(right: ScreenUtil().setSp(40)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
                color: Colors.black12,//投影颜色
                blurRadius: ScreenUtil().setSp(12)//投影距离
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(35),
              ScreenUtil().setSp(20),
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
                Text('   摄像头窗口 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
              ],
            ),
          ),
          Container(
              width: ScreenUtil().setSp(603),
              height: ScreenUtil().setSp(118),
              margin: EdgeInsets.only(top: ScreenUtil().setSp(10)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: ScreenUtil().setSp(33),
                    child:Container(
                      width: ScreenUtil().setSp(500),
                      height: ScreenUtil().setSp(98),
                      child: Image.asset('assets/images/icon19.png'),
                    ),
                  ),
                  Positioned(
                    left: ScreenUtil().setSp(205),
                    child: Container(
                      width: ScreenUtil().setSp(157),
                      height: ScreenUtil().setSp(110),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: MaterialButton(
                        onPressed: (){
                          if(b){
                            if(!isRZ){
                              isselect = true;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>FaceDetectPage()));
                            }else{
                              showMessage(context,'您已认证成功,请勿重复点击!');
                            }
                          }else{
                            showMessage(context, "正在启动中...");

                          }
                        },
                        child: facePicPath==""?Image.asset('assets/images/icon20.png'):Image.file(File(facePicPath)),
                      ),
                    ),
                  )
                ],
              )
          ),
          Container(
            height: ScreenUtil().setSp(80),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(110.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0)),
            child: Row(
              children: <Widget>[
                reselectButton(),
                submitButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  //根据人脸图片查询预约人员信息
  static Future getuserinfobyFace(BuildContext context) async {
    List<String> strs = facePicPath.split('/');
//    String imagename = strs[strs.length-1];
//    String facepath = facePicPath.substring(0,facePicPath.length-imagename.length-1);
//    return true ;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(facePicPath, filename: strs[strs.length-1]),
    });
    await request('searchFace',context,'',formData: data).then((val) async{
      if (val != null) {
        FaceDateModel faceDateModel = FaceDateModel.fromJson(val);
        if(faceDateModel.code=='0'){
          userIds = faceDateModel.data.userId;
          facebol = true;
        }else{
//          showMessage(context, faceDateModel.msg);
          facebol = false;
        }
      }
    });
//    Directory(facePicPath).delete(recursive: true).then((
//        FileSystemEntity fileSystemEntity) {
//    });
  }

  //重新选择按钮
  Widget reselectButton() {
    return Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(50.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            if(isRZ){
              showMessage(context, '无法重新选择！');
            }else if(ApointmentMethod.recordlist.isEmpty){
              showMessage(context, '未查询到预约记录，请重新识别！');
            }else{
              ApointmentMethod.selectAppointmentDialog(context,ApointmentMethod.recordlist);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("重新选择",style: TextStyle(fontSize: ScreenUtil().setSp(18))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  //提交认证按钮
  Widget submitButton() {
    return Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(50.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            if(isRZ){
              showMessage(context, '您已认证成功！请勿重复点击');
            }else if(ApointmentMethod.recordlist.isEmpty){
              showMessage(context, '未查询到预约记录，请重新识别！');
            }else{
              isselect = true;
              ApointmentMethod.tijiaoApointmentDialog(context);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("提交认证",style: TextStyle(fontSize: ScreenUtil().setSp(18))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }
}