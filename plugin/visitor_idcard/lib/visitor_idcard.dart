import 'dart:async';

import 'package:flutter/services.dart';

class VisitorIdcard {
  static const MethodChannel _channel =
      const MethodChannel('visitor_idcard');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get readIDCard async {
    final String version = await _channel.invokeMethod('readIDcard');
    return version;
  }

  static Future<String> get getIDCardInfo async {
    final String idCardInfo = await _channel.invokeMethod('getIDCardInfo');
    return idCardInfo;
  }

  static Future<String> get toBase64 async {
    final String toBase64 = await _channel.invokeMethod('toBase64');
    return toBase64;
  }

  static Future<String> get stopreadIDCard async {
    final String version = await _channel.invokeMethod('stopreadIDcard');
    return version;
  }
}
