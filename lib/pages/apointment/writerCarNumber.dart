
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:license_plate_number/license_plate_number.dart';

// ignore: must_be_immutable
class WriterCarNumber extends StatefulWidget {

  TextEditingController carNoController;

  WriterCarNumber(this.carNoController);

  @override
  _WriterCarNumberState createState() => _WriterCarNumberState(carNoController);
}

class _WriterCarNumberState extends State<WriterCarNumber>{
  String title = '请输入车牌号';
  String  confirm = '确定';
  bool isnewcars;
  List<String> cars;
  KeyboardController _keyboardController = new KeyboardController();

  TextEditingController carNoController;

  _WriterCarNumberState(this.carNoController);

  @override
  void initState() {
    super.initState();
    cars = ["","","","","","",""];
    isnewcars = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setSp(200.0),
              ScreenUtil().setSp(0.0),
              ScreenUtil().setSp(200.0),
              ScreenUtil().setSp(40.0)),
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
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: isnewcars,
                            activeColor: Color.fromRGBO(255,182,0,1),
                            onChanged: (bool val) {
                              setState(() {
                                isnewcars = !isnewcars;
                                if(isnewcars){
                                  cars.add("");
                                }else{
                                  cars.removeLast();
                                  _keyboardController.dispose();
                                  _keyboardController.hideKeyboard();
                                }
//                                carwidgt = _cars(cars);
                              });
                            },
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setSp(10),
                              ScreenUtil().setSp(0),
                              ScreenUtil().setSp(0),
                              ScreenUtil().setSp(0),
                            ),
                            child: Text(
                              ' 新能源车牌',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'SourceHanSansCN-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(24),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setSp(30),),
              _cars(cars),
              SizedBox(height: ScreenUtil().setSp(30),),
//              SizedBox(height: ScreenUtil().setSp(30),),
            ],
          ),
        ),
      ),
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

  Widget _cars(List<String> cars){
    return PlateInputField(
      keyboardController: _keyboardController,
      plateNumbers: cars,
      styles: PlateStyles(
        plateInputFieldTextStyle: TextStyle(
          fontSize: ScreenUtil().setSp(40),
        ),
        newEnergyPlaceHolderTextStyle: TextStyle(
          fontSize: ScreenUtil().setSp(12),
        ),
      ),
      inputFieldWidth: ScreenUtil().setSp(50),
      inputFieldHeight: ScreenUtil().setSp(64),
      onChanged: (List<String> array, String value) {
        if(isnewcars&&value.length==8){
          carNoController.text = value;
          Navigator.pop(context,true);
        }
        if(!isnewcars&&value.length==7){
          _keyboardController.dispose();
          _keyboardController.hideKeyboard();
          carNoController.text = value;
          Navigator.pop(context,true);
        }
      },
    );
  }
}
