import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/authentication/FaceVerification.dart';
import 'detector_painters.dart';
import 'imageLib.dart';
import 'utils.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'dart:ui';
import 'package:visitor_recogclient/config/param.dart';


class FaceDetectPage extends StatefulWidget {
  @override
  _FaceDetectPageState createState() => _FaceDetectPageState();
}

class _FaceDetectPageState extends State<FaceDetectPage> {
  dynamic _scanResults;
  CameraController _camera;
  Detector _currentDetector = Detector.face;
  bool _isDetecting = false;
  bool _isenableLandmarks = false;
  bool _isenableContours = false;
  String _messaga = "开始采集";
  bool isdetect = true;

  CameraLensDirection _direction = CameraLensDirection.back;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void setMessage(String message) {
    setState(() {
      _messaga = message;
    });
  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);
    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );
    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.medium
          : ResolutionPreset.high,

    );

    await _camera.initialize();
    bool isfirsttime = true;
    int count=0;
    _camera.startImageStream((CameraImage image) async {
      if (isfirsttime)  isfirsttime = false;
        //await Future.delayed(Duration(seconds: 2), () async {
        //  isfirsttime = false;
       // });
      if (!_isDetecting) {
        _isDetecting = true;
        fullPicPath = "";
        facePicPath = "";
        detectFace = null;
        List<Face> faces = new List();
        detect(image, _getDetectionMethod(), rotation).then(
              (dynamic result) async {
                setState(() {
                  _scanResults = result;
                });
                faces = _scanResults;
                int len = faces.length;
                if (isdetect) {
                  if (len == 0) {
                    setMessage("未检测到人脸");
                    _isDetecting = false;
                    return 0;
                  }
                }
                int maxFaceNum = 0;
                double size = 0.0;
                setMessage('检测到人脸数：$len');
                for (int i = 0; i < faces.length; i++) {
                  Face facetemp = faces[i];
                  if (size <
                      facetemp.boundingBox.width *
                          facetemp.boundingBox.height) {
                    size = facetemp.boundingBox.width *
                        facetemp.boundingBox.height;
                    maxFaceNum = i;
                  }
                }

                if (isdetect) {
                  if (faces[maxFaceNum].boundingBox.width *
                      faces[maxFaceNum].boundingBox.height <
                      120 * 120) {
                    setMessage("请靠近屏幕一点");
                    _isDetecting = false;
                    return 0;
                  }

                  final Size imagsize = Size(
                    _camera.value.previewSize.height,
                    _camera.value.previewSize.width,
                  );
                  final Size widgetsize = Size(
                    painterWidgetWidth,
                    painterWidgetHeiht,
                  );
                  String direction = "bak";
                  if (_direction == CameraLensDirection.front)
                    direction = "front";

                  Rect rectface = _scaleRect(
                      rect: faces[maxFaceNum].boundingBox,
                      imageSize: imagsize,
                      widgetSize: widgetsize,
                      direct: direction);
                  int count = 0;
                  if (rectface.left < 2.0) count++;
                  if (rectface.right < 2.0) count++;
                  if (rectface.top < 2.0) count++;
                  if (rectface.bottom < 2.0) count++;
                  if (count >= 2) {
                    setMessage("请离屏幕远一点");
                    _isDetecting = false;
                    return 0;
                  }

                  if (count == 1) {
                    setMessage("请将人脸放入屏幕中心位置");
                    _isDetecting = false;
                    return 0;
                  }

                  if (faces[maxFaceNum].headEulerAngleY.toDouble().abs() >
                      6.0) {
                    setMessage("左右测脸角度过大，请调整到正脸");
                    _isDetecting = false;
                    return 0;
                  }

                  if (faces[maxFaceNum].headEulerAngleZ.toDouble().abs() >
                      5.0) {
                    setMessage("抬头或低头角度过大，请调整到正脸");
                    _isDetecting = false;
                    return 0;
                  }
                }

                double xmin = faces[maxFaceNum].boundingBox.centerLeft.dx
                    .toDouble();
                double width = faces[maxFaceNum].boundingBox.width.toDouble();
                double ymin = faces[maxFaceNum].boundingBox.topCenter.dy
                    .toDouble();
                double height = faces[maxFaceNum].boundingBox.height.toDouble();
                facePicPath = "";
                await convertImagetoPng(image, xmin, ymin, width, height);
                setMessage("人脸正常,检测到人脸数：$len，正在保存");

                /*
            上传人脸图片验证
             */
                count++;
                await FaceVerificationPageState.getuserinfobyFace(context);
                if (facebol) {
                  _messaga == "人脸保存成功,即将跳转";
                  if (_camera != null &&
                      _camera.value.isInitialized &&
                      _camera.value.isStreamingImages) {
                    await _camera.stopImageStream();
                    await _camera.dispose();
                    setState(() {
                      _camera = null;
                    });
                  }
                  isselect = false;
                  Navigator.pop(context);
                  showProgressDialog(context);
                  return 0;
                }else if(count>3){
                  showMessage(context, "未查到人脸数据,请重试！");
                  if (_camera != null &&
                      _camera.value.isInitialized &&
                      _camera.value.isStreamingImages) {
                    await _camera.stopImageStream();
                    await _camera.dispose();
                    setState(() {
                      _camera = null;

                    });
                  }
                  isselect = false;
                  facePicPath = "";
                  Navigator.pop(context);

                  return 0;
                }
                else {
                  showMessage(context, "识别人脸失败！");
                  if (_camera != null &&
                      _camera.value.isInitialized &&
                      _camera.value.isStreamingImages) {
                    await _camera.stopImageStream();
                    await _camera.dispose();
                    setState(() {
                      _camera = null;
                    });
                  }
                  _isDetecting = false;
                  return 0;
                }
              }
        ).catchError(
              (_) {
//            setMessage("请将人脸放入屏幕中心位置");
            _isDetecting = false;
          },
        );
      }
    });
  }

  HandleDetection _getDetectionMethod() {
    final faceDetector = FirebaseVision.instance.faceDetector(
        FaceDetectorOptions(
            enableClassification: true,
            enableLandmarks: _isenableLandmarks,
            enableContours: _isenableContours,
            enableTracking: true));
    return faceDetector.processImage;
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }

  Widget textWidget() {
    return Container(
      constraints: new BoxConstraints.expand(
        height: Theme
            .of(context)
            .textTheme
            .display1
            .fontSize * 1.1 + 50.0,
      ),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: new Text(_messaga,
          style: Theme
              .of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.black
          )
      ),
    );
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('No results!');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(

      _camera.value.previewSize.width,
      _camera.value.previewSize.height,

    );

    if (_scanResults is! List<Face>) {
      return noResultsText;
    }
    String direction = "bak";
    if (_direction == CameraLensDirection.front) direction = "front";
    painter = FaceDetectorPainter(imageSize, _scanResults, direction, _messaga);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return NativeDeviceOrientationReader(builder: (context) {
      NativeDeviceOrientation orientation =
      NativeDeviceOrientationReader.orientation(context);
      int turns;
      switch (orientation) {
        case NativeDeviceOrientation.landscapeLeft:
          turns = -1;
          break;
        case NativeDeviceOrientation.landscapeRight:
          turns = 1;
          break;
        case NativeDeviceOrientation.portraitDown:
          turns = 2;
          break;
        default:
          turns = 0;
          break;
      }
      return Container(
        width: ScreenUtil().setSp(1366),
        height: ScreenUtil().setSp(688),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(ScreenUtil().setSp(6), 0), //x,y轴
                  color: Colors.black12, //投影颜色
                  blurRadius: ScreenUtil().setSp(12) //投影距离
              )
            ]
        ),
        constraints: const BoxConstraints.expand(),
        child: _camera == null
            ? const Center(
          child: Text(
            '正在开启摄像头',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30.0,
            ),
          ),
        )
            : Stack(
          fit: StackFit.expand,
          children: <Widget>[
//     RotatedBox(
//      quarterTurns:turns,
//      child: Transform.scale(
//        scale: 1,
//        child: Center(
//          child: AspectRatio(
//            aspectRatio: 0.55,
//            child: CameraPreview(_camera),
//          ),
//        ),
//      ),
//    ),
            CameraPreview(_camera),
            _buildResults(),
          ],
        ),
      );
    });
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            leading: FlatButton(
                child: Row(
                  children: <Widget>[
                    Image.asset("assets/images/back.png",fit: BoxFit.fill,),
                    Text(' 返回',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)
                  ],
                ),
                onPressed: () async {
                  if (_camera != null &&
                      _camera.value.isInitialized &&
                      _camera.value.isStreamingImages) {
                    await _camera.stopImageStream();
                    await _camera.dispose();
                    setState(() {
                      _camera = null;
                    });
                  }
                  isselect = false;
                  Navigator.pop(context);
                  showMessage(context,'您关闭了扫描窗口，点击摄像头图标可重新扫描!');
                }
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              '人脸识别',
              style: TextStyle(color: Colors.black,
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight:FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            elevation: 8.0,
            brightness: Brightness.light,
//            actions: <Widget>[
//              PopupMenuButton<Detector>(
//                onSelected: (Detector result) {
//                  if (Detector.landmark == result)
//                    _isenableLandmarks
//                        ? _isenableLandmarks = false
//                        : _isenableLandmarks = true;
//                  else if (Detector.Contours == result)
//                    _isenableContours
//                        ? _isenableContours = false
//                        : _isenableContours = true;
//                  else if (Detector.face == result) _currentDetector = result;
//                },
//                itemBuilder: (BuildContext context) =>
//                <PopupMenuEntry<Detector>>[
//                  const PopupMenuItem<Detector>(
//                    child: Text('人脸识别'),
//                    value: Detector.face,
//                  ),
//                  //const PopupMenuItem<Detector>(
//                  //  child: Text('开启/关闭人脸特征点'),
//                  //  value: Detector.landmark,
//                  //),
//                  //const PopupMenuItem<Detector>(
//                  //  child: Text('开启/关闭人脸轮廓'),
//                  //  value: Detector.Contours,
//                  //),
//                ],
//              ),
//            ],
          ),
          preferredSize: Size.fromHeight(68)
      ),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleCameraDirection,
        child: _direction == CameraLensDirection.back
            ? const Icon(Icons.camera_front)
            : const Icon(Icons.camera_rear),
      ),
    );
  }

  static const MethodChannel _channel = const MethodChannel('Flutterimage');

  static Future<String> SaveImages({@required List<Uint8List> bytesList,
    int imageHeight = 1280,
    int imageWidth = 720,
    int rotation: 90, // Android only
    int faceX,
    int faceY,
    int faceWidth,
    int faceHeight}) async {
    return await _channel.invokeMethod(
      'SaveImages',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "rotation": rotation,
        "faceX": faceX,
        "faceY": faceY,
        "faceWidth": faceWidth,
        "faceHeight": faceHeight
      },
    );
  }

  //static Future<String> LoadModel() async {
  //  return await _channel.invokeMethod('LoadModel');
  // }
  /*
  static Future<String> GetImageLight(
      {@required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      int rotation: 90, // Android only
      int faceX,
      int faceY,
      int faceWidth,
      int faceHeight}) async {
    return await _channel.invokeMethod(
      'GetImageLight',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "rotation": rotation,
        "faceX": faceX,
        "faceY": faceY,
        "faceWidth": faceWidth,
        "faceHeight": faceHeight
      },
    );
  }


  static Future<String> GetFeature(
      {@required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      int rotation: 90, // Android only
      int faceX,
      int faceY,
      int faceWidth,
      int faceHeight}) async {
    return await _channel.invokeMethod(
      'GetFeature',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "rotation": rotation,
        "faceX": faceX,
        "faceY": faceY,
        "faceWidth": faceWidth,
        "faceHeight": faceHeight
      },
    );
  }

  static Future<String> DeSpoofing(
      {@required List<Uint8List> bytesList,
      int imageHeight = 1280,
      int imageWidth = 720,
      int rotation: 90, // Android only
      int faceX,
      int faceY,
      int faceWidth,
      int faceHeight}) async {
    return await _channel.invokeMethod(
      'DeSpoofing',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "rotation": rotation,
        "faceX": faceX,
        "faceY": faceY,
        "faceWidth": faceWidth,
        "faceHeight": faceHeight
      },
    );
  }

  static Future<String> EvaluateScore({
    String feature1,
    String feature2,
  }) async {
    return await _channel.invokeMethod(
      'EvaluateScore',
      {
        "feature1": feature1,
        "feature2": feature2,
      },
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }
}*/

  int rotationImageRotationToInt(ImageRotation rotation) {
    switch (rotation) {
      case ImageRotation.rotation0:
        return 0;
      case ImageRotation.rotation90:
        return 90;
      case ImageRotation.rotation180:
        return 180;
      default:
        return 270;
    }
  }

  Rect _scaleRect({@required Rect rect,
    @required Size imageSize,
    @required Size widgetSize,
    @required String direct}) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;
    painterWidgetWidth = widgetSize.width;
    painterWidgetHeiht = widgetSize.height;

    return Rect.fromLTRB(
      rect.left < 0 ? 0 : rect.left.toDouble() * scaleX,
      rect.top < 0 ? 0 : rect.top.toDouble() * scaleY,
      rect.right < 0 ? 0 : rect.right.toDouble() * scaleX,
      rect.bottom < 0 ? 0 : rect.bottom.toDouble() * scaleY,
    );
  }
}

//调用方法
/*String imagepath=await ConvertImage(
                  bytesList: img.planes.map((plane) {
                    return plane.bytes;
                  }).toList(),
                  imageHeight: img.height,
                  imageWidth: img.width,
                  rotation: rotationImageRotationToInt(rotation)
              );
              if(imagepath==null)
                {
                  isDetecting = false;
                  return;
                }*/
