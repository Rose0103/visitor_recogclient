import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_printer_plugin/demo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/common/shared_preference.dart';
import 'package:visitor_recogclient/pages/loginPage.dart';
import 'package:visitor_recogclient/pages/selectRecogTypePage.dart';
import 'package:visitor_recogclient/service/service_method.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'package:visitor_recogclient/model/httpmodel/loginModel.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashPage> {
  Timer timer;
  bool islogin = false;
  String retLoginMessage = " ";
  //String _message = '';
  //String _customJson = '';
  String lastesversion = "0";

  @override
  void initState() {
    super.initState();
    //initXUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = new Timer(const Duration(milliseconds: 1000), () async {
        try {
          //更新升级程序
          /*int version = 121;
          await _getVersion(context);
          if (int.parse(lastesversion.replaceAll(".", "")) > version) {
            if (Platform.isAndroid) {
              String _updateUrl =
                  "http://106.12.144.158:9000/version/update_custom.json";
              FlutterXUpdate.checkUpdate(url: _updateUrl, isCustomParse: true);
            } else {}
          }*/
          Demo.connectdevices;//连接usb
          //读取配置
          String autoLogin= await KvStores.get("autologin");
          //serviceURL=await KvStores.get("serviceURL");
          serverIP=serviceURL;
          acceptEmails = await KvStores.get("acceptEmail");
          //deviceNo=await KvStores.get("deviceID");
          if(autoLogin==null||autoLogin=="1"){
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginWidget()), (
                Route route) =>
            route == null);
          }else{
            await autoLoginServer(deviceNo);
          }
          if (!islogin) {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginWidget()), (
                    Route route) =>
                route == null);
          } else{
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new SelectRecCogTypePage()), (
                Route route) =>
            route == null);
          }
        } catch (e) {}
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1280, height: 720)..init(context);
    return new Material(
      child:  Container(
        decoration: BoxDecoration(
          color:  Colors.orange,
           image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.fill,
            )
        ),
      ),
    );
  }

  void autoLoginServer(String deviceNo) async {
    if (null != deviceNo && deviceNo.trim().length!=0) {
      var data = {
        'terminalCode': deviceNo
      };
      await request('loginBydeviceID',context, '', formData: data).then((val) async{
        if (val.toString() == "false") {
          return;
        }
        if (val != null) {
          loginDataModel loginModel = loginDataModel.fromJson(val);
          retLoginMessage = loginModel.msg;
          if (loginModel.code < 0) {
            showMessage(context,loginModel.msg);
            islogin = false;
          } else if (loginModel.code == 0) {
            islogin = true;
            tenantCode=loginModel.data.tenant.code;
            token = loginModel.data.token.token;
            List<String> cookies = [token,tenantCode];
            KvStores.save("cookies", cookies);
          }
        }
      });
    }
  }

/*
  //版本号获取
  Future _getVersion(BuildContext context) async {
    await requestGet('updateversion', '').then((val) {
      //var data = json.decode(val.toString());
      print("val${val.toString()}");
      updateModel versionModel = updateModel.fromJson(val);
      print("val222${val.toString()}");
      if (versionModel.code == "0") {
        lastesversion = versionModel.data.verison;
        print("获取版本信息成功$lastesversion");
      } else {
        print("获取版本信息失败");
      }
    });
  }



  Future<void> loadJsonFromAsset() async {
    _customJson = await rootBundle.loadString('assets/update_custom.json');
  }

  ///初始化
  void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(

        ///是否输出日志
          debug: true,

          ///是否使用post请求
          isPost: false,

          ///post请求是否是上传json
          isPostJson: false,

          ///是否开启自动模式
          isWifiOnly: false,

          ///是否开启自动模式
          isAutoMode: false,

          ///需要设置的公共参数
          supportSilentInstall: false,

          ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
          enableRetry: false)
          .then((value) {
        updateMessage("初始化成功: $value");
      }).catchError((error) {
        print(error);
      });

//      FlutterXUpdate.setErrorHandler(
//          onUpdateError: (Map<String, dynamic> message) async {
//        print(message);
//        //下载失败
//        if (message["code"] == 4000) {
//          FlutterXUpdate.showRetryUpdateTipDialog(
//              retryContent: "Github被墙无法继续下载，是否考虑切换蒲公英下载？",
//              retryUrl: "https://www.pgyer.com/flutter_learn");
//        }
//        setState(() {
//          _message = "$message";
//        });
//      });

//      FlutterXUpdate.setCustomParseHandler(onUpdateParse: (String json) async {
//        //这里是自定义json解析
//        return customParseJson(json);
//      });

      FlutterXUpdate.setUpdateHandler(
          onUpdateError: (Map<String, dynamic> message) async {
            print(message);
            //下载失败
            if (message["code"] == 4000) {
              FlutterXUpdate.showRetryUpdateTipDialog(
                  retryContent: "Github被墙无法继续下载，是否考虑切换蒲公英下载？",
                  retryUrl: "https://www.pgyer.com/flutter_learn");
            }
            setState(() {
              _message = "$message";
            });
          }, onUpdateParse: (String json) async {
        //这里是自定义json解析
        return customParseJson(json);
      });
    } else {
      updateMessage("ios暂不支持XUpdate更新");
    }
  }

  void updateMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  ///将自定义的json内容解析为UpdateEntity实体类
  UpdateEntity customParseJson(String json) {
    AppInfo appInfo = AppInfo.fromJson(json);
    print(appInfo);
    return UpdateEntity(
        hasUpdate: appInfo.hasUpdate,
        isIgnorable: appInfo.isIgnorable,
        versionCode: appInfo.versionCode,
        versionName: appInfo.versionName,
        updateContent: appInfo.updateLog,
        downloadUrl: appInfo.apkUrl,
        apkSize: appInfo.apkSize);
  }*/
}
