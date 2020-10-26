//配置页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:visitor_recogclient/common/shared_preference.dart';
import 'package:visitor_recogclient/config/param.dart';

import 'package:visitor_recogclient/pages/loginPage.dart';

class SysSettingPage extends StatefulWidget {
  @override
  _SysSettingPageState createState() => _SysSettingPageState();
}

class _SysSettingPageState extends State<SysSettingPage> {

  TextEditingController _urlController = TextEditingController();
  TextEditingController _equiController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _urlController.text = serviceURL;
      _equiController.text = deviceNo;
      _emailController.text = acceptEmails;
      _inits();
      setState(() {
      });
    });
  }

  void _inits() async{
    String openface=await KvStores.get("openFace");
    String openQR=await KvStores.get("openQR");
    String openIDcard=await KvStores.get("openIDcard");
    openface=="0"?openFaceRecog=false:openFaceRecog=true;
    openQR=="0"?openQRrecog=false:openQRrecog=true;
    openIDcard=="0"?openIDcordRecog=false:openIDcordRecog=true;
  }

  @override
  Widget build(BuildContext context) {
    _urlController.text=serviceURL;
    _equiController.text=deviceNo;
    return Container(
        //color: Colors.white,
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
                    Navigator.pop(context);
                  }
                ),
                centerTitle: true,
                title: Text(
                  '系统设置',
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
            body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
             child:SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(640),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/BG.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
               child: Container(
                 alignment: Alignment.center,
                 padding: EdgeInsets.fromLTRB(
                     ScreenUtil().setSp(0.0),
                     ScreenUtil().setSp(89.0),
                     ScreenUtil().setSp(0.0),
                     ScreenUtil().setSp(56.0)),
                   child:Column(
                       children: <Widget>[
                       configWidget(),
                       submitButton(context),
                  ]),
                )
             ))
            )
        )
    );
  }

  Widget configWidget()
  {
    return Container(
//        height: ScreenUtil().setHeight(366),
        width: ScreenUtil().setHeight(625),
        decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white70, width: 0.5), // 边色与边宽度
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0), BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.white30)],
        ),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              serverURLWidget(),
              EquipmentNo(),
              acceptEmail(),
              SwitchListTile(
                  title: Text("开启身份证认证",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(22))),
                  value: openIDcordRecog,
                  contentPadding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(10.0),
                      ScreenUtil().setSp(0.0),
                      ScreenUtil().setSp(37.0),
                      ScreenUtil().setSp(0.0)),
                  onChanged: (value) {
                    setState(() {
                      openIDcordRecog=!openIDcordRecog;
                    });
                  }),
                SwitchListTile(
                  title: Text("开启人脸认证",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(22))),
                  value: openFaceRecog,
                  contentPadding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(10.0),
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(37.0),
                    ScreenUtil().setSp(0.0)),
                      onChanged: (value) {
                        setState(() {
                          openFaceRecog=!openFaceRecog;
                        });
                      }),
                  SwitchListTile(
                    title: Text("开启二维码认证",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(22))),
                    value: openQRrecog,
                    contentPadding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(10.0),
                      ScreenUtil().setSp(0.0),
                      ScreenUtil().setSp(37.0),
                      ScreenUtil().setSp(0.0)),
                        onChanged: (value) {
                          setState(() {
                            openQRrecog=!openQRrecog;
                          });
                        }
                      ),
                  ]
        )
    );
  }

  OutlineInputBorder outlineborders(Color color)
  {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30), //边角为30
      ),
      borderSide: BorderSide(
        color: color, //边线颜色为黄色
        width: 2, //边线宽度为2
      ),
    );
  }


  Widget serverURLWidget()
  {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setSp(10.0),
                  ScreenUtil().setSp(20.0),
                  ScreenUtil().setSp(0.0),
                  ScreenUtil().setSp(0.0)),
          child:Text("服务器地址",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setSp(10.0),
                  ScreenUtil().setSp(34.0),
                  ScreenUtil().setSp(0.0),
                  ScreenUtil().setSp(0.0)),
            width: ScreenUtil().setSp(437.0),
            height: ScreenUtil().setSp(80.0),
            child:TextFormField(
            autofocus: false,
            keyboardType: TextInputType.visiblePassword,
            controller: _urlController,
            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
            decoration: InputDecoration(
              //enabledBorder: outlineborders(Colors.grey),
              //focusedBorder: outlineborders(Theme.of(context).primaryColor),
              //errorBorder: outlineborders(Theme.of(context).primaryColor),
              //focusedErrorBorder:outlineborders(Theme.of(context).primaryColor),
              hintText: '请输入服务器地址',
              //hoverColor:  Theme.of(context).primaryColor,
              fillColor: Theme.of(context).primaryColor,
              //focusColor: Theme.of(context).primaryColor,
              hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)),
              errorStyle:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(18.0)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(ScreenUtil().setSp(5.0)),
              // 是否显示密码
            ),
            validator: (v) {
              //return v.trim().length > 5 ? null : '密码长度应在6位以上';
            },
          ))
    ]
    );
  }

  Widget EquipmentNo(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(10.0),
                ScreenUtil().setSp(10.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0)),
            child:Text("设　备　号",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setSp(10.0),
                  ScreenUtil().setSp(30.0),
                  ScreenUtil().setSp(0.0),
                  ScreenUtil().setSp(0.0)),
              width: ScreenUtil().setSp(437.0),
              height: ScreenUtil().setSp(80.0),
              child:TextFormField(
                autofocus: false,
                controller: _equiController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: ScreenUtil().setSp(21)),
                decoration: InputDecoration(
                  //enabledBorder: outlineborders(Colors.grey),
                  //focusedBorder: outlineborders(Theme.of(context).primaryColor),
                  //errorBorder: outlineborders(Theme.of(context).primaryColor),
                  //focusedErrorBorder:outlineborders(Theme.of(context).primaryColor),
                  hintText: '请输入设备号',
                  //hoverColor:  Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                  //focusColor: Theme.of(context).primaryColor,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)),
                  errorStyle:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(18.0)),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(ScreenUtil().setSp(5.0)),
                  // 是否显示密码
                ),
                validator: (v){
                  print(v);
                },
              ))
        ]
    );
  }

  Widget acceptEmail(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(10.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0),
                ScreenUtil().setSp(0.0)),
            child:Text("收件人邮箱",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setSp(10.0),
                  ScreenUtil().setSp(22.0),
                  ScreenUtil().setSp(0.0),
                  ScreenUtil().setSp(0.0)),
              width: ScreenUtil().setSp(437.0),
              height: ScreenUtil().setSp(80.0),
              child:TextFormField(
                autofocus: false,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: ScreenUtil().setSp(21)),
                decoration: InputDecoration(
                  //enabledBorder: outlineborders(Colors.grey),
                  //focusedBorder: outlineborders(Theme.of(context).primaryColor),
                  //errorBorder: outlineborders(Theme.of(context).primaryColor),
                  //focusedErrorBorder:outlineborders(Theme.of(context).primaryColor),
                  hintText: '请输入邮箱地址',
                  //hoverColor:  Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                  //focusColor: Theme.of(context).primaryColor,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)),
                  errorStyle:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(18.0)),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(ScreenUtil().setSp(5.0)),
                  // 是否显示密码
                ),
                validator: (v){
                  print(v);
                },
              ))
        ]
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(149.0),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(56.0),
          ScreenUtil().setSp(0.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          child: Text("确认修改",style: TextStyle(fontSize: ScreenUtil().setSp(28))),
          color: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColor,
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
         shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(0.0),
          onPressed: () async {
            setState(() {
              KvStores.save('deviceID', _equiController.text);
              KvStores.save('serviceURL', _urlController.text);
              KvStores.save('acceptEmail', _emailController.text);
              KvStores.save('openFace', openFaceRecog?'1':'0');
              KvStores.save('openQR', openQRrecog?'1':'0');
              KvStores.save('openIDcard', openIDcordRecog?'1':'0');
              serviceURL=_urlController.text.trim();
              serverIP=serviceURL;
              deviceNo= _equiController.text.trim();
              acceptEmails = _emailController.text.trim();
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>LoginWidget()));
          }),
    );
  }



}



