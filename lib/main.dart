import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visitor_recogclient/pages/splashPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:visitor_recogclient/delegate.dart';
import 'dart:async';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  String debugLable = 'Unknown'; //错误信息


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);//隐藏底部栏和顶部状态栏
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
    requestPermission();
    return Container(
      child: MaterialApp(
        localizationsDelegates: [
          CupertinoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US')
        ],
        title: '访客系统认证登记客户端',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          //primaryColor: Colors.blue,
          //primaryColor: Color(0xffff9200),
          primaryColor: Color(0xffffb500),
        ),
        home:SplashPage(),
      ),
    );
  }

  /**
   * 极光推送接入
   */
  //FlutterTts flutterTts;

  /*
  String registerId = null;
  String myMsg;

  _startupJpush() {
    jPush.setup(
        appKey: "95fef60913d4c8caaf8073e9",
        production: false,
        debug: true,
        channel: "flutter_channel");
  }

  _getRegisterID() async {
    registerId = await jPush.getRegistrationID();
    print('registerid=' + registerId);
    return registerId;
  }

  _setPushAlias() async{
    await jPush.setAlias(userID);
  }

  _setPushTag() {
    List<String> tags = List<String>();
    tags.add("NoPost");
    jPush.setTags(tags);
  }

  playLocal() async {
    AudioCache player = new AudioCache();
    const alarmAudioPath = "voice.mp3";
    player.play(alarmAudioPath,volume:1.0);
  }

  _addEventHandler() {
// Future<dynamic>event;
    jPush.addEventHandler(onReceiveNotification: (Map<String, dynamic> event) {
      print('addOnreceive>>>>>>$event');
      String msg = event.putIfAbsent("alert", () => ("")).toString();
      playLocal();
    }, onOpenNotification: (Map<String, dynamic> event) {
      print('addOpenNoti>>>>>$event'); // 点击通知回调方法。
      print(event.toString());
    }, onReceiveMessage: (Map<String, dynamic> event) {
      print('addReceiveMsg>>>>>$event'); //无效的
      print(event.toString());
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    //_initTTs();
   // _startupJpush();
   // _addEventHandler();
   // _getRegisterID();


  }



  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      //Fluttertoast.showToast(msg: "权限申请通过");
    } else {
      Fluttertoast.showToast(msg: "读取权限申请被拒绝");
    }

    Map<PermissionGroup, PermissionStatus> speechs =
    await PermissionHandler().requestPermissions([PermissionGroup.speech]);
    PermissionStatus speech = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.speech);
    if (speech == PermissionStatus.granted) {
      //Fluttertoast.showToast(msg: "权限申请通过");onReceiveNotification
    } else {
      Fluttertoast.showToast(msg: "通知权限申请被拒绝");
    }

    Map<PermissionGroup, PermissionStatus> cameras =
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    PermissionStatus camera = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera);
    if (camera == PermissionStatus.granted) {
      //Fluttertoast.showToast(msg: "权限申请通过");onReceiveNotification
    } else {
      Fluttertoast.showToast(msg: "相机权限申请被拒绝");
    }

    Map<PermissionGroup, PermissionStatus> notification2 =
    await PermissionHandler().requestPermissions([PermissionGroup.notification]);
    PermissionStatus notification = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.notification);
    if (notification == PermissionStatus.granted) {
      //Fluttertoast.showToast(msg: "权限申请通过");onReceiveNotification
    } else {
      Fluttertoast.showToast(msg: "通知权限申请被拒绝");
    }
  }

}
