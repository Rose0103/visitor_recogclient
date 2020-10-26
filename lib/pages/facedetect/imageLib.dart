import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/config/param.dart';
import 'dart:async';
import 'dart:io';
Future<String> convertImagetoPng(CameraImage image,double x,double y, double width,double height) async {
  try {
    //转换图片到RGBA
    imglib.Image img;
    if (image.format.group == ImageFormatGroup.yuv420) {
      img = _convertYUV420(image);
    } else if (image.format.group == ImageFormatGroup.bgra8888) {
      img = _convertBGRA8888(image);
    }
    String sTempDir = (await getExternalStorageDirectory()).path;
    //保存大图片
    File("${sTempDir}/full.jpg").writeAsBytesSync(imglib.encodeJpg(img));
    //裁剪人脸区域
    File croppedFile =await FlutterNativeImage.cropImage("${sTempDir}/full.jpg", x.toInt(), y.toInt(), width.toInt(), height.toInt());
    //保存图片
    final result = await ImageGallerySaver.saveFile(croppedFile.path);
    //压缩图片
    File compressedFile = await FlutterNativeImage.compressImage(Uri.decodeComponent(result).replaceAll("file://", ""), quality: 100,
        targetWidth: 300, targetHeight: 300);
    final result2 = await ImageGallerySaver.saveFile(compressedFile.path);
    //删除中间生成的图片
    Directory("${sTempDir}/full.jpg").delete(recursive: true).then((
        FileSystemEntity fileSystemEntity) {
    });
    Directory(Uri.decodeComponent(result).replaceAll("file://", "")).delete(recursive: true).then((
        FileSystemEntity fileSystemEntity) {
    });
    String str="";
    if(result2 != null && result2 != "") {
      str = Uri.decodeComponent(result2).replaceAll("file://", "");
      facePicPath=str;
    } else {
      showMessage2("保存失败");
    }
    return str;
    //imglib.PngEncoder pngEncoder = new imglib.PngEncoder();

    // Convert to png
    //List<int> png = pngEncoder.encodeImage(img);

    //return png;
  } catch (e) {
    print(">>>>>>>>>>>> ERROR:" + e.toString());
  }
  return null;
}

// CameraImage BGRA8888 -> PNG
// Color
imglib.Image _convertBGRA8888(CameraImage image) {
  return imglib.Image.fromBytes(
    image.width,
    image.height,
    image.planes[0].bytes,
    format: imglib.Format.bgra,
  );
}

// CameraImage YUV420_888 -> PNG -> Image (compresion:0, filter: none)
// Black
imglib.Image _convertYUV420(CameraImage image) {
  const int shift = (0xFF << 24);

  final int width = image.width;
  final int height = image.height;
  final int uvRowStride = image.planes[1].bytesPerRow;
  final int uvPixelStride = image.planes[1].bytesPerPixel;

  // imgLib -> Image package from https://pub.dartlang.org/packages/image
  var img = imglib.Image(width, height); // Create Image buffer

  // Fill image buffer with plane[0] from YUV420_888
  for(int x=0; x < width; x++) {
    for(int y=0; y < height; y++) {
      final int uvIndex = uvPixelStride * (x/2).floor() + uvRowStride*(y/2).floor();
      final int index = y * width + x;

      final yp = image.planes[0].bytes[index];
      final up = image.planes[1].bytes[uvIndex];
      final vp = image.planes[2].bytes[uvIndex];
      // Calculate pixel color
      int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
      int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
      int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
      // color: 0x FF  FF  FF  FF
      //           A   B   G   R
      img.data[index] = shift | (b << 16) | (g << 8) | r;
    }
  }

  return img;
}