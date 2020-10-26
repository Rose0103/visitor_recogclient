//现场资料填写界面
//选择现场登记还是现场认证
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/apointment/apointmentMethod.dart';
import 'historyrecords.dart';
import 'package:visitor_recogclient/common/database_helper.dart';
import 'package:visitor_recogclient/model/visitrecord.dart';
import 'package:date_format/date_format.dart' as dateFormat;

class HistoryQueryPage extends StatefulWidget {
  @override
  _HistoryQueryPageState createState() => _HistoryQueryPageState();
}

class _HistoryQueryPageState extends State<HistoryQueryPage> {
  List<MainInfo> recordList = new List();
  String datetime="";    //时间
  String mainPersonName=""; //主来访人姓名
  String idCardNo="";  //身份证号
  String cellphoneNo="";//手机号码
  String visitor="";  //拜访对象
  String visitorReason=""; //拜访事由
  String visitType="1"; //1，现场登记 2.预约访问
  var db;

  FocusNode _commentFocus1 = FocusNode();//控制输入框焦点
  FocusNode _commentFocus2 = FocusNode();//控制输入框焦点

  TextEditingController _searchNameEditingController = new TextEditingController();
  TextEditingController _searchTimeEditingController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  String password = '123456';
  bool autovalidate = false;
  final sureFormkey = GlobalKey<FormState>();
  String buttonText = " 管理员   ";

  void submitButton () {
    if(passController.text != password){
      showMessage(context, '密码错误');
    }else{
      Navigator.pop(context,true);
      setState(() {
        none = true;
        passController.text = "";
        buttonText = " 退出管理员模式   ";
      });
    }
  }


  @override
  void dispose() {
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    none = false;
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      db = new DatabaseHelper();
      recordList = await db.getAllRecords();
      setState(() {

      });
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
                    Text(' 返回',style: TextStyle(fontSize: ScreenUtil().setSp(19),fontWeight: FontWeight.w500),)
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            centerTitle: true,
            title: Text(
              '记录查询',
              style: TextStyle(color: Colors.black,
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight:FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            elevation: 8.0,
            brightness: Brightness.light,
            actions: <Widget>[
              FlatButton (
                  onPressed: () {
                    onStepContinue();
                  },
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/icon5.png",fit: BoxFit.fill),
                      Text(buttonText,style: TextStyle(fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w500),)
                    ],
                  )
              ),
            ],
          ),
          preferredSize: Size.fromHeight(68)
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/BG.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setSp(60.0),
                        ScreenUtil().setSp(40.0),
                        ScreenUtil().setSp(60.0),
                        ScreenUtil().setSp(0.0)),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        recordsTableWidget(),
                        Container(
                          width: ScreenUtil().setWidth(200.0),
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setSp(20.0),
                              ScreenUtil().setSp(20.0),
                              ScreenUtil().setSp(20.0),
                              ScreenUtil().setSp(0.0)),
                          child: RaisedButton(
                              child: Text("报表导出",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
                              color: Theme.of(context).primaryColor,
                              highlightColor: Theme.of(context).primaryColor,
                              colorBrightness: Brightness.dark,
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              padding: EdgeInsets.all(0.0),
                              onPressed: () async {
                                ApointmentMethod.outExcels(context);
                              }
                          ),
                        )
                      ],
                    )
                ),
              )
          ),
        )
      )
    );
  }

  //人员表格卡片
  Widget recordsTableWidget() {
    return Container(
      height: ScreenUtil().setHeight(442),
      width: ScreenUtil().setWidth(1246),
      margin: EdgeInsets.only(top: ScreenUtil().setSp(50)),
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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  header: Text("人员信息", style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(24))),
                  rowsPerPage: 10,
//                  onSelectAll: (all) {
//                    setState(() {
//                      recordlist.forEach((f){
//                        f.selected = all;
//                      });
//                    });
//                  },
                  actions: <Widget>[
                   Text("主来访人姓名：",style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20))),
                   Container(
                     width:  ScreenUtil().setSp(200),
//                     height: ScreenUtil().setSp(20),
                     margin: EdgeInsets.only(right: ScreenUtil().setSp(20)),
                     child:TextField(
                       focusNode: _commentFocus2,
                       controller: _searchNameEditingController,
                       style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                       decoration: InputDecoration(
                         hintText: "请输入主来访人姓名"
                       ),
                      )
                    ),
