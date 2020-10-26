import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/httpmodel/employ.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/authentication/FaceVerification.dart';
import 'package:visitor_recogclient/pages/authentication/QRauthenticationPage.dart';
import 'package:visitor_recogclient/pages/input.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import 'ProgressDialog.dart';
import 'authentication/IDcardAuthentication.dart';
import 'historyquery/historyquerymainpage.dart';
import 'inputInfoPage.dart';
import 'loginPage.dart';

class SelectRecCogTypePage extends StatefulWidget {
  @override
  _SelectRecCogTypePageState createState() => _SelectRecCogTypePageState();
}

class _SelectRecCogTypePageState extends State<SelectRecCogTypePage> {

  @override
  void initState() {
    super.initState();
    getOnWorkEmployeeList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  //获取在职员工基本信息
  Future getOnWorkEmployeeList() async {
    await requestGet('getOnWorkEmployeeList',context,"").then((val) async{
      if (val != null) {
        EmployModel employModel = EmployModel.fromJson(val);
        if (employModel.code == 0) {
          sarchList = employModel.data;
        }else{
          showMessage(context, employModel.msg);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>LoginWidget()));
                      }
                  ),
                  centerTitle: true,
                  title: Text(
                    '访客系统登记认证',
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
              width: double.infinity,
              height: ScreenUtil().setHeight(688),
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(303),
                ScreenUtil().setSp(54),
                ScreenUtil().setSp(0),
                ScreenUtil().setSp(0),
              ),
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
                          // FlatButton(
                          //   onPressed: () => launch("tel:13974275925"),
                          //   child: Text("call",style: TextStyle(fontSize: ScreenUtil().setSp(24)),),
                          // ),
                          Container(
                            margin: EdgeInsets.only(bottom: ScreenUtil().setSp(60)),
                            child: Row(
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil.getInstance().setSp(200),
                                    height: ScreenUtil.getInstance().setSp(200),
                                    margin: EdgeInsets.only(left: ScreenUtil().setSp(100)),
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
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: ()
                                      {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>InputWidgetInfoPage()));
                                      },
                                      child: listItem('assets/images/icon4.png','现场登记'),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenUtil.getInstance().setSp(200),
                                    height: ScreenUtil.getInstance().setSp(200),
                                    margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(110.0), ScreenUtil().setSp(0), ScreenUtil().setSp(0.0), ScreenUtil().setSp(0.0)),
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
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => HistoryQueryPage()));
                                      },
                                      child: listItem('assets/images/icon2.png','记录查询'),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil.getInstance().setSp(200),
                                  height: ScreenUtil.getInstance().setSp(200),
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
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                    onPressed: () {
                                      if(openQRrecog){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>QRAuthenticationPage()));
                                      }else{
                                        showMessage(context, '该功能暂未开启！');
                                      }
                                    },
                                    child: listItem('assets/images/icon7.png','二维码认证'),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil.getInstance().setSp(200),
                                  height: ScreenUtil.getInstance().setSp(200),
                                  margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(60.0), ScreenUtil().setSp(0), ScreenUtil().setSp(0.0), ScreenUtil().setSp(0.0)),
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
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                    onPressed: () {
                                      if(openIDcordRecog){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>IDcardAuthenticationPage()));
                                      }else{
                                        showMessage(context, '该功能暂未开启！');
                                      }
                                    },
                                    child: listItem('assets/images/icon6.png','身份证认证'),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil.getInstance().setSp(200),
                                  height: ScreenUtil.getInstance().setSp(200),
                                  margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(60.0), ScreenUtil().setSp(0), ScreenUtil().setSp(0.0), ScreenUtil().setSp(0.0)),
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
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                    onPressed: () {
                                      if(openFaceRecog){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>FaceVerificationPage()));
                                      }else{
                                        showMessage(context, '该功能暂未开启！');
                                      }
                                    },
                                    child: listItem('assets/images/icon5.png','人脸认证'),
                                  ),
                                ),
                              ]
                          ),
                        ],
                      )
                  )
              ),
            )
        )
    );
  }


  Widget listItem(String img,String text){
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setSp(200),
          height: ScreenUtil().setSp(141),
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setSp(50),
            ScreenUtil().setSp(40),
            ScreenUtil().setSp(50),
            ScreenUtil().setSp(40),
          ),
          child: Image.asset(img,fit: BoxFit.fill,),
        ),
        Container(
          width: ScreenUtil().setSp(200),
          height: ScreenUtil().setSp(59),
//          padding: EdgeInsets.fromLTRB(
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(0),
//          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30)
            ),
          ),
        )
      ],
    );
  }
}



