//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import '../personInfo.dart';
//
//// ignore: must_be_immutable
//class WriterPeersName extends StatefulWidget {
//
//  List<personInfo> personList;
//
//  WriterPeersName(this.personList);
//
//  @override
//  _WriterPeersNameState createState() => _WriterPeersNameState(personList);
//}
//
//class _WriterPeersNameState extends State<WriterPeersName>{
//  String title = '请输入同行人姓名';
//  List<TextEditingController> _peersController = new List<TextEditingController>();
//  List<TextEditingController> _idCardController = new List<TextEditingController>();
//  List<TextEditingController> _temperatureController = new List<TextEditingController>();
//
//  int counts;
//  List<personInfo> personList;
//
//  _WriterPeersNameState(this.personList);
//
//  @override
//  void initState() {
//    super.initState();
//    counts = 2;
//    _peersController.clear();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      type: MaterialType.transparency,
//      //color: Colors.transparent,
//      //shadowColor: Colors.transparent,
//      child: Scaffold(
//        backgroundColor: Colors.transparent,
//        body: GestureDetector(
//          behavior: HitTestBehavior.translucent,
//          onTap: () async {
//            FocusScope.of(context).requestFocus(FocusNode());//点击空白处打后期键盘
//          },
//          child: Center(
//            child: SingleChildScrollView(
//              child: Container(
//                width: ScreenUtil().setSp(930),
//                height: ScreenUtil().setSp(300),
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    SizedBox(height: ScreenUtil().setSp(10),),
//                    Row(
//                      children: <Widget>[
//                        backButtonWidget(),
//                        Container(
//                          width: ScreenUtil().setSp(680),
//                          alignment: Alignment.center,
//                          child:Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
//                        ),
//                        Container(
//                          padding: EdgeInsets.fromLTRB(
//                            ScreenUtil().setSp(0),
//                            ScreenUtil().setSp(0),
//                            ScreenUtil().setSp(0),
//                            ScreenUtil().setSp(0),
//                          ),
//                        ),
//                        FlatButton(
//                          child: Text(' 确定',style: TextStyle(color:Colors.lightBlue,fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
//                          onPressed: () {
//                            for(int i=0;i<counts;i++){
//                              if(_peersController[i].text!=""){
//                                personList.add(personInfo(_peersController[i].text, _idCardController[i].text, '', '' ,false));
//                              }
//                            }
//                            Navigator.pop(context);
//                          },
//                        ),
//                      ],
//                    ),
//                    SizedBox(height: ScreenUtil().setSp(30),),
//                    peersInfoWidget(),
//                    SizedBox(height: ScreenUtil().setSp(30),),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        )
//      ),
//    );
//  }
//
//  Widget peersInfoWidget() {
//    return SingleChildScrollView(
//        child:Container(
//          height: ScreenUtil().setHeight(190),
////          width: ScreenUtil().setWidth(545),
//          child: ListView.builder(
//            padding: EdgeInsets.all(5.0),
//            itemExtent: 70.0,
//            itemCount: counts,
//            itemBuilder: (BuildContext context,int index){
//              _peersController.add(new TextEditingController());
//              _idCardController.add(new TextEditingController());
//              _temperatureController.add(new TextEditingController());
//              return Row(
//                children: <Widget>[
//                  inputWidget("姓名", "请输入同行人姓名", false, _peersController[index], TextInputType.text,40.0,190.0,index: index),
//                  inputWidget("身份证号码", "请输入身份证号码", false, _idCardController[index], TextInputType.number,110.0,230.0,index: index),
//                  inputWidget("体温", "点击测量体温", false, _temperatureController[index], TextInputType.text,40.0,150.0,index: index)
//                ],
//              );
//            },
//          ),
//        )
//    );
//  }
//
//  Widget inputWidget(String title, String tips, bool necessary, TextEditingController textcontroller,
//      TextInputType type,double wid,double inputwidth,{int index}) {
//    return Container(
//        child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: ScreenUtil().setSp(40.0),
//                alignment: Alignment.center,
//                padding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setSp(30.0),
//                  ScreenUtil().setSp(5.0),
//                  ScreenUtil().setSp(0.0),
//                  ScreenUtil().setSp(5.0)
//                ),
//                child: Text(necessary ? "*" : "  ",
//                  style: TextStyle(
//                    color: Colors.red,
//                    fontSize: ScreenUtil.getInstance().setSp(20)
//                  )
//                ),
//              ),
//              Container(
//                width: ScreenUtil().setSp(wid),
//                padding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setSp(0.0),
//                  ScreenUtil().setSp(10.0),
//                  ScreenUtil().setSp(0.0),
//                  ScreenUtil().setSp(10.0)
//                ),
//                child: Text(title,
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontSize: ScreenUtil.getInstance().setSp(20)
//                  )
//                ),
//              ),
//              Container(
//                  padding: EdgeInsets.fromLTRB(
//                    ScreenUtil().setSp(15.0),
//                    ScreenUtil().setSp(5.0),
//                    ScreenUtil().setSp(0.0),
//                    ScreenUtil().setSp(5.0)
//                  ),
//                  width: ScreenUtil().setWidth(inputwidth),
////              height: ScreenUtil().setHeight(40.0),
//                  child: TextFormField(
//                    onTap: (){
//                      setState(() {
//                        if(index==counts-1){
//                          counts++;
//                        }
//                      });
//                    },
//                    autofocus: false,
//                    controller: textcontroller,
//                    keyboardType: type,
//                    style: TextStyle(fontSize: ScreenUtil().setSp(20)),
//                    decoration: InputDecoration(
//                      hintText: tips,
//                      filled: true,
//                      fillColor: Color(0xfff9f9f9),
//                      hintStyle: TextStyle(
//                          color: Colors.grey, fontSize: ScreenUtil().setSp(20.0)),
//                      errorStyle: TextStyle(
//                          color: Theme.of(context).primaryColor,
//                          fontSize: ScreenUtil().setSp(20.0)),
//                      border: OutlineInputBorder(
//                          borderSide: BorderSide(
//                            color: Color(0xffebedf5),
//                          )),
//                      contentPadding: EdgeInsets.all(5.0),
//                    ),
//                  )
//              ),
//            ]
//        )
//    );
//  }
//
//  //返回箭头按钮
//  Widget backButtonWidget() {
//    return Container(
//        child: FlatButton(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  width: ScreenUtil().setSp(40),
//                  height: ScreenUtil().setSp(40),
//                  child: Image.asset("assets/images/back.png",fit: BoxFit.fill,),
//                ),
//                Text(' 返回',style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),)
//              ],
//            ),
//            onPressed: () {
//              Navigator.pop(context);
//            }
//        )
//    );
//  }
//}
