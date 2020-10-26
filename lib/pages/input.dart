//现场资料填写界面
//选择现场登记还是现场认证
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visitor_idcard/visitor_idcard.dart';
import 'package:visitor_recogclient/base64ToImage.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/match.dart';
import 'package:visitor_recogclient/model/Appointment.dart';
import 'package:visitor_recogclient/pages/getPhoto.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import 'NumberKeyboardActionSheet .dart';
import 'apointment/apointmentMethod.dart';
import 'container/AppointmentRecord.dart';
import 'container/VisitorsPage.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/common/database_helper.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';

class InputWidgetInfoPage extends StatefulWidget {
  @override
  InputWidgetInfoPageState createState() => InputWidgetInfoPageState();
}

class InputWidgetInfoPageState extends State<InputWidgetInfoPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _personNumController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _visitorController = TextEditingController();
  TextEditingController _carNoController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  List<DropdownMenuItem> items = new List<DropdownMenuItem>();
  List<String> reasonList = ["上访","办事","找人","开会","其他"];
  final focusNode = FocusNode();
  String _selectType;
  DateTime lastPopTime;
  Map inputRow = {"受访人":Row(),"来访事由":Row(),"同行人数":Row(),"车牌号":Row(),"备  注":Row(),
    "姓　　名":Row(),"身份证号":Row(),"手机号码":Row(),"单位名称":Row()};
  String str;//提示文字
  bool match = false;//用于正则
  bool nameMatch = false;//判断受访人格式
  bool namesMatch = false;//判断主来访人姓名格式
  bool idCardMatch = false;//判断身份证格式
  bool phoneMatch = true;//判断手机格式
  Widget sarchWidget = Text("");//搜索提示框
  List<String> sarchsList = new List();
  String suffixText;
  bool isChageDeptment = false;
  // ignore: missing_return
  List<Widget> stepList = new List<Widget>();
  int stepIndex;//当前页面
  Widget pageContent;//当前页面内容
  String visitName;//受访人姓名
  Appointment appointment;
  List<Visitorsdb> _data = new List();
  bool isAddApointment = false;
  bool stop = false;
  String addrss = "";
  List<String> intervieweeList = new List();//受访人id
  String interviewee;//受访人id
  String tel;//受访人电话

  @override
  void initState() {
    super.initState();
    imagecontainer = AssetImage("assets/images/icon18.png");
    toBase64 = "";
    stepIndex = 0;
    count = 1;
    for(var i=0;i<reasonList.length;i++){
      items.add(
          new DropdownMenuItem(
              child: Text("　${reasonList[i]}",
                style: TextStyle(fontSize:ScreenUtil().setSp(20),color:Colors.black),
              ),
              value: reasonList[i]
          )
      );
    }
    inputRow["姓　　名"] = new Container(width: ScreenUtil().setSp(46));
    inputRow["身份证号"] = new Container(width: ScreenUtil().setSp(46));
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String st;
    for(var i=0;i<5;i++){
      if(i==0){
        st = "1";
      }else{
        st = "2";
      }
      stepList.add(stepWidget("${i+1}", st));
    }
    if(stepIndex==0){
      pageContent = otherInfoWidget();
    }else if(stepIndex==1){
      pageContent = personInfoWidget();
    }else if(stepIndex==2){
      pageContent = CameraApp();
    }else if(stepIndex==3){
      pageContent = showInfo();
    }else if(stepIndex==4){
      pageContent = lastPageWidget();
      djsGet();
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());//触摸收起键盘
        setState(() {
          sarchWidget = Text("");
        });
      },
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
                  if(stepIndex==1){
                    stop = true;
                    VisitorIdcard.stopreadIDCard;
                  }
                  if(stepIndex==4){
                    countDownTimer.cancel();
                    countDownTimer = null;
                    stepIndex = -1;
                  }
                  Navigator.pop(context);
                }
            ),
            centerTitle: true,
            title: Text(
              '现场登记',
              style: TextStyle(color: Colors.black,
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight:FontWeight.w700
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 8.0,
            brightness: Brightness.light,
          ),
          preferredSize: Size.fromHeight(68)
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/BG.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:ScreenUtil().setSp(30)),
                              height: ScreenUtil().setSp(80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  stepList[0],
                                  Text("---------------",style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24),color: Theme.of(context).primaryColor),),
                                  stepList[1],
                                  Text("---------------",style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24),color: Theme.of(context).primaryColor),),
                                  stepList[2],
                                  Text("---------------",style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24),color: Theme.of(context).primaryColor),),
                                  stepList[3],
                                  Text("---------------",style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24),color: Theme.of(context).primaryColor),),
                                  stepList[4],
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                stepTitleWidget("填写基本信息"),
                                stepTitleWidget("填写访客信息"),
                                stepTitleWidget("人脸录入"),
                                stepTitleWidget("信息确认"),
                                stepTitleWidget("登记完成"),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(ScreenUtil().setSp(10)),
                              height: ScreenUtil().setSp(425),
                              width: ScreenUtil().setWidth(830),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                border: new Border.all(color: Colors.white70, width: 0.5), // 边色与边宽度
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 12.0),
                                  BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0)),
                                  BoxShadow(color: Colors.white30)
                                ],
                              ),
                              child: pageContent
                            ),
                            Container(
                              margin: EdgeInsets.all(ScreenUtil().setSp(10)),
                              height: ScreenUtil().setSp(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  stepIndex==0||stepIndex==4?Text(""):toolButtonWidget("上一步", "2"),
                                  stepIndex==3?toolButtonWidget("提交", "3"):(stepIndex==4?toolButtonWidget("返回", "4"):toolButtonWidget("下一步", "1"))
                                ],
                              ),
                            ),
                          ]
                      )
                  )
              ),
              Positioned(
                top: ScreenUtil().setSp(196-(sarchsList.length*30.0>142?142:sarchsList.length*30.0)),
                left: ScreenUtil().setSp(360),
                child: sarchWidget,
              )
            ],
          ),
        ),
      ),
    );
  }

  //信息展示页面
  Widget showInfo(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(0),
              ScreenUtil().setSp(10),
              ScreenUtil().setSp(0),
              ScreenUtil().setSp(0),
            ),
            child: AppointmentRecord(appointment,showButton: "2",tel:tel,visitName: _nameController.text,dj: true,),//预约记录
          ),
          VisitorsPage(_data,dj: true,)//来访人员
        ],
      ),
    );
  }

  Widget stepTitleWidget(String title){
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setSp(30),
      width: ScreenUtil().setSp(120),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(30), 0, ScreenUtil().setSp(30), 0),
      child: Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(20)
          )
      ),
    );
  }

  Widget stepWidget(String num,String state){
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setSp(60),
      height: ScreenUtil().setSp(60),
      decoration: BoxDecoration(
        border: state=="1"?Border.all(width: 1,color: Color(0xffffb500),):null,
        color: state=="1"?Colors.white:state=="0"?Colors.white:Colors.black26,
        borderRadius: BorderRadius.circular(100),
      ),
      child: state=="0"?
      Icon(Icons.check_circle,color: Theme.of(context).primaryColor,size: ScreenUtil().setSp(60),)
          :Text(
          num,
          style: TextStyle(
              color: state=="1"?Color(0xffffb500):Colors.white,
              fontSize: ScreenUtil.getInstance().setSp(20)
          )
      )
    );
  }

  //搜索功能
  Widget getSarchWidget(){
    double h = sarchsList.length*30.0+10;
    if(h>155.0){
      h = 155.0;
    }
    return Container(
      child: SizedBox(
        height: ScreenUtil().setSp(h),
        width: ScreenUtil().setSp(425),
        child: ListView.builder(
          itemExtent: ScreenUtil().setSp(30),
          itemCount: sarchsList.length,
          itemBuilder: (BuildContext context,int index){
            return FlatButton(
                onPressed: (){
                  sarchWidget = Text("");
                  isChageDeptment = true;
                  nameMatch = true;
                  interviewee = intervieweeList[index];
                  _visitorController.text = "${sarchsList[index].substring(0,sarchsList[index].indexOf(" "))}";
                  suffixText = "${sarchsList[index].substring(sarchsList[index].indexOf("(")+1,sarchsList[index].indexOf(")"))}";
                  inputRow["受访人"] = helpRow(true, "");
                  _visitorController.selection = TextSelection.fromPosition(TextPosition(offset: _visitorController.text.length));
                  tel = " 电话：${sarchsList[index].substring(sarchsList[index].indexOf(")")+1,sarchsList[index].length)}";
                  inputRow["受访人"] = helpRow(true, "");
                  setState(() {});
                },
                child:Container(
                  width:ScreenUtil().setSp(425),
                  height: ScreenUtil().setSp(30),
                  alignment: Alignment.centerLeft,
                  child:Text("${sarchsList[index].substring(0,sarchsList[index].indexOf(")")+1)}",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
                )
            );
          },
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: ScreenUtil().setSp(1),color:  Colors.black26,)
      ),
    );
  }

  Widget inputWidget(String title, String tips, bool necessary,
      TextEditingController textController,TextInputType type) {
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil().setSp(30),),
        child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setSp(10.0),
