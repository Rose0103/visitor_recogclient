import 'dart:async';

import 'package:flutter/services.dart';

class Demo {
  static const MethodChannel _channel =
      const MethodChannel('demo');

  static Future<String> get connectdevices async {
    final String version = await _channel.invokeMethod('connectdevice');
    return version;
  }

  static Future<String> getQRPrinter(String content,String name,String count,String visit) async {
    final String version = await _channel.invokeMethod('getQRPrinter',{
      'content':content,
      'name':name,
      'count':count,
      "visitname":visit
    });
    return version;
  }
}
