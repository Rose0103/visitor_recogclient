//身份证认证
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_printer_plugin/demo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/model/IDcardpersonModel.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/ProgressDialog.dart';
import 'package:visitor_recogclient/pages/apointment/apointmentMethod.dart';
import 'package:visitor_recogclient/pages/container/AppointmentRecord.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import '../container/VisitorsPage.dart';
import 'package:visitor_idcard/visitor_idcard.dart';

//人脸认证
class IDcardAuthenticationPage extends StatefulWidget {
  @override
  IDcardAuthenticationPageState createState() => IDcardAuthenticationPageState();
}

class IDcardAuthenticationPageState extends State<IDcardAuthenticationPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  String djsText = '120';
  static List<Visitorsdb> _data = new List<Visitorsdb>();//来访人员信息
  static final Appointment nullappointment = new Appointment('', '', '', '', '');//预约人员信息
  Appointment appointment;//预约人员信息
  AppointmentRecord appointmentRecord;
  VisitorsPage visitorsPage;
  Container container1;//按钮一
  Container container2;//按钮二
  RaisedButton container3;//按钮三
  bool ischange = false;//检测文本是否改变
  ImageProvider imagecontainer = AssetImage("assets/images/icon18.png");
  bool isidcard = false;
  static RaisedButton raisedButton;

  @override
  void initState() {
    super.initState();
    if(appointment != nullappointment){
      _data.clear();
      appointment = nullappointment;
      appointmentRecord = new AppointmentRecord(appointment);
      visitorsPage = new VisitorsPage(_data);
      isRZ = false;//判断认证是否成功
    }
    ApointmentMethod.recordlist.clear();
    djsGet();
    container1 = selectButton();
    container2 = resButton();
    container3 = openIdCard('身份证识别');
    raisedButton = con2();
    count = 0;//记录打印次数
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isvis){
      _data.clear();
      container1 = reselectButton();
      container2 = submitButton();
      container3 = openIdCard('重新识别');
      imagecontainer = NetworkImage(imagesrc);
      FocusScope.of(context).requestFocus(FocusNode());
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
                        Navigator.pop(context);
                      }
                  ),
                  centerTitle: true,
                  title: Text(
                    '身份证认证',
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
                                  child:Text('请将身份证放在读卡器上',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),)
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
                              appointmentRecord,
                            ],
                          ),
                        ),
                        visitorsPage//来访人员
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
        Navigator.pop(context);
        if(isselect){
          Navigator.pop(context);
          isselect = false;
        }
      }
    });
  }

  //身份证信息
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
              ScreenUtil().setSp(25),
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
                Text('   身份证信息 ',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setSp(560),
            height: ScreenUtil().setSp(122),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setSp(420),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setSp(54),
                        margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setSp(16),
                          ScreenUtil().setSp(0),
                          ScreenUtil().setSp(0),
                          ScreenUtil().setSp(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
                              width: ScreenUtil().setSp(37),
//                              height: ScreenUtil().setSp(60),
                              child: Image.asset('assets/images/icon13.png',fit: BoxFit.fill,),
                            ),
                            Text('姓           名：',style: TextStyle(fontSize: ScreenUtil().setSp(22),color: Colors.black38),),
                            Container(
                              width: ScreenUtil().setSp(240),
                              height: ScreenUtil().setSp(42),
                              child: TextFormField(
                                controller: _nameController,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    border: InputBorder.none,//去掉输入框的下滑线
                                    fillColor: Color.fromRGBO(235, 238, 245, 94.12),
                                    hintText: "主来访人姓名",
                                    hintStyle: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600),
                                    filled: true,
                                    enabledBorder: null,
                                    disabledBorder: null
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setSp(54),
                        margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setSp(11),
                          ScreenUtil().setSp(5),
                          ScreenUtil().setSp(0),
                          ScreenUtil().setSp(0),
                        ),
                        child:Row(
                          children: <Widget>[
                            Container(
                              padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
                              width: ScreenUtil().setSp(37),
//                              height: ScreenUtil().setSp(60),
                              child: Image.asset('assets/images/icon12.png',fit: BoxFit.fill,),
                            ),
                            Text('身份证号码：',style: TextStyle(fontSize: ScreenUtil().setSp(22),color: Colors.black38),),
                            Container(
                              width: ScreenUtil().setSp(240),
                              height: ScreenUtil().setSp(42),
                              child: TextFormField(
                                onChanged: (text){
                                  ischange = true;
                                },
                                controller: _idController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    border: InputBorder.none,//去掉输入框的下滑线
                                    fillColor: Color.fromRGBO(235, 238, 245, 94.12),
                                    hintText: "请输入身份证号码",
                                    hintStyle: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600),
                                    filled: true,
                                    enabledBorder: null,
                                    disabledBorder: null
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setSp(130),
//                  height: ScreenUtil().setSp(110),
                  margin: EdgeInsets.only(left: ScreenUtil().setSp(10)),
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(20),
                    ScreenUtil().setSp(10),
                    ScreenUtil().setSp(10),
                    ScreenUtil().setSp(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imagecontainer,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setSp(80),
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(50.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0)),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setSp(48),
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(0.0),
                      ScreenUtil().setSp(0.0),
                      ScreenUtil().setSp(20.0),
                      ScreenUtil().setSp(0.0)),
                  child: container3,
                ),
                container1,
                container2
              ],
            ),
          )
        ],
      ),
    );
  }

  //查询按钮
  Widget selectButton() {
    return Container(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            if(ApointmentMethod.recordlist.isEmpty){
              getAppointmentAndVisit();
            }else{
              if(ischange){
                ApointmentMethod.recordlist.clear();
                getAppointmentAndVisit();
              }else{
                ApointmentMethod.selectAppointmentDialog(context,ApointmentMethod.recordlist);
              }
            }
            ischange = false;
            isidcard = false;
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("查   询",style: TextStyle(fontSize: ScreenUtil().setSp(22))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  //重新选择按钮
  Widget reselectButton() {
    return Container(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            if(isRZ){
              showMessage(context, '无法重新选择！');
            }else{
              ApointmentMethod.selectAppointmentDialog(context,ApointmentMethod.recordlist);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("重新选择",style: TextStyle(fontSize: ScreenUtil().setSp(22))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  //重置按钮
  Widget resButton() {
    return Container(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            setState(() {
              _idController.text = '';
              _nameController.text = '';
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("重   置",style: TextStyle(fontSize: ScreenUtil().setSp(22))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  //提交认证按钮
  Widget submitButton() {
    return Container(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setSp(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () {
            if(isRZ){
              showMessage(context, '您已认证成功！请勿重复点击');
            }else{
              isselect = true;
              ApointmentMethod.tijiaoApointmentDialog(context);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("提交认证",style: TextStyle(fontSize: ScreenUtil().setSp(22))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  Widget openIdCard(String str) {
    return RaisedButton(
      onPressed: () {
        isselect = true;
        ApointmentMethod.idcardApointmentDialog(context,1);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
      child: Text(str,style: TextStyle(fontSize: ScreenUtil().setSp(22))),
      //hoverColor: Theme.of(context).primaryColor,
      //splashColor: Colors.black12,
      color: Color.fromRGBO(255,182,0,1),
      textColor: Colors.white);
  }

  //获取预约记录及来访人员信息
  void getAppointmentAndVisit(){
    if(_idController.text==''||_idController.text.length<18){
      showMessage(context,'请将您的基本信息填写完整!');
    }else{
      showProgressDialog(context);
      getuserinfobyidcard(_idController.text);
    }
  }

  //根据身份证号查询预约人员信息
  Future getuserinfobyidcard(String idCard) async {
    String parms = "?idCard="+idCard;
    await requestGet('getuserinfobyidcard',context,parms ).then((val) async{
      if (val != null) {
        IDcardpersonModel idcardModel = IDcardpersonModel.fromJson(val);
        if (idcardModel.code == 0) {
          if(idcardModel.data.userId==null){
            showMessage(context, '未查询到相关信息！');
//            _nameController.text = '';
            countTimer.cancel(); // 取消重复计时
            countTimer = null;
            ProgressDialog.dismiss(context);
          } else{
            if(!isidcard){
              _nameController.text = idcardModel.data.name;
            }
            ApointmentMethod.getinfobyuserid(idcardModel.data.userId, context);
          }
//        }else if(idcardModel.code==40001){
//          showMessage(context, idcardModel.msg);
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) =>LoginWidget()));
        }else{
          showMessage(context, idcardModel.msg);
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          ProgressDialog.dismiss(context);
        }
      }
    });
  }

  RaisedButton con2(){
    return RaisedButton(
        onPressed: () async{
          int count=0;
          String aaa="";
          VisitorIdcard.readIDCard.then((String value){
            aaa = value.toString();
          });
          while(aaa.length==0&&count<20) {
            aaa = await VisitorIdcard.getIDCardInfo;
            count++;
            await Future.delayed(Duration(milliseconds:500 )).then((_){});
          }
          VisitorIdcard.stopreadIDCard;
          if(aaa!=null&&aaa!=""){
            setState(() {
              countTimers.cancel();
              countTimers = null;
              isselect = false;
              Navigator.pop(context);
              _nameController.text = aaa.toString().split('||')[0];
              _idController.text = aaa.toString().split('||')[1];
              getAppointmentAndVisit();
            });
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
        child: Text('',style: TextStyle(fontSize: 22)),
        //hoverColor: Theme.of(context).primaryColor,
        //splashColor: Colors.black12,
        color: Color.fromRGBO(255,182,0,1),
        textColor: Colors.white);
  }
}