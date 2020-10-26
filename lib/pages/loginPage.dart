//登录页面
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:visitor_recogclient/common/shared_preference.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/httpmodel/loginModel.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/ProgressDialog.dart';
import 'package:visitor_recogclient/pages/selectRecogTypePage.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/pages/configPage.dart';
import 'dart:ui';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController loginController = TextEditingController();

  bool isclick = false;//判断复选框是否选中

  bool islogin = false;
  bool isCorrectPhoneNum = false;
  bool isCorrectPassWd = false;
//  GlobalKey _formKey = GlobalKey();

//  String currentPhoneNum = " ";
//  String currentMassage = " ";
//  int retCheckcode = -1;
//  String retCheckmessage = " ";
  String retLoginMessage = " ";
  DateTime lastPopTime;

//  GlobalKey _globalKey = new GlobalKey(); //用来标记控件
//  String _version; //版本号

  @override

  Widget build(BuildContext context) {
    loginController.text = deviceNo;
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            centerTitle: true,
            title: Text(
              '登录设备',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(30),
                fontWeight: FontWeight.w700
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 8.0,
            leading: Text(''),
            brightness: Brightness.light,
            actions: <Widget>[
              FlatButton (
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>SysSettingPage()));
                },
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Image.asset("assets/images/icon3.png",fit: BoxFit.fill),
                    Text(' 系统设置',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)
                  ],
                )
              ),
            ],
          ),
          preferredSize: Size.fromHeight(68)
        ),
        body: WillPopScope(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0, horizontal: ScreenUtil().setSp(0)),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(700),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/BG.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(443.0),
                      ScreenUtil().setSp(128.0),
                      ScreenUtil().setSp(443.0),
                      ScreenUtil().setSp(208.0)
                  ),
                  alignment: Alignment.center,
                  child: loginContainer(),
                ),
              ),
            ),
          )
        )
    );
  }


  Widget loginContainer(){
    return Container(
      width: ScreenUtil().setSp(480),
//      height: ScreenUtil().setSp(400),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white70, width: 0.5), // 边色与边宽度
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0),
          BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0)),
          BoxShadow(color: Colors.white30)
        ],
      ),
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(24),
              ScreenUtil().setSp(25),
              ScreenUtil().setSp(196),
              ScreenUtil().setSp(0),
            ),
            child: Text(
              '设备号',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'SourceHanSansCN-Regular',
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          Container(
//            height: ScreenUtil().setSp(88),
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(0),
              ScreenUtil().setSp(20),
              ScreenUtil().setSp(0),
              ScreenUtil().setSp(0),
            ),
            child: TextField(
              controller: loginController,
              enabled: false,//禁止输入
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              decoration: InputDecoration(
                  border: InputBorder.none,//去掉输入框的下滑线
                  fillColor: Color.fromRGBO(235, 238, 245, 94.12),
                  filled: true,
                  enabledBorder: null,
                  disabledBorder: null
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(15),
                ScreenUtil().setSp(20),
                ScreenUtil().setSp(0),
                ScreenUtil().setSp(0),
              ),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: autologin,
                    activeColor: Color.fromRGBO(255,182,0,1),
                    onChanged: (bool val) {
                      setState(() {
                        autologin = !autologin;
                        KvStores.save('autologin', autologin?'0':'1');
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(10),
                      ScreenUtil().setSp(0),
                      ScreenUtil().setSp(0),
                      ScreenUtil().setSp(0),
                    ),
                    child: Text(
                      '    自动登录',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'SourceHanSansCN-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  )
                ],
              )
          ),
          loginButton(),
        ],
      ),
    );
  }

  //登录按钮
  Widget loginButton() {
    return Container(
      width: ScreenUtil().setWidth(400),
      height: ScreenUtil().setSp(74),
      padding: EdgeInsets.only(bottom: ScreenUtil().setSp(30)),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(15.0),
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          onPressed: () async {
            if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
              lastPopTime = DateTime.now();
              showProgressDialog(context);
              await login(deviceNo);
              if(islogin) {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SelectRecCogTypePage()));
              }
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
          child: Text("登            录",style: TextStyle(fontSize: ScreenUtil().setSp(24))),
          //hoverColor: Theme.of(context).primaryColor,
          //splashColor: Colors.black12,
          color: Color.fromRGBO(255,182,0,1),
          textColor: Colors.white),
    );
  }

  @override
  void initState() {
    super.initState();
    print('deviceNo=$deviceNo');
    if(deviceNo==null||deviceNo==''){
      showMessage(context, '未能从本地获取到设备号，请完善设备信息!');
      Future.delayed(Duration.zero,(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>SysSettingPage()));
      });
    }else if(serviceURL==null||serviceURL==""){
      showMessage(context, '未能获取到服务器地址，请完善信息!');
      Future.delayed(Duration.zero,(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>SysSettingPage()));
      });
    }else{
      loginController.text = deviceNo;
    }
  }


  void login(String deviceID) async {
    var data = {
      'terminalCode': deviceID
    };
    await request('loginBydeviceID',context, '', formData: data).then((val) async{
      if (val.toString() == "false") {
        return;
      }
      if (val != null) {
        loginDataModel loginModel = loginDataModel.fromJson(val);
        retLoginMessage = loginModel.msg;
        if (loginModel.code < 0) {
          showMessage(context,loginModel.msg);
          islogin = false;
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          ProgressDialog.dismiss(context);
        } else if (loginModel.code == 0) {
          islogin = true;
          token=loginModel.data.token.token;
          tenantCode=loginModel.data.tenant.code;
          List<String> cookies = [token,tenantCode];
          KvStores.save("cookies", cookies);
          KvStores.save("autologin", autologin?"0":"1");
          showMessage(context, '登录成功!');
          countTimer.cancel(); // 取消重复计时
          countTimer = null;
          ProgressDialog.dismiss(context);
        }
      }
    });
  }

}
