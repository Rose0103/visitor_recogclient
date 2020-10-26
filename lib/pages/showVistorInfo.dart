// //展示访客信息
// //现场资料填写界面
// //选择现场登记还是现场认证
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/services.dart';
//
// class ShowVisitorInfoPage extends StatefulWidget {
//   @override
//   _ShowVisitorInfoPageState createState() => _ShowVisitorInfoPageState();
// }
//
// class _ShowVisitorInfoPageState extends State<ShowVisitorInfoPage> {
//
//   TextEditingController _urlController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//         color: Colors.white,
//         child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                   icon: Icon(Icons.arrow_back,color: Colors.black,),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//               centerTitle: true,
//               title: Text(
//                 '访客信息',
//                 style: TextStyle(color: Colors.black,
//                     fontSize: ScreenUtil().setSp(40),
//                     fontWeight:FontWeight.w500),
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//               brightness: Brightness.dark,
//               /*   elevation: 0.0,*/
//             ),
//             body: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: () {
//                   // 触摸收起键盘
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 },
//                 child:SingleChildScrollView(
//                     child: Container(
//                         child:Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               otherInfoWidget(),
//                               userInfoWidget(),
//                               userInfoWidget(),
//                               ButtonsWidget()
//                             ])
//                     )
//                 )
//             )
//         )
//     );
//   }
//
//   OutlineInputBorder outlineborders(Color color)
//   {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.all(
//         Radius.circular(30), //边角为30
//       ),
//       borderSide: BorderSide(
//         color: color, //边线颜色为黄色
//         width: 2, //边线宽度为2
//       ),
//     );
//   }
//
//   Widget userInfoWidget()
//   {
//     return Container(
//       padding:
//       EdgeInsets.fromLTRB(ScreenUtil().setSp(20.0), ScreenUtil().setSp(20.0), ScreenUtil().setSp(20.0), ScreenUtil().setSp(20.0)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         //设置四周圆角 角度
//         borderRadius: BorderRadius.all(Radius.circular(30.0)),
//         //设置四周边框
//         border: Border.all(width: 1, color: Colors.black12),
//       ),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("姓名：",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("万超",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("身份证号：",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("430781****12",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("电话：",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("13307**2512",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("单位名称：",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("湖南敏求电子科技有限公司",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//
//           ]),
//     );
//   }
//
//
//
//   Widget otherInfoWidget()
//   {
//     return Container(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("认证通过，同行人数： ",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("4 人",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("来访事由",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("系统维护",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("拜访人",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("小马哥",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                 ]),
//
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("车牌号",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("湘A87511",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//
//                 ]),
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("备注",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         ScreenUtil().setSp(15.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0),
//                         ScreenUtil().setSp(0.0)),
//                     child:Text("约的10点，留下来就餐",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: ScreenUtil.getInstance().setSp(20))),
//                   ),
//           ]),
//     ])
//     );
//   }
//
//   Widget ButtonsWidget()
//   {
//     return Container(
//             width: ScreenUtil.getInstance().setSp(100),
//             height: ScreenUtil.getInstance().setSp(60),
//             decoration: BoxDecoration(
//               color: Colors.blueAccent,
//               //image: DecorationImage(
//               //    image: AssetImage("assets/images/btn_houyt_default.png"),
//               //    fit: BoxFit.fill),
//             ),
//             alignment: Alignment.center,
//             child: FlatButton(
//               //onPressed: _theDayAfter,
//               child: Text('打印凭条'),
//               color: Colors.transparent,
//               //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)), side: BorderSide(color: Colors.white, style: BorderStyle.solid, width: 21)),
//             ),
//           );
//   }
//
//
// }
//
//
//