//                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(5.0),
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(title=="受访人"?36.0:5.0)
                ),
                child: Text(necessary ? "*" : "  ",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil.getInstance().setSp(20)
                    )
                ),
              ),
              Container(
                width: ScreenUtil().setSp(80.0),
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(10.0),
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(title=="受访人"?41.0:10.0)
                ),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(20)
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(15.0),
                    ScreenUtil().setSp(5.0),
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(5.0)),
                width: ScreenUtil().setWidth(425),
//              height: ScreenUtil().setHeight(40.0),
                child: title!="来访事由"?TextField(
                  inputFormatters: title=="同行人数"||title=="身份证号"||title=="手机号码"?[
                    LengthLimitingTextInputFormatter(title=="同行人数"?3:(title=="身份证号"?18:11)),
                    WhitelistingTextInputFormatter.digitsOnly
                  ]:null,
                  readOnly: title=="车牌号"||title=="身份证号"||title=="手机号码"||title=="同行人数"?true:false,
                  onTap: () async{
                    if(title=="车牌号"){
                      ApointmentMethod.writerCar(context,_carNoController);
                    }
                    if(title=="受访人"){
                      if(sarchsList.isEmpty){
                        sarchWidget = Text("");
                      }else{
                        sarchsList.clear();
                        intervieweeList.clear();
                        for(int i=0;i<sarchList.length;i++){
                          if(sarchList[i].name.contains(_visitorController.text)||sarchList[i].mobile.contains(_visitorController.text)||sarchList[i].dict.contains(_visitorController.text)){
                            sarchsList.add(sarchList[i].content);
                            intervieweeList.add(sarchList[i].id);
                          }
                        }
                        sarchWidget = getSarchWidget();
                      }
                      setState(() {});
                    }
                    if(title=="身份证号"||title=="手机号码"||title=="同行人数"){
                      await showModalBottomSheet(
                        context: context,
                        builder: (builder){
                          return NumberKeyboardActionSheet(
                            controller: title=="身份证号"?_idCardController:(title=="手机号码"?_phoneController:_personNumController),
                            title: title,
                          );
                        }
                      );
                      String text = "";
                      if(title=="身份证号"){
                        text = _idCardController.text;
                        str = "身份证号格式不正确";
                        if(text.length==0){
                          str = "身份证号不能为空";
                          match = false;
                        }else if(text.length==18){
                          match = StringMatch.isIdCard(text);
                        }else{
                          match = false;
                        }
                        str = "";
                        idCardMatch = match;
                      }else if(title=="手机号码"){
                        text = _phoneController.text;
                        str = "手机号码格式不正确";
                        if(text.length!=0){
                          match = StringMatch.isChinaPhoneLegal(text);
                        }
                        phoneMatch = match;
                      }else{
                        str = "";
                      }
                      if(match){
                        str = "";
                      }
                      if(text==""&&title=="同行人数"){
                        inputRow[title] = Text("");
                      }else{
                        inputRow[title] = helpRow(match, str);
                      }
                      setState(() {});
                    }
                  },
                  onChanged: (text) {
                    match = true;
                    if(title=="受访人"){
                      if(isChageDeptment){//姓名改变后删除部门名称
                        suffixText = "";
                        isChageDeptment = false;
                      }
                      sarchsList.clear();
                      intervieweeList.clear();
                      if(text.length!=0){
                        for(int i=0;i<sarchList.length;i++){
                          if(sarchList[i].name.contains(_visitorController.text)||sarchList[i].mobile.contains(_visitorController.text)||sarchList[i].dict.contains(_visitorController.text)){
                            sarchsList.add(sarchList[i].content);
                            intervieweeList.add(sarchList[i].id);
                          }
                        }
                        sarchWidget = getSarchWidget();
                      }
                      str = "受访人姓名格式不正确";
                      if(text.length>=2&&text.length<=5){
                        List<String> texts = text.split("");
                        for(int i=0;i<texts.length;i++){
                          match = StringMatch.isChinese(texts[i]);
                          if(!match){
                            break;
                          }
                        }
                      }else if(text.length==0){
                        match = false;
                        sarchWidget = Text("");
                        str = "受访人姓名不能为空";
                      }else{
                        match = false;
                      }
                      nameMatch = match;
                    }else if(title=="姓　　名"){
                      str = "姓名格式不正确";
                      if(text.length>=2&&text.length<=5){
                        List<String> texts = text.split("");
                        for(int i=0;i<texts.length;i++){
                          match = StringMatch.isChinese(texts[i]);
                          if(!match){
                            break;
                          }
                        }
                      }else if(text.length==0){
                        match = false;
                        str = "姓名不能为空";
                      }else{
                        match = false;
                      }
                      str = "";
                      namesMatch = match;
                    }else if(title=="来访事由"){
                      str = "来访事由不能为空";
                      if(text.length==0){
                        match = false;
                      }else{
                        match = true;
                      }
                    }else{
                      str = "";
                    }
                    if(match){
                      str = "";
                    }
                    if(text==""){
                      inputRow[title] = Text("");
                    }else{
                      inputRow[title] = helpRow(match, str);
                    }
                    setState(() {});
                  },
                  autofocus: false,
                  controller: textController,
                  keyboardType: type,
                  style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                  decoration: InputDecoration(
                    hintText: tips,
                    helperText: title=="受访人"?"支持姓名、拼音首字母以及电话检索":null,
                    helperStyle: TextStyle(
                        color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)
                    ),
                    filled: true,
                    suffixText: title=="受访人"?suffixText:null,
                    fillColor: Color(0xfff9f9f9),
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: ScreenUtil().setSp(20.0)
                    ),
                    errorStyle: TextStyle(
                        color: Color(0xffffb500),
                        fontSize: ScreenUtil().setSp(20.0)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffebedf5),)
                    ),
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ):
                Container(
                    width: ScreenUtil().setSp(120),
                    decoration: BoxDecoration(
                        border: Border.all(width: ScreenUtil().setSp(1),color:  Colors.black26,)
                    ),
                    child:DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          items: items.map<DropdownMenuItem>((item) {
                            return item;
                          }).toList(),
                          hint: new Text('请选择来访事由',style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(19)),),
                          onChanged: (value){
                            setState(() {
                              _selectType = value;
                              if(_selectType=="其他"){
                                _reasonController.text = "";
                                inputRow[title] = new Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setSp(15.0),
                                          ScreenUtil().setSp(5.0),
                                          ScreenUtil().setSp(0.0),
                                          ScreenUtil().setSp(5.0)),
                                      width: ScreenUtil().setWidth(260),
                                      child: TextField(
                                        focusNode: focusNode,
                                        controller: textController,
                                        keyboardType: type,
                                        style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                                        decoration: InputDecoration(
                                          hintText: tips,
                                          filled: true,
                                          fillColor: Color(0xfff9f9f9),
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: ScreenUtil().setSp(20.0)),
                                          errorStyle: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: ScreenUtil().setSp(20.0)
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black26,)
                                          ),
                                          contentPadding: EdgeInsets.all(5.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                                FocusScope.of(context).requestFocus(focusNode);
                              }else{
                                FocusScope.of(context).requestFocus(new FocusNode());//其他输入框失去焦点
                                _reasonController.text = value;
                                inputRow[title] = helpRow(true, '');
                              }
                            });
                          },
                          value: _selectType,
                          elevation: 24,//设置阴影的高度
                          style: new TextStyle(//设置文本框里面文字的样式
                            color: Color(0xff4a4a4a),
                            fontSize: ScreenUtil().setSp(20),
                          ),
                          iconSize: 40.0,
                        )
                    )
                )
              ),
              inputRow[title]
            ]
        )
    );
  }

  Widget helpRow(bool match,String str){
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setSp(18)),
          child: match?Icon(Icons.check_circle,color: Colors.green,size: ScreenUtil().setSp(28),)
              :Icon(Icons.error,color: Colors.red,size: ScreenUtil().setSp(28),),
        ),
        Container(
            child: Text(str,style: TextStyle(fontSize: ScreenUtil().setSp(20)),)
        )
      ],
    );
  }

  Widget toolButtonWidget(String buttontitle, String functionIndex) {
    return Container(
      width: ScreenUtil().setWidth(200.0),
      height: ScreenUtil().setWidth(60.0),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(5.0),
          ScreenUtil().setSp(20.0),
          ScreenUtil().setSp(0.0)),
      child: RaisedButton(
          child: Text(buttontitle,style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
          color: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColor,
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(0.0),
          onPressed: () async {
            if (functionIndex == "1") {
             // var db = new DatabaseHelper();
             // await db.deleteRecordsAll();
              nextFunction();//下一步
            }else if (functionIndex == "2") {
              lastFunction();//上一步
            }else if (functionIndex == "3") {
              lastPopTime = DateTime.now();
              saveVisit();
              // postVisit();
              setState(() {
                stepList[stepIndex] = stepWidget("${stepIndex+1}", "0");
                stepList[stepIndex+1] = stepWidget("${stepIndex+2}", "1");
                stepIndex++;
              });
            }else if(functionIndex == "4"){
              countDownTimer.cancel();
              countDownTimer = null;
              Navigator.pop(context);
              stepIndex = -1;
            }
          }),
    );
  }

  //下一步监听事件
  void nextFunction() {
    bool flag = false;
    if(stepIndex==0){
      if(_visitorController.text.trim().length==0) {
        inputRow["受访人"] = helpRow(false, "受访人姓名不能为空");
        flag = true;
      }else if(!nameMatch){
        inputRow["受访人"] = helpRow(false, "受访人姓名格式不正确");
        flag = true;
      }
      if(_reasonController.text.trim().length==0) {
        if(_selectType!="其他"){
          inputRow["来访事由"] = helpRow(false, "来访事由不能为空");
        }else{
          showMessage(context, "来访事由不能为空");
        }
        flag = true;
      }
      if(flag){
        setState(() {});
        return;
      }
      if(suffixText==null||suffixText==""){
        visitName = _visitorController.text;
      }else{
        visitName = _visitorController.text+"("+suffixText+")";
      }
      appointment = new Appointment(visitName, _reasonController.text, _carNoController.text, _personNumController.text, _commentController.text);
    }else if(stepIndex==1){
      if(_nameController.text.trim().length==0) {
        inputRow["姓　　名"] = helpRow(false, "姓名不能为空");
        flag = true;
      }else if(!nameMatch){
        inputRow["姓　　名"] = helpRow(false, "姓名格式不正确");
        flag = true;
      }
      if(_idCardController.text.trim().length==0) {
        inputRow["身份证号"] = helpRow(false, "身份证号不能为空");
        flag = true;
      }else if(!idCardMatch){
        inputRow["身份证号"] = helpRow(false, "身份证号格式不正确");
        flag = false;
      }else if(!phoneMatch){
        inputRow["手机号码"] = helpRow(false, "手机号码格式不正确");
        flag = false;
      }
      if(!isAddApointment){
        _data.add(new Visitorsdb(1, _nameController.text, _idCardController.text, _phoneController.text, _companyController.text, ""));
        isAddApointment = true;
      }
    }
    if(flag){
      setState(() {});
      return;
    }
    setState(() {
      stepList[stepIndex] = stepWidget("${stepIndex+1}", "0");
      stepList[stepIndex+1] = stepWidget("${stepIndex+2}", "1");
      stepIndex++;
    });
    if(stepIndex==1){
     getIdCard();
    }else if(stepIndex==2){
      stop = true;
      VisitorIdcard.stopreadIDCard;
    }else if(stepIndex==3){
      // launch("tel:$tel");
    }
  }

  //上一步监听事件
  void lastFunction(){
    setState(() {
      stepList[stepIndex] = stepWidget("${stepIndex+1}", "2");
      stepList[stepIndex-1] = stepWidget("$stepIndex", "1");
      stepIndex--;
    });
    if(stepIndex==1){
      getIdCard();
    }else if(stepIndex==0){
      stop = true;
      VisitorIdcard.stopreadIDCard;
    }
  }

  //身份证识别
  void getIdCard()async{
    String aaa = "";
    String temp = "";
    VisitorIdcard.readIDCard.then((String value){
      aaa = value.toString();
    });
    while(true) {
      aaa = await VisitorIdcard.getIDCardInfo;
      await Future.delayed(Duration(milliseconds:100 )).then((_){});
      if(aaa!=null&&aaa!=""&&temp!=aaa){
        toBase64 = await VisitorIdcard.toBase64;
        temp=aaa;
        imagecontainer = await Base64ToImage.base642Image(toBase64);
        setState(() {
          _nameController.text = aaa.toString().split('||')[0];
          _idCardController.text = aaa.toString().split('||')[1];
          addrss = aaa.toString().split('||')[2];
          nameMatch = true;
          idCardMatch = true;
          inputRow["姓　　名"] = helpRow(true, "");
          inputRow["身份证号"] = helpRow(true, "");
          image = Container(
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setSp(100),
                ScreenUtil().setSp(40),
                ScreenUtil().setSp(100),
                ScreenUtil().setSp(40)
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imagecontainer,
                fit: BoxFit.fill,
              ),
            ),
          );
          aaa = "";
        });
      }
      if(stop){
        stop = false;
        break;
      }
    }
  }

  //保存本地
  void saveVisit() async{
    var db = new DatabaseHelper();
    MainInfo mainInfo = new MainInfo(_data[0].visitorsTablename,_data[0].visitorsTableidcard,addrss,toBase64,_data[0].visitorsTabletel , visitName ,_reasonController.text ,1, _carNoController.text,_commentController.text,_personNumController.text==''?0:int.parse(_personNumController.text),DateTime.now().toString().split('.')[0]);
    int recordId = await db.saveRecord(mainInfo);
    for(int i=0;i<_data.length;i++) {
      int personId = await db.savePersonData(new Visitorsdb(recordId,_data[i].visitorsTablename,_data[i].visitorsTableidcard , _data[i].visitorsTabletel , _data[i].visitorsTableaddr ,"" ));
      print(personId);
    }
    toBase64 = "";
  }

  //提交后台
  Future postVisit() async{
    var data = {
      "interviewee":interviewee,
      "licenseNumberList": [_carNoController.text],
      "partnerNumber":_personNumController.text,
      "reservationIncident":_reasonController.text,
      "userEmployeeInfoDTOList":{
        "employeeId":'',//员工id
        "idCard":_idCardController.text,
        "mobile":_phoneController.text,
        "name":_nameController.text,
        "tenantName":_companyController.text,
        "userId":''//用户id
      }
    };
    print(data.toString());
    await request('onSiteRegistration', context, '',formData: data).then((val){
      print(val);
    });
  }

  //倒计时结束后自动关闭页面
  djsGet() {
    countDownTimer?.cancel(); //如果已存在先取消置空
    countDownTimer = null;
    countDownTimer = new Timer.periodic(new Duration(seconds: 1), (t) {
      print(t.tick);
      if (10 - t.tick == 0) {
        countDownTimer.cancel();
        countDownTimer = null;
        Navigator.pop(context);
        stepIndex = -1;
      }
    });
  }

  Widget lastPageWidget(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: new AssetImage('assets/images/yes.png'),width: 100,height: 100,),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  '信息登记成功',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: ScreenUtil.getInstance().setSp(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Image(image: new AssetImage('assets/images/qrcode_for.jpg'),width: 300,height: 300,)
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            '扫描上方二维码关注"大敏助手"公众号',
            style: TextStyle(
              color: Colors.orange,
              fontSize: ScreenUtil.getInstance().setSp(24),
            ),
          ),
        )
      ],
  );
}

