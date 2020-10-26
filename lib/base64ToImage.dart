
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class Base64ToImage{

  //将Base64字符串的图片转换成图片
  static Future<MemoryImage> base642Image(String base64Txt) async {
    Uint8List bytes = Base64Decoder().convert(base64Txt);
    return MemoryImage(bytes);
  }

  static Future<Image> base642Images(String base64Txt) async {
    Uint8List bytes = Base64Decoder().convert(base64Txt);
    return Image.memory(
      bytes,
      fit: BoxFit.fill,
    );
  }

  //通过图片路径将图片转换成Base64字符串
  static Future<String> image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

//  //图片压缩并转base64
//  static Future<String> compressImagetoBase64(File file) async {
//    List<int> result = await FlutterImageCompress.compressWithFile(
//      file.absolute.path,
//      minWidth: 2300,
//      minHeight: 1500,
//      quality: 64,
//      rotate: 0,
//    );
//    print('压缩前:${file.lengthSync()}');
//    print('压缩后:'+result.length.toString());
//    return base64Encode(result);
//  }


  //图片压缩
  static Future<File> compressImage(File file, String sDCardDir) async {
    File result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      sDCardDir+'/visitPhoto/${DateTime.now()}s.jpg',
      minWidth: 2300,
      minHeight: 1500,
      quality: 50,
      rotate: 0,
    );
    print('压缩前:${file.lengthSync()}');
    print('压缩后:${result.lengthSync()}');
    return result;

  }
}