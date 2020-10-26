
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_plugin_excle/flutterpluginexcle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_format/date_format.dart' as dateFormat;
import 'package:visitor_recogclient/common/database_helper.dart';
import 'package:visitor_recogclient/common/shared_preference.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import '../../match.dart';

// ignore: must_be_immutable
class OutExcel extends StatefulWidget {
  @override
  OutExcelState createState() => OutExcelState();
}

class OutExcelState extends State<OutExcel>{
  String title = '编辑主来访人信息';
  String str;
  bool match;
  TextEditingController _startTimeController = new TextEditingController();
  TextEditingController _endTimeController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  Widget inputRow = new Row();
  bool emailMatch = false;
  DateTime startDateTime;
  DateTime endDateTime;
  List<MainInfo> recordList;

  @override
  void initState() {
    super.initState();
    if(acceptEmails!=null&&acceptEmails!=""){
      emailMatch = StringMatch.isEmail(acceptEmails);
    }
    _emailController.text = acceptEmails;
    startDateTime = DateTime.now().subtract(new Duration(days: 31));
    endDateTime = DateTime.now();
    _startTimeController.text = dateFormat.formatDate(startDateTime, [dateFormat.yyyy, '-', dateFormat.mm, '-', dateFormat.dd]);
    _endTimeController.text = dateFormat.formatDate(endDateTime, [dateFormat.yyyy, '-', dateFormat.mm, '-', dateFormat.dd]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      //color: Colors.transparent,
      //shadowColor: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());//点击空白处打后期键盘
          },
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: ScreenUtil().setSp(720),
//                height: ScreenUtil().setSp(300),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setSp(10),),
                    Row(
                      children: <Widget>[
                        backButtonWidget(),
                        Container(
                          width: ScreenUtil().setSp(500),
                          alignment: Alignment.center,
                          child:Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setSp(0),
                            ScreenUtil().setSp(0),
                            ScreenUtil().setSp(0),
                            ScreenUtil().setSp(0),
                          ),
                        ),
                        FlatButton(
                          child: Text(' 确定 ',style: TextStyle(color:Colors.lightBlue,fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
                          onPressed: () async {
                            List<String> start = _startTimeController.text.split("-");
                            List<String> end = _endTimeController.text.split("-");
                            String starts = start[0]+start[1]+start[2];
                            String ends = end[0]+end[1]+end[2];
                            if(int.parse(starts)>int.parse(ends)){
                              showMessage(context, "无效时间段!");
                              return;
                            }
                            if(_emailController.text.trim().length==0) {
                              inputRow = helpRow(false, "邮箱不能为空");
                              setState(() {});
                              return;
                            }
                            if(!emailMatch){
                              return;
                            }
                            recordList = await new DatabaseHelper().getRecordsByTimes(_startTimeController.text, _endTimeController.text);
                            if(recordList.isEmpty){
                              showMessage(context, "该时间段无访客记录!");
                              return;
                            }
                            String tableName = start[0]+"年"+isFirstZero(start[1])+"月"+isFirstZero(start[2])+"日-"+
                                end[0]+"年"+isFirstZero(end[1])+"月"+isFirstZero(end[2])+"日来访记录表";
                            List<List> contents = buildContent();
                            Flutterpluginexcle.outExcel(starts+"-"+ends, tableName, rowName, contents,_emailController.text);
                            Navigator.pop(context);
                            if(_emailController.text!=acceptEmails){
                              _showSaveEmailDialog(_emailController.text);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setSp(30),),
                    excelInfoWidget(),
                    SizedBox(height: ScreenUtil().setSp(30),),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  String isFirstZero(String s){
    if(s.substring(0,1)=="0"){
      return s.substring(1,2);
    }else{
      return s;
    }
  }

  List<List> buildContent(){
    List<List> content = new List<List>();
    for(int i=0;i<recordList.length;i++){
      content.add(new List());
      content[i].add("100${i+1}");
      content[i].add(recordList[i].visitTabledatetime);
      content[i].add(recordList[i].visitTableMainPersonName);
      content[i].add(recordList[i].visitTableMainPersonIDCardNo);
      content[i].add(recordList[i].visitAddress==""?" ":recordList[i].visitAddress);
      content[i].add(recordList[i].visitTableMainPersoncellphoneNo==""?" ":recordList[i].visitTableMainPersoncellphoneNo);
      content[i].add(recordList[i].visitTablevisitor);
      content[i].add(recordList[i].visitTablevisitorReason);
      content[i].add(recordList[i].visitTablevisitType==1?"现场登记":"预约访问");
    }
    return content;
  }

  //AAA--主来访人信息卡片widget--AAA
  Widget excelInfoWidget() {
    return SingleChildScrollView(
        child:Container(
//      height: ScreenUtil().setHeight(200),
          width: ScreenUtil().setWidth(800),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                inputWidget("开始时间", "请选择开始时间", false, _startTimeController,TextInputType.text),
                inputWidget("结束时间", "请选择结束时间", false, _endTimeController,TextInputType.text),
                inputWidget("邮箱地址", "请输入邮箱地址", false, _emailController,TextInputType.emailAddress),
              ]),
        ));
  }

  Widget inputWidget(String title, String tips, bool necessary,
      TextEditingController textcontroller,TextInputType type) {
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil().setSp(30)),
        child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setSp(10.0),
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(5.0),
                    ScreenUtil().setSp(0.0),
                    ScreenUtil().setSp(5.0)
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
                    ScreenUtil().setSp(10.0)
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
                  width: ScreenUtil().setWidth(375),
//              height: ScreenUtil().setHeight(40.0),
                  child: TextField(
                    readOnly: title=="开始时间"||title=="结束时间"?true:false,
                    onTap: (){
                      if(title=="开始时间"||title=="结束时间"){
                        _showDatePicker(textcontroller);
                      }
                    },
                    onChanged: (text) {
                      if(title=="邮箱地址") {
                        str = "邮箱格式不正确";
                        if (text.length >= 1) {
                          List<String> texts = text.split("");
                          match = StringMatch.isEmail(text);
                        } else if (text.length == 0) {
                          match = false;
                          str = "邮箱不能为空";
                        } else {
                          match = false;
                        }
                        emailMatch = match;
                      }
                      if(str!=""){
                        inputRow = helpRow(match, str);
                      }
                      setState(() {

                      });
                    },
                    autofocus: false,
                    controller: textcontroller,
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
                          borderSide: BorderSide(color: Color(0xffebedf5),)
                      ),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  )
              ),
              title=="邮箱地址"?inputRow:Text("")
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
            child: match?Text(""):Text(str,style: TextStyle(fontSize: ScreenUtil().setSp(20)),)
        )
      ],
    );
  }

  //返回箭头按钮
  Widget backButtonWidget() {
    return Container(
        child: FlatButton(
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setSp(40),
                  height: ScreenUtil().setSp(40),
                  child: Image.asset("assets/images/back.png",fit: BoxFit.fill,),
                ),
                Text(' 返回',style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),)
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            }
        )
    );
  }

  //日期选择控件
  _showDatePicker(TextEditingController textEditingController) async {
    await DatePicker.showDatePicker(
      context,
      //最小日期限制
      minDateTime: DateTime.parse("2020-01-01"),
      //最大日期限制
      maxDateTime: DateTime.now(),
      //初试日期
      initialDateTime:textEditingController.text.split("-").length!=3?DateTime.now():
      DateTime(int.parse(textEditingController.text.split("-")[0]),
          int.parse(textEditingController.text.split("-")[1]),
          int.parse(textEditingController.text.split("-")[2])),
      dateFormat: 'yyyy年-MM月-dd日',
      locale: DateTimePickerLocale.zh_cn,
      pickerMode: DateTimePickerMode.date,
      onConfirm: (date, i) {
        setState(() {
          textEditingController.text = dateFormat.formatDate(date, [dateFormat.yyyy, '-', dateFormat.mm, '-', dateFormat.dd]);
        });
      },
    );
  }

  //是否更改默认收件人邮箱
  void _showSaveEmailDialog(String email){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示',style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w500),),
          content: Text('是否将$email设置为默认邮箱?',style: TextStyle(color:Colors.black,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w100),),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('取消',style: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w100),),
            ),
            FlatButton(
              onPressed: (){
                acceptEmails = email;
                KvStores.save("acceptEmail", email);
                Navigator.pop(context);
              },
              child: Text('确定',style: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w100),),
            ),
          ],
        );
      }
    );
  }
}
