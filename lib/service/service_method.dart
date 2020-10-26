
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:visitor_recogclient/otherfunction/dalog.dart';
import 'package:visitor_recogclient/pages/ProgressDialog.dart';
import 'dart:async';
import '../config/service_url.dart';
import '../common/shared_preference.dart';
import 'package:visitor_recogclient/config/param.dart';

getHeaders(List cookie) {
  if(cookie!=null&&cookie.isNotEmpty){
    return {
      "Content-Type": "application/json",
      "token":cookie[0],
      "tenant":cookie[1]
    };
  }else{
    return {
      'Accept':
      'application/json, text/plain,application/x-www-form-urlencoded,application/form-data, */*',
      'Content-Type': 'application/json,application/x-www-form-urlencoded',
      'Authorization': "**",
      'User-Aagent': "4.1.0;android;6.0.1;default;A001",
      "HZUID": "2",
      "token": token,
      "tenant": tenantCode,  //机构加在头里
    };
  }
}


//put接口
Future requestPut(url,BuildContext context, String params, {formData}) async {
  Response response;
  Dio dio = new Dio();
  try {
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
    dio.options.connectTimeout = 10000;
    //dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    var cookie = await KvStores.get("cookies");
    print(cookie);
    if (cookie == null) {}
    dio.options.headers = getHeaders(cookie);
    if (formData == null) {
      print(serviceURL+servicePath[url] + params);
      response = await dio.put(serviceURL+servicePath[url] + params,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });
    } else {
      print(serviceURL+servicePath[url] + params);
      response = await dio.put(serviceURL+servicePath[url] + params, data: formData,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });
    }
    print("response.statusCode${response.statusCode}");
    if (response.statusCode == 200) {
      if ((response.headers.value("set-cookie") != null)&&("loginByUsername".compareTo(url)==0)) {
        await KvStores.save("cookies", response.headers.value("set-cookie"));
        print("setcookie${response.headers.value('set-cookie')}");
      }
      print(response.data.toString());
      return response.data;
    }
    else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if(e.toString().contains("401"))
    {
      print("401");
      response = await dio.put(serviceURL+servicePath[url] + params, data: formData,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });

      if (response.statusCode == 200) {
        if ((response.headers.value("set-cookie") != null)&&("loginByUsername".compareTo(url)==0)) {
          await KvStores.save("cookies", response.headers.value("set-cookie"));
        }
        return response.data;
      }
      else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }
    showMessage(context, '网络或服务器异常！');
    countTimer.cancel(); // 取消重复计时
    countTimer = null;
    ProgressDialog.dismiss(context);
    return print('ERROR:======>${e}');
  }
}

//post接口
Future request(url,BuildContext context, String params, {formData}) async {
  Response response;
  Dio dio = new Dio();
  try {
    print('开始获取数据...............' + url);
    dio.options.connectTimeout = 10000;
    //dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    var cookie = await KvStores.get("cookies");
    print(cookie);
    dio.options.headers = getHeaders(cookie);
    if (formData == null) {
      print(serviceURL+servicePath[url] + params);
      response = await dio.post(serviceURL+servicePath[url] + params,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });
    } else {
      print(serviceURL+servicePath[url] + params);
      response = await dio.post(serviceURL+servicePath[url] + params, data: formData,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });
    }
    print("response.statusCode${response.statusCode}");
    if (response.statusCode == 200) {
      if ((response.headers.value("set-cookie") != null)&&("loginByUsername".compareTo(url)==0)) {
        await KvStores.save("cookies", response.headers.value("set-cookie"));
        print("setcookie${response.headers.value('set-cookie')}");
      }
      print(response.data.toString());
      return response.data;
    }
    else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if(e.toString().contains("401"))
    {
      print("401");
      response = await dio.post(serviceURL+servicePath[url] + params, data: formData,
          onSendProgress: (send, total) {
            print('已发送：$send  总大小：$total');
          });

      if (response.statusCode == 200) {
        if ((response.headers.value("set-cookie") != null)&&("loginByUsername".compareTo(url)==0)) {
          await KvStores.save("cookies", response.headers.value("set-cookie"));
        }
        return response.data;
      }
      else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }
    showMessage(context, '网络或服务器异常！');
    countTimer.cancel(); // 取消重复计时
    countTimer = null;
    ProgressDialog.dismiss(context);
    return print('ERROR:======>${e}');
  }
}

