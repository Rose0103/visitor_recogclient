////现场资料填写界面
////选择现场登记还是现场认证
//
//import 'dart:async';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter/services.dart';
//import 'package:visitor_recogclient/config/param.dart';
//import 'package:visitor_recogclient/match.dart';
//import 'package:visitor_recogclient/pages/apointment/writerPeersName.dart';
//import 'apointment/apointmentMethod.dart';
//import 'apointment/writerPerson.dart';
//import 'historyquery/historydetailPage.dart';
//import 'personInfo.dart';
//import 'package:visitor_recogclient/otherfunction/dalog.dart';
//import 'package:visitor_recogclient/common/database_helper.dart';
//import 'package:visitor_recogclient/model/visitrecord.dart';
//
//class InputInfoPage extends StatefulWidget {
//  @override
//  InputInfoPageState createState() => InputInfoPageState();
//}
//
//class InputInfoPageState extends State<InputInfoPage> {
//  TextEditingController _nameController = TextEditingController();
//  TextEditingController _idCardController = TextEditingController();
//  TextEditingController _phoneController = TextEditingController();
//  TextEditingController _companyController = TextEditingController();
//  TextEditingController _personNumController = TextEditingController();
//  TextEditingController _reasonController = TextEditingController();
//  TextEditingController _visitorController = TextEditingController();
//  TextEditingController _carNoController = TextEditingController();
//  TextEditingController _commentController = TextEditingController();
//  List<DropdownMenuItem> items = new List<DropdownMenuItem>();
//  List<String> reasonList = ["上访","办事","找人","开会","其他"];
//  final focusNode = FocusNode();
//  List<personInfo> personList = new List();
////  String personName="";
////  String cellPhoneNo="";
////  String idCardNo="";
////  String companyName="";
//  String _selectType;
//  DateTime lastPopTime;
//  Map inputRow = {"受访人":Row(),"来访事由":Row(),"同行人数":Row(),"车牌号":Row(),"备  注":Row(),"姓名":Row()};
//  String str;//提示文字
//  bool match;//用于正则
//  bool nameMatch = false;
//  bool namesMatch = false;
//  Widget sarchWidget = Text("");//搜索提示框
////  List<String> sarchList = ["张一","张二","张三","李四","李五","赵六"];
//  List<String> sarchsList = new List();
//  String suffixText;
//  bool isChageDeptment = false;
//  @override
//  void initState() {
//    super.initState();
//    isadd = false;
//    deleteflatButton = deleteWidget();
//    updateflatButton = updateWidget();
//    for(var i=0;i<reasonList.length;i++){
//      items.add(
//          new DropdownMenuItem(
//              child: Text("　${reasonList[i]}",
//                style: TextStyle(fontSize:ScreenUtil().setSp(20),color:Colors.black),
//              ),
//              value: reasonList[i]
//          )
//      );
//    }
//    WidgetsBinding.instance.addPostFrameCallback((_) {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        color: Colors.white,
//        child: Scaffold(
//            appBar: PreferredSize(
//                child: AppBar(
//                  leading: FlatButton(
//                      child: Row(
//                        children: <Widget>[
//                          Image.asset("assets/images/back.png",fit: BoxFit.fill,),
//                          Text(' 返回',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)
//                        ],
//                      ),
//                      onPressed: () {
//                        Navigator.pop(context);
//                      }
//                  ),
//                  centerTitle: true,
//                  title: Text(
//                    '现场登记',
//                    style: TextStyle(color: Colors.black,
//                        fontSize: ScreenUtil().setSp(30),
//                        fontWeight:FontWeight.w700
//                    ),
//                  ),
//                  backgroundColor: Colors.white,
//                  elevation: 8.0,
//                  brightness: Brightness.light,
//                ),
//                preferredSize: Size.fromHeight(68)
//            ),
//            body: GestureDetector(
//              behavior: HitTestBehavior.translucent,
//              onTap: () {
//                // 触摸收起键盘
//                FocusScope.of(context).requestFocus(FocusNode());
//                setState(() {
//                  sarchWidget = Text("");
//                });
//              },
//              child: SingleChildScrollView(
//                child: Stack(
//                  children: <Widget>[
//                    Positioned(
//                        child: Container(
//                            width: double.infinity,
////                        height: ScreenUtil().setHeight(700),
//                            decoration: BoxDecoration(
//                              image: DecorationImage(
//                                image: AssetImage("assets/images/BG.png"),
//                                fit: BoxFit.fill,
//                              ),
//                            ),
//                            child: Column(
//                              //mainAxisAlignment: MainAxisAlignment.center,
//                              //crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  Container(
//                                      padding: EdgeInsets.fromLTRB(
//                                          ScreenUtil().setSp(0.0),
//                                          ScreenUtil().setSp(20.0),
//                                          ScreenUtil().setSp(0.0),
//                                          ScreenUtil().setSp(10.0)),
////                                      alignment: Alignment.center,
//                                      child: otherInfoWidget()
//                                  ),
//                                  Container(
//                                      padding: EdgeInsets.fromLTRB(
//                                          ScreenUtil().setSp(0.0),
//                                          ScreenUtil().setSp(10.0),
//                                          ScreenUtil().setSp(0.0),
//                                          ScreenUtil().setSp(0.0)
//                                      ),
//                                      alignment: Alignment.center,
//                                      child: personsTableWidget()
//                                  ),
//                                  mainToolButtons(),
//                                ]
//                            )
//                        )
//                    ),
//                    Positioned(
//                      top: ScreenUtil().setSp(62),
//                      left: ScreenUtil().setSp(360),
//                      child: sarchWidget,
//                    )
//                  ],
//                ),
//              ),
//            )
//        )
//    );
//  }
//
//  //搜索功能
//  Widget getSarchWidget(){
//    double h = sarchsList.length*30.0+10;
//    if(h>149.0){
//      h = 149.0;
//    }
//    return Container(
//      child: SizedBox(
//        height: ScreenUtil().setSp(h),
//        width: ScreenUtil().setSp(425),
//        child: ListView.builder(
//          itemExtent: ScreenUtil().setSp(30),
//          itemCount: sarchsList.length,
//          itemBuilder: (BuildContext context,int index){
//            return FlatButton(
//                onPressed: (){
//                  sarchWidget = Text("");
//                  isChageDeptment = true;
//                  nameMatch = true;
//                  _visitorController.text = "${sarchsList[index].substring(0,sarchsList[index].indexOf(" "))}";
//                  suffixText = "${sarchsList[index].substring(sarchsList[index].indexOf("(")+1,sarchsList[index].indexOf(")"))}";
//                  inputRow["受访人"] = helpRow(true, "");
//                  _visitorController.selection = TextSelection.fromPosition(TextPosition(offset: _visitorController.text.length));
//                  inputRow["受访人"] = helpRow(true, " 电话：${sarchsList[index].substring(sarchsList[index].indexOf(")")+1,sarchsList[index].length)}");
//                  setState(() {});
//                },
//                child:Container(
//                  width:ScreenUtil().setSp(425),
//                  height: ScreenUtil().setSp(30),
//                  alignment: Alignment.centerLeft,
//                  child:Text("${sarchsList[index].substring(0,sarchsList[index].indexOf(")")+1)}",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
//                )
//            );
//          },
//        ),
//      ),
//      decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border.all(width: ScreenUtil().setSp(1),color:  Colors.black26,)
//      ),
//    );
//  }
//
//  Widget inputWidget(String title, String tips, bool necessary,
//      TextEditingController textcontroller,TextInputType type) {
//    return Container(
//        margin: EdgeInsets.only(left: ScreenUtil().setSp(30),),
//        child: Row(
////        mainAxisAlignment: MainAxisAlignment.center,
////            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: ScreenUtil().setSp(10.0),
////                alignment: Alignment.center,
//                padding: EdgeInsets.fromLTRB(
//                    ScreenUtil().setSp(0.0),
//                    ScreenUtil().setSp(5.0),
//                    ScreenUtil().setSp(0.0),
//                    ScreenUtil().setSp(title=="受访人"?36.0:5.0)
//                ),
//                child: Text(necessary ? "*" : "  ",
//                    style: TextStyle(
//                        color: Colors.red,
//                        fontSize: ScreenUtil.getInstance().setSp(20)
//                    )
//                ),
//              ),
//              Container(
//                width: ScreenUtil().setSp(80.0),
//                padding: EdgeInsets.fromLTRB(
//                    ScreenUtil().setSp(0.0),
//                    ScreenUtil().setSp(10.0),
//                    ScreenUtil().setSp(0.0),
//                    ScreenUtil().setSp(title=="受访人"?41.0:10.0)
//                ),
//                child: Text(title,
//                    style: TextStyle(
//                        color: Colors.black,
//                        fontSize: ScreenUtil.getInstance().setSp(20)
//                    )
//                ),
//              ),
//              Container(
//                  padding: EdgeInsets.fromLTRB(
//                      ScreenUtil().setSp(15.0),
//                      ScreenUtil().setSp(5.0),
//                      ScreenUtil().setSp(0.0),
//                      ScreenUtil().setSp(5.0)),
//                  width: ScreenUtil().setWidth(425),
////              height: ScreenUtil().setHeight(40.0),
//                  child: title!="来访事由"?TextField(
//                    inputFormatters: title=="同行人数"?[
//                      LengthLimitingTextInputFormatter(3),
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ]:null,
//                    readOnly: title=="车牌号"?true:false,
//                    onTap: (){
////              if(title=="车牌号"){
////                ApointmentMethod.writerCar(context,_carNoController);
////              }
//                      if(title=="受访人"){
//                        if(sarchsList.isEmpty){
//                          sarchWidget = Text("");
//                        }else{
//                          sarchsList.clear();
//                          String s;
//                          for(int i=0;i<sarchList.length;i++){
//                            if(sarchList[i].name.contains(_visitorController.text)||sarchList[i].mobile.contains(_visitorController.text)||sarchList[i].dict.contains(_visitorController.text)){
//                              s = sarchList[i].name+" ("+sarchList[i].orgName+")"+sarchList[i].mobile;
//                              sarchsList.add(s);
//                            }
//                          }
//                          sarchWidget = getSarchWidget();
//                        }
//                        setState(() {});
//                      }
//                    },
//                    onChanged: (text) {
//                      match = true;
//                      if(title=="受访人"){
//                        if(isChageDeptment){//姓名改变后删除部门名称
//                          suffixText = "";
//                          isChageDeptment = false;
//                        }
//                        sarchsList.clear();
//                        String s;
//                        if(text.length!=0){
//                          for(int i=0;i<sarchList.length;i++){
//                            if(sarchList[i].name.contains(_visitorController.text)||sarchList[i].mobile.contains(_visitorController.text)||sarchList[i].dict.contains(_visitorController.text)){
//                              s = sarchList[i].name+" ("+sarchList[i].orgName+")"+sarchList[i].mobile;
//                              sarchsList.add(s);
//                            }
//                          }
//                          sarchWidget = getSarchWidget();
//                        }
//                        str = "受访人姓名格式不正确";
//                        if(text.length>=2&&text.length<=5){
//                          List<String> texts = text.split("");
//                          for(int i=0;i<texts.length;i++){
//                            match = StringMatch.isChinese(texts[i]);
//                            if(!match){
//                              break;
//                            }
//                          }
//                        }else if(text.length==0){
//                          match = false;
//                          sarchWidget = Text("");
//                          str = "受访人姓名不能为空";
//                        }else{
//                          match = false;
//                        }
//                        nameMatch = match;
//                      }else if(title=="姓名"){
//                        str = "姓名格式不正确";
//                        if(text.length>=2&&text.length<=5){
//                          List<String> texts = text.split("");
//                          for(int i=0;i<texts.length;i++){
//                            match = StringMatch.isChinese(texts[i]);
//                            if(!match){
//                              break;
//                            }
//                          }
//                        }else if(text.length==0){
//                          match = false;
//                          str = "姓名不能为空";
//                        }else{
//                          match = false;
//                        }
//                        namesMatch = match;
//                      }
////              else if(title=="来访事由"){
////                str = "来访事由不能为空";
////                if(text.length==0){
////                  match = false;
////                }else{
////                  match = true;
////                }
////              }
////              else if(title=="同行人数"){
////                str = "同行人数不能为空";
////                if(text.length==0){
////                  match = false;
////                }else{
////                  match = true;
////                }
////              }
//                      else{
//                        str = "";
//                      }
//                      if(match){
//                        str = "";
//                      }
//                      if(text==""){
//                        inputRow[title] = Text("");
//                      }else{
//                        inputRow[title] = helpRow(match, str);
//
//                      }
//                      setState(() {
//
//                      });
//                    },
//                    autofocus: false,
//                    controller: textcontroller,
//                    keyboardType: type,
//                    style: TextStyle(fontSize: ScreenUtil().setSp(20)),
//                    decoration: InputDecoration(
//                      hintText: tips,
//                      helperText: title=="受访人"?"支持姓名、拼音首字母以及电话检索":null,
//                      helperStyle: TextStyle(
//                          color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)
//                      ),
//                      filled: true,
//                      suffixText: title=="受访人"?suffixText:null,
//                      fillColor: Color(0xfff9f9f9),
//                      hintStyle: TextStyle(
//                          color: Colors.grey, fontSize: ScreenUtil().setSp(20.0)
//                      ),
//                      errorStyle: TextStyle(
//                          color: Theme.of(context).primaryColor,
//                          fontSize: ScreenUtil().setSp(20.0)
//                      ),
//                      border: OutlineInputBorder(
//                          borderSide: BorderSide(color: Color(0xffebedf5),)
//                      ),
//                      contentPadding: EdgeInsets.all(5.0),
//                    ),
//                  ):
//                  Container(
//                      width: ScreenUtil().setSp(120),
//                      decoration: BoxDecoration(
//                          border: Border.all(width: ScreenUtil().setSp(1),color:  Colors.black26,)
//                      ),
//                      child:DropdownButtonHideUnderline(
//                          child: new DropdownButton(
//                            items: items.map<DropdownMenuItem>((item) {
//                              return item;
//                            }).toList(),
//                            hint: new Text('请选择来访事由',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(19)),),
//                            onChanged: (value){
//                              setState(() {
//                                _selectType = value;
//                                if(_selectType=="其他"){
//                                  _reasonController.text = "";
//                                  inputRow[title] = new Row(
//                                    children: <Widget>[
//                                      Container(
//                                        padding: EdgeInsets.fromLTRB(
//                                            ScreenUtil().setSp(15.0),
//                                            ScreenUtil().setSp(5.0),
//                                            ScreenUtil().setSp(0.0),
//                                            ScreenUtil().setSp(5.0)),
//                                        width: ScreenUtil().setWidth(260),
//                                        child: TextField(
//                                          focusNode: focusNode,
//                                          controller: textcontroller,
//                                          keyboardType: type,
//                                          style: TextStyle(fontSize: ScreenUtil().setSp(20)),
//                                          decoration: InputDecoration(
//                                            hintText: tips,
//                                            filled: true,
//                                            fillColor: Color(0xfff9f9f9),
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey, fontSize: ScreenUtil().setSp(20.0)),
//                                            errorStyle: TextStyle(
//                                                color: Theme.of(context).primaryColor,
//                                                fontSize: ScreenUtil().setSp(20.0)
//                                            ),
//                                            border: OutlineInputBorder(
//                                                borderSide: BorderSide(color: Colors.black26,)
//                                            ),
//                                            contentPadding: EdgeInsets.all(5.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  );
//                                  FocusScope.of(context).requestFocus(focusNode);
//                                }else{
//                                  FocusScope.of(context).requestFocus(new FocusNode());//其他输入框失去焦点
//                                  _reasonController.text = value;
//                                  inputRow[title] = helpRow(true, '');
//                                }
//                              });
//                            },
//                            //              isExpanded: true,
//                            value: _selectType,
//                            elevation: 24,//设置阴影的高度
//                            style: new TextStyle(//设置文本框里面文字的样式
//                              color: Color(0xff4a4a4a),
//                              fontSize: ScreenUtil().setSp(20),
//                            ),
//                            //              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
//                            iconSize: 40.0,
//                          )
//                      )
//                  )
//              ),
//              inputRow[title]
//            ]
//        )
//    );
//  }
//
//  Widget helpRow(bool match,String str){
//    return Row(
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.only(left: ScreenUtil().setSp(18)),
//          child: match?Icon(Icons.check_circle,color: Colors.green,size: ScreenUtil().setSp(28),)
//              :Icon(Icons.error,color: Colors.red,size: ScreenUtil().setSp(28),),
//        ),
//        Container(
//            child: Text(str,style: TextStyle(fontSize: ScreenUtil().setSp(20)),)
//        )
//      ],
//    );
//  }
//
//  Widget toolButtonWidget(String buttontitle, String functionIndex) {
//    return Container(
//      width: ScreenUtil().setWidth(functionIndex=="3"?360.0:200.0),
//      padding: EdgeInsets.fromLTRB(
//          ScreenUtil().setSp(20.0),
//          ScreenUtil().setSp(5.0),
//          ScreenUtil().setSp(20.0),
//          ScreenUtil().setSp(0.0)),
//      child: RaisedButton(
//          child: Text(buttontitle,style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
//          color: Theme.of(context).primaryColor,
//          highlightColor: Theme.of(context).primaryColor,
//          colorBrightness: Brightness.dark,
//          splashColor: Colors.grey,
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//          padding: EdgeInsets.all(0.0),
//          onPressed: () async {
//            if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
//              lastPopTime = DateTime.now();
//              if (functionIndex == "1") {
////                var db = new DatabaseHelper();
////                await db.deleteRecordsAll();
//                Navigator.pop(context);
//              }else if (functionIndex == "2") {
//                saveAndPostVisitData();
//              }else if (functionIndex == "3"&&!isadd) {
//                await showAddPersonInfoDialog(context);
//                setState(() {});
//              }else if (functionIndex == "4") {
//                await showAddPeersInfoDialog(context);
//                setState(() {});
//              }
//            }
//            //setState(() {});
//          }),
//    );
//  }
//
//  //主页最下面的按钮（取消，保存，转发申请）
//  Widget mainToolButtons() {
//    return Container(
//      margin: EdgeInsets.only(top: ScreenUtil().setSp(10)),
//      child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            toolButtonWidget("取　消", "1"),
//            toolButtonWidget("提　交", "2"),
////            toolButtonWidget("转发申请", "1"),
//          ]),
//    );
//  }
//
//  //AAA--同行人信息卡片widget--AAA
//  Widget personsInfoWidget() {
//    return SingleChildScrollView(
//        child:Container(
////      height: ScreenUtil().setHeight(200),
//          width: ScreenUtil().setWidth(700),
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                inputWidget("姓名", "请输入姓名（必填）", true, _nameController,TextInputType.text),
//              ]),
//        ));
//  }
//
//  //其他信息卡片
//  Widget otherInfoWidget() {
//    return Container(
//      //height: ScreenUtil().setHeight(300),
//      width: ScreenUtil().setWidth(830),
//      decoration: new BoxDecoration(
//        border: new Border.all(color: Colors.white70, width: 0.5), // 边色与边宽度
//        boxShadow: [
//          BoxShadow(
//              color: Colors.black12,
//              offset: Offset(5.0, 5.0),
//              blurRadius: 10.0,
//              spreadRadius: 2.0),
//          BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0)),
//          BoxShadow(color: Colors.white30)
//        ],
//      ),
//      child: Column(
//          children: <Widget>[
//            inputWidget("受访人", "请输入受访人姓名（必填）", true, _visitorController, TextInputType.text),
//            inputWidget("来访事由", "请输入来访事由（必填）", true, _reasonController, TextInputType.text),
//            inputWidget("同行人数", "请输入同行人数（选填）", false, _personNumController, TextInputType.number),
//            //            inputWidget("车牌号", "请输入车牌号（选填）", false, _carNoController, TextInputType.text),
//            //            inputWidget("备  注", "请输入备注（选填）", false, _commentController, TextInputType.text),
//            toolButtonWidget("请点击此处登记您的基本信息", "3"),
//          ]
//      ),
//    );
//  }
//
////  //人员表格卡片
//  Widget personsTableWidget() {
//    return Container(
////      height: ScreenUtil().setHeight(300),
//      width: ScreenUtil().setWidth(1000),
//      decoration: new BoxDecoration(
//        border: new Border.all(color: Colors.white70, width: 0.5), // 边色与边宽度
//        boxShadow: [
//          BoxShadow(
//              color: Colors.black12,
//              offset: Offset(5.0, 5.0),
//              blurRadius: 10.0,
//              spreadRadius: 2.0),
//          BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0)),
//          BoxShadow(color: Colors.white30)
//        ],
//      ),
//      child: PaginatedDataTable(
//        header: Row(
//          children: <Widget>[
//            Container(
//              padding:EdgeInsets.only(top: ScreenUtil().setSp(5)),
//              width: ScreenUtil().setSp(5),
//              height: ScreenUtil().setSp(40),
//              child: Image.asset('assets/images/icon17.png',fit: BoxFit.fill,),
//            ),
//            Text('    来访人员',style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),),
//          ],
//        ),
//        rowsPerPage: 5,
////        onSelectAll: (all) {
////          setState(() {
////            personList.forEach((f){
////              f.selected = all;
////            });
////          });
////        },
//        actions: <Widget>[
////          toolButtonWidget("批量添加同行人", "4")
////          IconButton(
////            tooltip:"删除选中人员",
////            icon: Icon(Icons.delete),
////            onPressed: (){
////              setState(() {
////                deleteSelectPerson();
////              });
////            },
////          ),
////          IconButton(
////            tooltip:"编辑选中人员",
////            icon: Icon(Icons.edit),
////            onPressed: () {
////              editPersonInfo();
////            },
////          ),
//          //IconButton(tooltip:"误删除恢复",icon: Icon(Icons.settings_backup_restore),onPressed: (){},),
//        ],
//        columns: [
//          DataColumn(label: centerText("操作")),
//          DataColumn(label: centerText("序号")),
//          DataColumn(label: centerText("姓名")),
//          DataColumn(label: centerText("身份证号")),
//          DataColumn(label: centerText("手机号")),
//          DataColumn(label: centerText("单位名称")),
//        ],
//        source: MyDataTableSource(personList),
//      ),
//    );
//  }
//
//  SizedBox centerText(String text) {
//    return SizedBox(
//      height: ScreenUtil().setSp(20),
//      child: Center(
//        child: Text(
//          text,
//          maxLines: 1,
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20)),
//        ),
//      ),
//    );
//  }
//
////  //删除人员o
//////  void deleteSelectPersn() async{
////    var result = await showDialog(
////        context: context,
////        builder: (context) {
////          return AlertDialog(
////            title: Text('确认删除选中人员？'),
////            actions: <Widget>[
////              FlatButton(
////                child: Text('取消'),
////                onPressed: () {
////                  Navigator.of(context).pop('cancel');
////                },
////              ),
////              deleteflatButton
////            ],
////          );
////        });
////    return result;
////  }
//
//  Widget deleteWidget(){
//    return FlatButton(
//      onPressed: () {
//        if(personList[tableindex].cellphoneNo!=""){
//          isadd = false;
//        }
//        personList.removeAt(tableindex);
////        Navigator.of(context).pop('ok');
//        setState(() {
//        });
//      },
//    );
//  }
//
//  Widget updateWidget(){
//    return FlatButton(
//      child: Text('确认'),
//      onPressed: () async{
//        if(personList[tableindex].cellphoneNo==""){
//          await showEditPersonsInfoDialog(context);
//        }else{
//          await showEditPersonInfoDialog(context);
//        }
//        setState(() {});
//      },
//    );
//  }
//
//  Future showAddPersonInfoDialog(BuildContext context) async{
//    await showGeneralDialog(
//        context: context,
//        // ignore: missing_return
//        pageBuilder: (context, anim1, anim2) {},
//        barrierColor: Colors.grey.withOpacity(.4),
//        barrierDismissible: false,
//        barrierLabel: "",
//        transitionDuration: Duration(milliseconds: 125),
//        transitionBuilder: (context, anim1, anim2, child) {
//          return Transform.scale(
//              scale: anim1.value,
//              child: Opacity(
//                  opacity: anim1.value,
//                  child: WriterPerson(personList)
//              )
//          );
//        }
//    );
//  }
//
//  Future showEditPersonInfoDialog(BuildContext context) async{
//    await showGeneralDialog(
//        context: context,
//        // ignore: missing_return
//        pageBuilder: (context, anim1, anim2) {},
//        barrierColor: Colors.grey.withOpacity(.4),
//        barrierDismissible: false,
//        barrierLabel: "",
//        transitionDuration: Duration(milliseconds: 125),
//        transitionBuilder: (context, anim1, anim2, child) {
//          return Transform.scale(
//              scale: anim1.value,
//              child: Opacity(
//                  opacity: anim1.value,
//                  child: WriterPerson(personList)
//              )
//          );
//        }
//    );
//  }
//
//  Future showEditPersonsInfoDialog(BuildContext context) async{
//    _nameController.text=personList[tableindex].personName;
//    var result = await showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (context) {
//          return GestureDetector(
//            behavior: HitTestBehavior.translucent,
//            onTap: () async {
//              FocusScope.of(context).requestFocus(FocusNode());//点击空白处隐藏键盘
//            },
//            child: AlertDialog(
//              title: Text('编辑同行人信息',style: TextStyle(fontSize: ScreenUtil().setSp(24)),),
//              content: personsInfoWidget(),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('取消',style: TextStyle(fontSize: ScreenUtil().setSp(22)),),
//                  onPressed: () {
//                    Navigator.of(context).pop('cancel');
//                  },
//                ),
//                FlatButton(
//                  child: Text('确认',style: TextStyle(fontSize: ScreenUtil().setSp(22)),),
//                  onPressed: () {
//                    bool flag = true;
//                    if(_nameController.text.trim().length==0) {
//                      inputRow["姓名"] = helpRow(false, "姓名不能为空");
//                      flag = false;
//                    }else if(!namesMatch){
//                      inputRow["姓名"] = helpRow(false, "姓名格式不正确");
//                      flag = false;
//                    }
//                    if(!flag){
//                      setState(() {});
//                      return;
//                    }
//                    personList[tableindex]=personInfo(_nameController.text.trim(), '', '', '' ,false);
//                    _nameController.clear();
//                    Navigator.of(context).pop('ok');
//                  },
//                ),
//              ],
//            ),
//          );
//        }
//    );
//    return result;
//  }
//
//  Future showAddPeersInfoDialog(BuildContext context) async{
//    await showGeneralDialog(
//        context: context,
//        // ignore: missing_return
//        pageBuilder: (context, anim1, anim2) {},
//        barrierColor: Colors.grey.withOpacity(.4),
//        barrierDismissible: false,
//        barrierLabel: "",
//        transitionDuration: Duration(milliseconds: 125),
//        transitionBuilder: (context, anim1, anim2, child) {
//          return Transform.scale(
//              scale: anim1.value,
//              child: Opacity(
//                  opacity: anim1.value,
//                  child: WriterPeersName(personList)
//              )
//          );
//        }
//    );
//  }
//
//  void saveAndPostVisitData() async{
//    bool flag = true;
//    if(_visitorController.text.trim().length==0) {
//      inputRow["受访人"] = helpRow(false, "受访人姓名不能为空");
//      flag = false;
//    }else if(!nameMatch){
//      inputRow["受访人"] = helpRow(false, "受访人姓名格式不正确");
//      flag = false;
//    }
//    if(_reasonController.text.trim().length==0) {
//      if(_selectType!="其他"){
//        inputRow["来访事由"] = helpRow(false, "来访事由不能为空");
//      }else{
//        showMessage(context, "来访事由不能为空");
//      }
//      flag = false;
//    }
////    if(_personNumController.text.trim().length==0) {
////      inputRow["同行人数"] = helpRow(false, "同行人数不能为空");
////      flag = false;
////    }
//    if(!flag){
//      setState(() {});
//      return;
//    }
//    if(personList.length==0) {
//      showMessage(context,"请输入来访人信息");
//      await showAddPersonInfoDialog(context);
//
//      return;
//    }
//    var personPostList=new List();
//    for (int i=0 ;i<personList.length;i++) {
//      var personDate={
//        'idCard':personList[i].idCardNo,
//        'mobile':personList[i].cellphoneNo,
//        'name':personList[i].personName,
//        'tenantName':personList[i].companyName
//      };
//      personPostList.add(personDate);
//    }
//
//    List<String> carNumberList=new List();
//    carNumberList.add(_carNoController.text);
//
////    var data = {
////      'partnerNumber': _personNumController.text ,    //同行人员数量
////      'reservationIncident':carNumberList,   //车牌号
////      'reservationIncident':_reasonController.text, //来访事由
////      'userEmployeeInfoDTOList':personPostList
////    };
//
//    //线上提交一份
////    saveRecords(data);
//    //数据库保存一份
//    var db = new DatabaseHelper();
//    print(_personNumController.text);
//    String visitname;
//    if(suffixText==null||suffixText==""){
//      visitname = _visitorController.text;
//    }else{
//      visitname = _visitorController.text+"("+suffixText+")";
//    }
//    MainInfo mainInfo = new MainInfo(personList[0].personName,personList[0].idCardNo , personList[0].cellphoneNo , visitname ,_reasonController.text ,1, _carNoController.text,_commentController.text,_personNumController.text==''?0:int.parse(_personNumController.text),DateTime.now().toString().split('.')[0]);
//    int recordId = await db.saveRecord(mainInfo);
//    for(int i=0;i<personList.length;i++) {
//      int personId = await db.savePersonData(new Visitorsdb(recordId,personList[i].personName,personList[i].idCardNo , personList[i].cellphoneNo , personList[i].companyName ,"" ));
//      print(personId);
//    }
//    _nameController.clear();
//    _idCardController.clear();
//    _phoneController.clear();
//    _companyController.clear();
//    _personNumController.clear();
//    _commentController.clear();
//    _carNoController.clear();
//    _visitorController.clear();
//    _reasonController.clear();
//    Navigator.push(context,
//        MaterialPageRoute(builder: (context) =>HistoryDetailPage(mainInfo,true,"2",recordId:recordId,visName: personList[0].personName,)));
//  }
//
////  //提交现场登记接口，失败请客下暂时未作处理
////  void saveRecords(var data) async {
////    await request('postsiteregistration', '', formData: data).then((val) async{
////      if (val['code'].toString() == "0") {
////        showMessage(context,val.msg);
////        return;
////      }
////      else showMessage(context,val.msg);
////  });
////}
//}