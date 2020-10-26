import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visitor_recogclient/config/param.dart';
import '../base64ToImage.dart';

class CameraApp extends StatefulWidget {

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  List<CameraDescription> cameras;
  Widget leftContainer;
  bool isTakePicture = false;
  Directory file;//人脸目录
  String sDCardDir;//根目录

  @override
  void initState() {
    if(toBase64!=""){
      leftContainer = showImage();
    }else{
      leftContainer = addFaceWidget();
    }
    init();
    super.initState();
  }

  init() async {
    sDCardDir = (await getExternalStorageDirectory()).path;
    file = Directory(sDCardDir+"/"+"visitPhoto");
    bool exists = await file.exists();
    if (!exists) {
      await file.create();
    }
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    deleteAllImage();
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setSp(630),
            height: ScreenUtil().setSp(420),
            child: leftContainer,
          ),
          Container(
            width: ScreenUtil().setSp(180),
            height: ScreenUtil().setSp(425),
            child: takePicture(),
          )
        ],
      ),
    );
  }

  //拍照按钮
  Widget takePicture(){
    return IconButton(
      icon: Icon(Icons.camera_alt),
      iconSize: ScreenUtil().setSp(100),
      color: Colors.black26,
      onPressed: () async {
        if(!isTakePicture){
          return;
        }
        try {
          String path = sDCardDir+'/visitPhoto/${DateTime.now()}.jpg';
          await controller.initialize();
          await controller.takePicture(path);
          toBase64 = await Base64ToImage.image2Base64(path);
          setState(() {
            image = Image.file(File(path),fit:BoxFit.fill);
            leftContainer = showImage();
          });
          isTakePicture = false;
        } catch (e) {
          dispose();
        }
      },
    );
  }

  //清空图片
  void deleteAllImage(){
    List<FileSystemEntity> fileList = file.listSync();
    String filePath;
    if(fileList.isNotEmpty){
      for(int i=0;i<fileList.length;i++){
        filePath = fileList[i].path;
        if(filePath.substring(filePath.length-3,filePath.length)=="jpg"){
          File(filePath).delete();
        }
      }
    }
  }

  //图片展示
  Widget showImage(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: image,
            height: ScreenUtil().setSp(240),
            width: ScreenUtil().setWidth(360),
          ),
          Container(
            child: RaisedButton(
              child: Text("重新拍摄",style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
              color: Color(0xffffb500),
              highlightColor: Color(0xffffb500),
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                setState(() {
                  leftContainer = facePhoto();
                  isTakePicture = true;
                });
              }
            ),
            margin: EdgeInsets.only(top: ScreenUtil().setSp(20)),
            height: ScreenUtil().setSp(36),
            width: ScreenUtil().setWidth(110),
          ),
        ],
      ),
    );
  }

  //摄像头
  Widget facePhoto(){
    if(controller!=null){
      if (!controller.value.isInitialized) {
        return Container();
      }
      return AspectRatio(
        aspectRatio: (controller.value.aspectRatio)*(9/4),
        child: CameraPreview(controller)
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

  //添加人脸
  Widget addFaceWidget(){
    return Container(
      margin: EdgeInsets.all(100),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            leftContainer = facePhoto();
            isTakePicture = true;
          });
        },
        child: Column(
          children: <Widget>[
            horizontalWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                verticalWidget(),
                Text(" +",style: TextStyle(fontSize: ScreenUtil().setSp(120),fontWeight: FontWeight.w200,color: Colors.black26),),
                Text("  点击上传人脸    ",style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.black26),),
                verticalWidget(),
              ],
            ),
            horizontalWidget(),
          ],
        ),
      )
    );
  }

  //竖直方向虚线
  Widget verticalWidget(){
    return DottedLineWidget(
        color:Colors.black26,
        axis: Axis.vertical,
        width: ScreenUtil().setSp(10),
        height: ScreenUtil().setSp(240),
        lineHeight: ScreenUtil().setSp(5),
        lineWidth: ScreenUtil().setSp(1.5),
        count: 10
    );
  }

  //水平方向虚线
  Widget horizontalWidget(){
    return DottedLineWidget(
        color:Colors.black26,
        axis: Axis.horizontal,
        width: ScreenUtil().setSp(320),
        height: ScreenUtil().setSp(10),
        lineHeight: ScreenUtil().setSp(1.5),
        lineWidth: ScreenUtil().setSp(6),
        count: 10
    );
  }
}

//虚线
class DottedLineWidget extends StatelessWidget {
  final Axis axis; // 虚线的方向
  final double width; // 整个虚线的宽度
  final double height; // 整个虚线的高度
  final double lineWidth; // 每根虚线的宽度
  final double lineHeight; // 每根虚线的高度
  final int count; // 虚线内部实线的个数
  final Color color; // 虚线的颜色

  DottedLineWidget({
    Key key,
    @required this.axis,
    this.width,
    this.height,
    this.lineWidth,
    this.lineHeight,
    this.count,
    this.color,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: LayoutBuilder(
        builder: (BuildContext context,BoxConstraints constraints) {
          return Flex(
            direction: this.axis,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(this.count, (int index){
              return SizedBox(
                width: this.lineWidth,
                height: this.lineHeight,
                child: DecoratedBox(decoration: BoxDecoration(color: this.color)),
              );
            }),
          );
        },
      ),
    );
  }
}
