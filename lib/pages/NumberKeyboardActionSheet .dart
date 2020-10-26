import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///数字输入键盘,保留两位小数
///
///[controller] 编辑器控制器
// ignore: must_be_immutable
class NumberKeyboardActionSheet extends StatefulWidget {
  TextEditingController controller;
  String title;

  NumberKeyboardActionSheet({
    Key key,
    @required this.controller,this.title,
  }) : super(key: key);

  @override
  _NumberKeyboardActionSheetState createState() => new _NumberKeyboardActionSheetState();
}

class _NumberKeyboardActionSheetState extends State<NumberKeyboardActionSheet> {
  ///键盘上的键值名称
  List<String> _keyNames;
  TextEditingController _controller = new TextEditingController();//键盘上方的controller

  @override
  void initState() {
    _keyNames = ['1', '2', '3', '4', '5', '6', '7', '8', '9', widget.title=="身份证号"?'x':'', '0', '<-'];
    _controller.text = widget.controller.text;
    super.initState();
  }
  ///控件点击事件
  void _onViewClick(String keyName) {
    var currentText = _controller.text; //当前的文本
    if (keyName == '<-') {
      //{回车键}
      if (currentText.length == 0) return;
      _controller.text = currentText.substring(0, currentText.length - 1);
      widget.controller.text = _controller.text;
      return;
    }
    _controller.text = currentText + keyName;
    widget.controller.text = _controller.text;
  }

  ///构建显示数字键盘的视图
  Widget _showKeyboardGridView() {
    List<Widget> keyWidgets = new List();
    for (int i = 0; i < _keyNames.length; i++) {
      keyWidgets.add(
        Material(
          color: Colors.white,
          child: RaisedButton(
            onPressed: () {
              _onViewClick(_keyNames[i]);
            },
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width / 6.0,
              height: ScreenUtil().setSp(72),
              child: Center(
                child: i == _keyNames.length - 1
                    ? Icon(Icons.backspace)
                    : Text(
                  _keyNames[i],
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Color(
                      0xff606060,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Wrap(children: keyWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
//      type: MaterialType.transparency,
//      color: Colors.transparent,
//      shadowColor: Colors.transparent,
      child: IntrinsicHeight(
        child: Container(
          alignment: Alignment.center,
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: ScreenUtil().setSp(80),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color:Colors.white,
                      width: ScreenUtil().setWidth(425),
                      child: TextField(
                        readOnly: true,
                        autofocus: false,
                        controller: _controller,
                        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff9f9f9),
                          errorStyle: TextStyle(
                            color: Color(0xffffb500),
                            fontSize: ScreenUtil().setSp(20.0)
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                      )
                    ),
                    Container(
                        width: ScreenUtil().setSp(100),
                        margin: EdgeInsets.only(left: ScreenUtil().setSp(20)),
                        child:RaisedButton(
                            child: Text("确　定",style: TextStyle(color: Colors.orange, fontSize: ScreenUtil().setSp(25))),
                            colorBrightness: Brightness.light,
                            splashColor: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                            padding: EdgeInsets.all(0.0),
                            onPressed: () async {
                              Navigator.pop(context,true);
                            }
                        )
                    ),
                  ],
                ),
              ),
              Divider(
                height: ScreenUtil().setSp(1),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 1.5,
                height: ScreenUtil().setSp(288),
                child: _showKeyboardGridView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}