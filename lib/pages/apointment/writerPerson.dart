
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_idcard/visitor_idcard.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/pages/apointment/apointmentMethod.dart';
import '../../match.dart';
import '../NumberKeyboardActionSheet .dart';
import '../personInfo.dart';

// ignore: must_be_immutable
class WriterPerson extends StatefulWidget {

  List<personInfo> personList;

  WriterPerson(this.personList);

  @override
  WriterPersonState createState() => WriterPersonState(personList);
}

class WriterPersonState extends State<WriterPerson>{
  String title = '编辑主来访人信息';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  int counts;
  List<personInfo> personList;
  static RaisedButton raisedButton;
  Map inputRow = {"姓　　名":Row(),"身份证号":Row(),"手机号码":Row(),"单位名称":Row()};
  String str;//提示文字
  bool match;//用于正则
  bool nameMatch = false;
  bool idCardMatch = false;
  bool phoneMatch = false;

  WriterPersonState(this.personList);

  @override
  void initState() {
    super.initState();
    counts = 2;
    raisedButton = con2();
    if(isadd){
      nameMatch = true;
      idCardMatch = true;
      phoneMatch = true;
      _nameController.text=personList[tableindex].personName;
      _idCardController.text=personList[tableindex].idCardNo;
      _phoneController.text=personList[tableindex].cellphoneNo;
      _companyController.text=personList[tableindex].companyName;
    }
    raisedButton.onPressed();
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
                width: ScreenUtil().setSp(750),
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
//                        FlatButton(
//                          child: Text(' 身份证识别 ',style: TextStyle(color:Colors.lightBlue,fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
//                          onPressed: () {
//                            ApointmentMethod.idcardApointmentDialog(context, 2);
//                          },
//                        ),
                        FlatButton(
                          child: Text(' 确 　定 ',style: TextStyle(color:Colors.lightBlue,fontSize: ScreenUtil().setSp(24),fontWeight: FontWeight.w600),),
                          onPressed: () {
                            bool flag = true;
                            if(_nameController.text.trim().length==0) {
                              inputRow["姓　　名"] = helpRow(false, "姓名不能为空");
                              flag = false;
                            }else if(!nameMatch){
                              inputRow["姓　　名"] = helpRow(false, "姓名格式不正确");
                              flag = false;
                            }
                            if(_idCardController.text.trim().length==0) {
                              inputRow["身份证号"] = helpRow(false, "身份证号不能为空");
                              flag = false;
                            }else if(!idCardMatch){
                              inputRow["身份证号"] = helpRow(false, "身份证号格式不正确");
                              flag = false;
                            }
//                            if(_phoneController.text.trim().length==0) {
//                              inputRow["手机号码"] = helpRow(false, "手机号码不能为空");
//                              flag = false;
//                            }else if(!phoneMatch){
//                              inputRow["手机号码"] = helpRow(false, "手机号码格式不正确");
//                              flag = false;
//                            }
                            if(!flag){
                              setState(() {});
                              return;
                            }
                            if(isadd){
                              personList[tableindex] = personInfo(_nameController.text.trim(), _idCardController.text.trim() , _phoneController.text.trim(), _companyController.text.trim() ,false);
                            }else{
                              personList.add(personInfo(_nameController.text.trim(), _idCardController.text.trim() , _phoneController.text.trim(), _companyController.text.trim() ,false));
                            }
                            isadd = true;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setSp(30),),
                    personInfoWidget(),
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

  //AAA--主来访人信息卡片widget--AAA
  Widget personInfoWidget() {
    return SingleChildScrollView(
        child:Container(
//      height: ScreenUtil().setHeight(200),
          width: ScreenUtil().setWidth(800),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                inputWidget("姓　　名", "请输入姓名（必填）", true, _nameController,TextInputType.text),
                inputWidget("身份证号", "请输入身份证号（必填）", true, _idCardController,TextInputType.number),
//                inputWidget("手机号码", "请输入手机号码（选填）", false, _phoneController,TextInputType.number),
//                inputWidget("单位名称", "请输入单位名称（选填）", false, _companyController,TextInputType.text),
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
                    inputFormatters: title=="身份证号"||title=="手机号码"?[
                      LengthLimitingTextInputFormatter(18),
                      WhitelistingTextInputFormatter.digitsOnly
                    ]:null,
//                    readOnly: title=="手机号码"?true:false,
//                    onTap: () async {
//                      if(title=="手机号码"){
//                        await showModalBottomSheet(
//                            context: context,
//                            builder: (builder){
//                              return NumberKeyboardActionSheet(
//                                controller: _phoneController,
//                              );
//                            }
//                        );
//                        str = "手机号码格式不正确";
//                        if(_phoneController.text.length==0){
//                          str = "手机号码不能为空";
//                          match = false;
//                        }else{
//                          match = StringMatch.isChinaPhoneLegal(_phoneController.text);
//                        }
//                        phoneMatch = match;
//                        setState(() {});
//                      }
//                    },
                    onChanged: (text) {
                      if(title=="姓　　名"){
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
                        nameMatch = match;
                      }else if(title=="身份证号"){
                        str = "身份证号格式不正确";
                        if(text.length==0){
                          str = "身份证号不能为空";
                          match = false;
                        }else{
                          match = StringMatch.isIdCard(text);
                        }
                        idCardMatch = match;
                      }else if(title=="手机号码"){
                        str = "手机号码格式不正确";
                        if(text.length==0){
                          str = "手机号码不能为空";
                          match = false;
                        }else{
                          match = StringMatch.isChinaPhoneLegal(text);
                        }
                        phoneMatch = match;
                      }else{
                        str = "";
                      }
                      if(str!=""){
                        inputRow[title] = helpRow(match, str);
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
              VisitorIdcard.stopreadIDCard;
              Navigator.pop(context);
            }
        )
    );
  }

  //身份证识别
  RaisedButton con2(){
    return RaisedButton(
        onPressed: () async{
          int count=0;
          String aaa="";
          VisitorIdcard.readIDCard.then((String value){
            aaa=value.toString();
          });
          while(aaa.length==0&&count<20) {
            aaa = await VisitorIdcard.getIDCardInfo;
            count++;
            await Future.delayed(Duration(milliseconds:500 )).then((_){
            });
          }
          VisitorIdcard.stopreadIDCard;
          if(aaa!=null&&aaa!=""){
            setState(() {
              _nameController.text = aaa.toString().split('||')[0];
              _idCardController.text = aaa.toString().split('||')[1];
              nameMatch = true;
              idCardMatch = true;
              inputRow["姓　　名"] = helpRow(true, "");
              inputRow["身份证号"] = helpRow(true, "");
            });
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
        child: Text('',style: TextStyle(fontSize: 22)),
        //hoverColor: Theme.of(context).primaryColor,
        //splashColor: Colors.black12,
        color: Color.fromRGBO(255,182,0,1),
        textColor: Colors.white
    );
  }
}
