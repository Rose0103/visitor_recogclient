import 'package:lpinyin/lpinyin.dart';

class EmployModelData {
  String id;
  String name;
  String orgName;
  String mobile;
  String email;
  String tel;
  String dict;
  String content;

  EmployModelData({
    this.id,
    this.name,
    this.orgName,
    this.mobile,
    this.email,
    this.tel,
    this.dict,
    this.content
  });
  EmployModelData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    orgName = json["orgName"]?.toString()==null?"无":json["orgName"]?.toString();
    mobile = json["mobile"]?.toString();
    email = json["email"]?.toString();
    tel = json["tel"]?.toString();
    dict = PinyinHelper.getShortPinyin(name);
    content = "$name ($orgName)${mobile==""?tel:mobile}";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["orgName"] = orgName;
    data["mobile"] = mobile;
    data["email"] = email;
    data["tel"] = tel;
    data["dict"] = dict;
    data["content"] = content;
    return data;
  }
}

class EmployModel {
  int code;
  List<EmployModelData> data;
  String msg;
  String path;
  String extra;
  String timestamp;
  bool isSuccess;
  bool isError;

  EmployModel({
    this.code,
    this.data,
    this.msg,
    this.path,
    this.extra,
    this.timestamp,
    this.isSuccess,
    this.isError,
  });
  EmployModel.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    if (json["data"] != null) {
      var v = json["data"];
      var arr0 = List<EmployModelData>();
      v.forEach((v) {
        arr0.add(EmployModelData.fromJson(v));
      });
      this.data = arr0;
    }
    msg = json["msg"]?.toString();
    path = json["path"]?.toString();
    extra = json["extra"]?.toString();
    timestamp = json["timestamp"]?.toString();
    isSuccess = json["isSuccess"];
    isError = json["isError"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    if (this.data != null) {
      var v = this.data;
      var arr0 = List();
      v.forEach((v) {
        arr0.add(v.toJson());
      });
      data["data"] = arr0;
    }
    data["msg"] = msg;
    data["path"] = path;
    data["extra"] = extra;
    data["timestamp"] = timestamp;
    data["isSuccess"] = isSuccess;
    data["isError"] = isError;
    return data;
  }
}