//                    Container(
//                      width:  ScreenUtil().setSp(80),
//  //                    height: ScreenUtil().setSp(20),
//                      margin: EdgeInsets.only(right: ScreenUtil().setSp(120)),
//                      child:RaisedButton(
//                        child: Text("查询",style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(20))),
//                        colorBrightness: Brightness.light,
//                        splashColor: Colors.grey,
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
//                        padding: EdgeInsets.all(0.0),
//                        onPressed: () async {
//                        }
//                      )
//                    ),
                    Text("拜访日期：",style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20))),
                    Container(
                      width:  ScreenUtil().setSp(150),
//                    height: ScreenUtil().setSp(20),
                      margin: EdgeInsets.only(right: ScreenUtil().setSp(20)),
                      child:TextField(
                        focusNode: _commentFocus1,
                        controller: _searchTimeEditingController,
                        style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                        decoration: InputDecoration(
                          hintText: "请选择拜访日期"
                        ),
                        onTap: (){
                          _commentFocus1.unfocus();    // 失去焦点
                          _showDatePicker();
                        },
                      )
                    ),
                    Container(
                        width:  ScreenUtil().setSp(80),
//                    height: ScreenUtil().setSp(20),
                        margin: EdgeInsets.only(right: ScreenUtil().setSp(20)),
                        child:RaisedButton(
                            child: Text("查询",style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(20))),
                            colorBrightness: Brightness.light,
                            splashColor: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                            padding: EdgeInsets.all(0.0),
                            onPressed: () async {
                              _commentFocus2.unfocus();    // 失去焦点
                              List<MainInfo> recordlists;
                              if(_searchNameEditingController.text==""&&_searchTimeEditingController.text==""){
                                showMessage(context, "请输入查询条件!");
                                recordlists = recordList;
                              }
                              //按时间和日期查
                              if(_searchNameEditingController.text!=""&&_searchTimeEditingController.text!=""){
                                recordlists = await db.getRecordsByNameAndTime(_searchNameEditingController.text,_searchTimeEditingController.text);
                              }
                              //按姓名查
                              if(_searchNameEditingController.text!=""&&_searchTimeEditingController.text==""){
                                recordlists = await db.getRecordsByName(_searchNameEditingController.text);
                              }
                              //按日期查
                              if(_searchNameEditingController.text==""&&_searchTimeEditingController.text!=""){
                                recordlists = await db.getRecordsByTime(_searchTimeEditingController.text);
                              }
                              setState(() {
                                recordList = recordlists;
                              });
                            }
                        )
                    ),
                    Container(
                      width:  ScreenUtil().setSp(80),
//                    height: ScreenUtil().setSp(20),
                      margin: EdgeInsets.only(right: ScreenUtil().setSp(20)),
                      child:RaisedButton(
                        child: Text("初始化",style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(20))),
                        colorBrightness: Brightness.light,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                        padding: EdgeInsets.all(0.0),
                        onPressed: () async {
                          _searchTimeEditingController.text = "";
                          _searchNameEditingController.text = "";
                          List<MainInfo> recordlists;
                          recordlists = await db.getAllRecords();
                          setState(() {
                            recordList = recordlists;
                          });
                        }
                      )
                    ),
                  ],
                  columns: none?[
                    DataColumn(label: centerText("详情")),
                    DataColumn(label: centerText("来访时间")),
                    DataColumn(label: centerText("主来访人")),
                    DataColumn(label: centerText("身份证号")),
                    DataColumn(label: centerText("手机号")),
                    DataColumn(label: centerText("家庭住址")),
                    DataColumn(label: centerText("拜访对象")),
                    DataColumn(label: centerText("拜访事由")),
                    DataColumn(label: centerText("类型")),
                  ]:[
                    DataColumn(label: centerText("详情")),
                    DataColumn(label: centerText("来访时间")),
                    DataColumn(label: centerText("主来访人")),
                    DataColumn(label: centerText("身份证号")),
                    DataColumn(label: centerText("手机号")),
                    DataColumn(label: centerText("拜访对象")),
                    DataColumn(label: centerText("拜访事由")),
                    DataColumn(label: centerText("类型")),
                  ],
                  source: RecordDataTableSource(context,recordList),
                ),
              ),
            ),
          ]
      ),
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
          style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(22)),
        ),
      ),
    );
  }

  //日期选择控件
  _showDatePicker() async {
    await DatePicker.showDatePicker(
      context,
      //最小日期限制
      minDateTime: DateTime.parse("2020-01-01"),
      //最大日期限制
      maxDateTime: DateTime.now(),
      //初试日期
      initialDateTime:_searchTimeEditingController.text.split("-").length!=3?DateTime.now():
        DateTime(int.parse(_searchTimeEditingController.text.split("-")[0]),
            int.parse(_searchTimeEditingController.text.split("-")[1]),
            int.parse(_searchTimeEditingController.text.split("-")[2])),
      dateFormat: 'yyyy年-MM月-dd日',
      locale: DateTimePickerLocale.zh_cn,
      pickerMode: DateTimePickerMode.date,
      onConfirm: (date, i) {
        setState(() {
          _searchTimeEditingController.text = dateFormat.formatDate(date, [dateFormat.yyyy, '-', dateFormat.mm, '-', dateFormat.dd]);
        });
      },
    );
  }

  //点击按钮执行的操作
  void onStepContinue (){
    if(buttonText==" 管理员   "){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                '请输入管理员密码',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: ScreenUtil().setSp(22.0)),
              ),
              content: Container(
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(80),
                child: Form(
                  key: sureFormkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 6,
                          obscureText: true,
                          controller: passController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: "请输入管理员密码",
                            helperStyle: TextStyle(
                                color: Colors.grey, fontSize: ScreenUtil().setSp(18.0)
                            ),
                            filled: true,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Container(
                  width:  ScreenUtil().setSp(80),
                  margin: EdgeInsets.all(ScreenUtil().setSp(20)),
                  child: RaisedButton(child: Text('取消',style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(20))),
                    colorBrightness: Brightness.light,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                    padding: EdgeInsets.all(0.0),
                    onPressed: (){
                      Navigator.pop(context);
                      this.passController.text = "";
                    },),
                ),
                Container(
                  width:  ScreenUtil().setSp(80),
                  margin: EdgeInsets.all(ScreenUtil().setSp(20)),
                  child: RaisedButton(child: Text('确认',style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(20))),
                      colorBrightness: Brightness.light,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        submitButton();
                      }),
                )

              ],
            );
          });
    }else{
      setState(() {
        none = false;
        buttonText = " 管理员   ";
      });
    }
  }

}
