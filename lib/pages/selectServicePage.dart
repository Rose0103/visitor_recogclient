////选择现场登记还是现场认证
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter/services.dart';
//import 'package:visitor_recogclient/pages/loginPage.dart';
//import 'package:visitor_recogclient/pages/selectRecogTypePage.dart';
//import 'package:visitor_recogclient/pages/inputInfoPage.dart';
//import 'package:visitor_recogclient/pages/historyquery/historyquerymainpage.dart';
//import 'dart:convert';
//
//class selectServicePage extends StatefulWidget {
//  @override
//  _selectServicePageState createState() => _selectServicePageState();
//}
//
//class _selectServicePageState extends State<selectServicePage> {
//
//  TextEditingController _urlController = TextEditingController();
//
//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        color: Colors.white,
//        child: Scaffold(
//            appBar: AppBar(
//              leading: IconButton(
//                  icon: Image.asset("assets/images/back.png"),
//                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) =>LoginWidget()));
//                  }),
//              centerTitle: true,
//              title: Text(
//                '访客系统登记认证',
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: ScreenUtil().setSp(24),
//                    fontWeight: FontWeight.w700),
//              ),
//              backgroundColor: Colors.white,
//              elevation: 8.0,
//              brightness: Brightness.light,
//            ),
//            body: Container(
//                width: ScreenUtil().setSp(1366),
//                height: ScreenUtil().setSp(688),
//                padding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setSp(303),
//                  ScreenUtil().setSp(174),
//                  ScreenUtil().setSp(0),
//                  ScreenUtil().setSp(136),
//                ),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage("assets/images/BG.png"),
//                      fit: BoxFit.fill,
//                    ),
//                    boxShadow: [
//                      BoxShadow(
//                          offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
//                          color: Colors.black12,//投影颜色
//                          blurRadius: ScreenUtil().setSp(12)//投影距离
//                      )
//                    ]
//                ),
//              child: GestureDetector(
//                  behavior: HitTestBehavior.translucent,
//                  onTap: () {
//                    // 触摸收起键盘
//                    FocusScope.of(context).requestFocus(FocusNode());
//                  },
//                  child:SingleChildScrollView(
//                    child:Row(
//                        children: <Widget>[
//                          Container(
//                            width: ScreenUtil.getInstance().setSp(200),
//                            height: ScreenUtil.getInstance().setSp(200),
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                boxShadow: [
//                                  BoxShadow(
//                                      offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
//                                      color: Colors.black12,//投影颜色
//                                      blurRadius: ScreenUtil().setSp(12)//投影距离
//                                  )
//                                ]
//                            ),
//                            alignment: Alignment.center,
//                            child: FlatButton(
//                              onPressed: ()
//                              {
//                                Navigator.push(context,
//                                    MaterialPageRoute(builder: (context) =>inputInfoPage()));
//                              },
//                              child: listItem('assets/images/icon4.png','现场登记'),
//                            ),
//                          ),
//                          Container(
//                            width: ScreenUtil.getInstance().setSp(200),
//                            height: ScreenUtil.getInstance().setSp(200),
//                            margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(60.0), ScreenUtil().setSp(0), ScreenUtil().setSp(0.0), ScreenUtil().setSp(0.0)),
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                boxShadow: [
//                                  BoxShadow(
//                                      offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
//                                      color: Colors.black12,//投影颜色
//                                      blurRadius: ScreenUtil().setSp(12)//投影距离
//                                  )
//                                ]
//                            ),
//                            alignment: Alignment.center,
//                            child: FlatButton(
//                              onPressed: (){
//                                Navigator.push(context,
//                                    MaterialPageRoute(builder: (context) => selectRecogTypePage()));
//                              },
//                              child: listItem('assets/images/icon1.png','访客预约认证'),
//                              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)), side: BorderSide(color: Colors.white, style: BorderStyle.solid, width: 21)),
//                            ),
//                          ),
//                          Container(
//                            width: ScreenUtil.getInstance().setSp(200),
//                            height: ScreenUtil.getInstance().setSp(200),
//                            margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(60.0), ScreenUtil().setSp(0), ScreenUtil().setSp(0.0), ScreenUtil().setSp(0.0)),
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                boxShadow: [
//                                  BoxShadow(
//                                      offset: Offset(ScreenUtil().setSp(6), 0),//x,y轴
//                                      color: Colors.black12,//投影颜色
//                                      blurRadius: ScreenUtil().setSp(12)//投影距离
//                                  )
//                                ]
//                            ),
//                            alignment: Alignment.center,
//                            child: FlatButton(
//                              onPressed: (){
//                                Navigator.push(context,
//                                    MaterialPageRoute(builder: (context) => historyqueryPage()));
//                              },
//                              child: listItem('assets/images/icon2.png','记录查询'),
//                              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)), side: BorderSide(color: Colors.white, style: BorderStyle.solid, width: 21)),
//                            ),
//                          ),
//                        ])
//                  )
//              ),
//            )
//        )
//    );
//  }
//
//
//  Widget listItem(String img,String text){
//    return Column(
//      children: <Widget>[
//        Container(
//          width: ScreenUtil().setSp(200),
//          height: ScreenUtil().setSp(101),
//          padding: EdgeInsets.fromLTRB(
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(57),
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(2),
//          ),
//          child: Image.asset(img),
//        ),
//        Container(
//          width: ScreenUtil().setSp(200),
//          height: ScreenUtil().setSp(99),
//          padding: EdgeInsets.fromLTRB(
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(18),
//            ScreenUtil().setSp(0),
//            ScreenUtil().setSp(52),
//          ),
//          child: Text(
//            text,
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              fontSize: ScreenUtil().setSp(16)
//            ),
//          ),
//        )
//      ],
//    );
//  }
//
//
//
//}
//
//
//
