class IDcardpersonModelDataTenantList {
/*
{
  "employeeId": "1271280128667680768",
  "tenantName": null
}
*/

  String employeeId;
  String tenantName;

  IDcardpersonModelDataTenantList({
    this.employeeId,
    this.tenantName,
  });
  IDcardpersonModelDataTenantList.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"]?.toString();
    tenantName = json["tenantName"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["employeeId"] = employeeId;
    data["tenantName"] = tenantName;
    return data;
  }
}

class IDcardpersonModelData {
/*
{
  "userId": "1271280126029463552",
  "name": "冷冷",
  "mobile": "18473439122",
  "idCard": "430421199905067029",
  "tenantList": [
    {
      "employeeId": "1271280128667680768",
      "tenantName": null
    }
  ]
}
*/

  String userId;
  String name;
  String mobile;
  String idCard;
  List<IDcardpersonModelDataTenantList> tenantList;

  IDcardpersonModelData({
    this.userId,
    this.name,
    this.mobile,
    this.idCard,
    this.tenantList,
  });
  IDcardpersonModelData.fromJson(Map<String, dynamic> json) {
    userId = json["userId"]?.toString();
    name = json["name"]?.toString();
    mobile = json["mobile"]?.toString();
    idCard = json["idCard"]?.toString();
    if (json["tenantList"] != null) {
      var v = json["tenantList"];
      var arr0 = List<IDcardpersonModelDataTenantList>();
      v.forEach((v) {
        arr0.add(IDcardpersonModelDataTenantList.fromJson(v));
      });
      tenantList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["userId"] = userId;
    data["name"] = name;
    data["mobile"] = mobile;
    data["idCard"] = idCard;
    if (tenantList != null) {
      var v = tenantList;
      var arr0 = List();
      v.forEach((v) {
        arr0.add(v.toJson());
      });
      data["tenantList"] = arr0;
    }
    return data;
  }
}

class IDcardpersonModel {
/*
{
  "code": 0,
  "data": {
    "userId": "1271280126029463552",
    "name": "冷冷",
    "mobile": "18473439122",
    "idCard": "430421199905067029",
    "tenantList": [
      {
        "employeeId": "1271280128667680768",
        "tenantName": null
      }
    ]
  },
  "msg": "操作成功",
  "path": null,
  "extra": null,
  "timestamp": "1592895258456",
  "isSuccess": true,
  "isError": false
}
*/

  int code;
  IDcardpersonModelData data;
  String msg;
  String path;
  String extra;
  String timestamp;
  bool isSuccess;
  bool isError;

  IDcardpersonModel({
    this.code,
    this.data,
    this.msg,
    this.path,
    this.extra,
    this.timestamp,
    this.isSuccess,
    this.isError,
  });
  IDcardpersonModel.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    data = json["data"] != null ? IDcardpersonModelData.fromJson(json["data"]) : null;
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
    if (data != null) {
      data["data"] = this.data.toJson();
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