//get接口
Future requestGet(url,BuildContext context, String params) async {
  Response response;
  Dio dio = new Dio();
  try {
    print('开始获取数据...............' + url);

    dio.options.connectTimeout = 10000;
    //dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    //loginByUsername
    var cookie = await KvStores.get("cookies");
    print("cookie:$cookie");
    dio.options.headers = getHeaders(cookie);
    print(params);
    if (params.length==0) {
      print(serviceURL+servicePath[url]);
      response = await dio.get(
        serviceURL+servicePath[url],
      );
    } else {
      print(serviceURL+servicePath[url] + params);
      response = await dio.get(serviceURL+servicePath[url] + params);
    }

    print("response.statusCode${response.statusCode}");
    if (response.statusCode == 200) {
      if (response.headers.value("cookie") != null) {
        print(response.headers.value("cookie"));
        await KvStores.save("cookies", response.headers.value("cookie"));
      }
      print("get_fanhui----${response.data.toString()}");
      return response.data;
    }
    else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if(e.toString().contains("401"))
    {
      print("401");
      response = await dio.get(serviceURL+servicePath[url] + params);
      if (response.statusCode == 200) {
        if (response.headers.value("cookie") != null) {
          await KvStores.save("cookies", response.headers.value("cookie"));
        }
        return response.data;
      }else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }
    showMessage(context, '网络或服务器异常！');
    countTimer.cancel(); // 取消重复计时
    countTimer = null;
    ProgressDialog.dismiss(context);
    return print('ERROR:======>${e}');
  }
}

//delete接口
Future requestDelete(url,BuildContext context, String params, {formData}) async {
  Response response;
  Dio dio = new Dio();
  try {
    print('开始获取数据...............' + url);
    dio.options.connectTimeout = 10000;
    //dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    var cookie = await KvStores.get("cookies");
    print(cookie);
    if (cookie == null) {}
    dio.options.headers = getHeaders(cookie);
    if (formData == null) {
      print(serviceURL+servicePath[url] + params);
      response = await dio.delete(serviceURL+servicePath[url] + params);
    } else {
      print(serviceURL+servicePath[url] + params);
      response = await dio.delete(serviceURL+servicePath[url] + params, data: formData);
    }
    print("response.statusCode${response.statusCode}");
    if (response.statusCode == 200) {
      if ((response.headers.value("set-cookie") != null)&&("loginByUsername".compareTo(url)==0)) {
        await KvStores.save("cookies", response.headers.value("set-cookie"));
        print("setcookie${response.headers.value('set-cookie')}");
      }
      print(response.data.toString());
      return response.data;
    }
    else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if(e.toString().contains("401"))
    {
      print("401");
      if (formData == null) {
        print(serviceURL+servicePath[url] + params);
        response = await dio.delete(serviceURL+servicePath[url] + params);
      } else {
        print(serviceURL+servicePath[url] + params);
        response = await dio.delete(serviceURL+servicePath[url] + params, data: formData);
      }
      if (response.statusCode == 200) {
        if (response.headers.value("cookie") != null) {
          await KvStores.save("cookies", response.headers.value("cookie"));
        }
        return response.data;
      }else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }
    showMessage(context, '网络或服务器异常！');
    countTimer.cancel(); // 取消重复计时
    countTimer = null;
    ProgressDialog.dismiss(context);
    return print('ERROR:======>${e}');
  }
}

//get接口
Future requestMapGet(url,BuildContext context, Map<String,dynamic> params) async {
  Response response;
  Dio dio = new Dio();
  try {
    print('开始获取数据...............' + url);

    dio.options.connectTimeout = 10000;
    //dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    //loginByUsername
    var cookie = await KvStores.get("cookies");
    print(cookie);
    dio.options.headers = getHeaders(cookie);
    print(params);
    if (params.length==0&&params.isEmpty) {
      print(serviceURL+servicePath[url]);
      response = await dio.get(
        serviceURL+servicePath[url],
      );
    } else {
      print(serviceURL+servicePath[url]);
      response = await dio.get(url,queryParameters: params);
    }

    print("response.statusCode${response.statusCode}");
    if (response.statusCode == 200) {
      if (response.headers.value("cookie") != null) {
        print(response.headers.value("cookie"));
        await KvStores.save("cookies", response.headers.value("cookie"));
      }
      print("get_fanhui----${response.data.toString()}");
      return response.data;
    }
    else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if(e.toString().contains("401"))
    {
      print("401");
      if (params.length==0&&params.isEmpty) {
        print(serviceURL+servicePath[url]);
        response = await dio.get(
          serviceURL+servicePath[url],
        );
      } else {
        print(serviceURL+servicePath[url]);
        response = await dio.get(url,queryParameters: params);
      }
      if (response.statusCode == 200) {
        if (response.headers.value("cookie") != null) {
          await KvStores.save("cookies", response.headers.value("cookie"));
        }
        return response.data;
      }else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }
    showMessage(context, '网络或服务器异常！');
    countTimer.cancel(); // 取消重复计时
    countTimer = null;
    ProgressDialog.dismiss(context);
    return print('ERROR:======>${e}');
  }
}