//其他信息卡片
Widget otherInfoWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          inputWidget("受访人", "请输入受访人姓名（必填）", true, _visitorController, TextInputType.text),
          inputWidget("来访事由", "请输入来访事由（必填）", true, _reasonController, TextInputType.text),
          Text("-----------------------------------以下为选填项-----------------------------------",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
          inputWidget("同行人数", "请输入同行人数（选填）", false, _personNumController, TextInputType.number),
          inputWidget("车牌号", "请输入车牌号（选填）", false, _carNoController, TextInputType.text),
          inputWidget("备  注", "请输入备注（选填）", false, _commentController, TextInputType.text),
        ]
    );
  }

  //其他信息卡片
  Widget personInfoWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
            child:  Text("(提示：将身份证放在屏幕下方读卡器上可快速读取您的身份证信息)",style: TextStyle(fontWeight:FontWeight.w600,fontSize: ScreenUtil().setSp(24)),)
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  inputWidget("姓　　名", "请输入姓名（必填）", true, _nameController,TextInputType.text),
                  inputWidget("身份证号", "请输入身份证号（必填）", true, _idCardController,TextInputType.number),
                ],
              ),
              Container(
                width: ScreenUtil().setSp(120),
                height: ScreenUtil().setSp(120),
                margin: EdgeInsets.only(left: ScreenUtil().setSp(80)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagecontainer,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
          Text("-----------------------------------以下为选填项-----------------------------------",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
          inputWidget("手机号码", "请输入手机号码（选填）", false, _phoneController,TextInputType.number),
          inputWidget("单位名称", "请输入单位名称（选填）", false, _companyController,TextInputType.text),
        ]
    );
  }

  SizedBox centerText(String text) {
    return SizedBox(
      height: ScreenUtil().setSp(20),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20)),
        ),
      ),
    );
  }
}