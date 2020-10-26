import 'dart:async';

import 'package:flutter/services.dart';

class Flutterpluginexcle {
  static const MethodChannel _channel =
      const MethodChannel('flutterpluginexcle');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> outExcel(String fileName,String title,List rowName,List<List> content,String to) async {
    final String version = await _channel.invokeMethod('outExcel',{
      'fileName':fileName,
      'title':title,
      'rowName':rowName,
      "content":content,
      "to":to
    });
    return version;
  }
}
