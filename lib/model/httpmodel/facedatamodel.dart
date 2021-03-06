///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FaceDateModelData {
/*
{
  "userId": "1278590757845860352",
  "score": "97.350173950195"
}
*/

  String userId;
  String score;

  FaceDateModelData({
    this.userId,
    this.score,
  });
  FaceDateModelData.fromJson(Map<String, dynamic> json) {
    userId = json["userId"]?.toString();
    score = json["score"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["userId"] = userId;
    data["score"] = score;
    return data;
  }
}

class FaceDateModel {
/*
{
  "code": "1001",
  "data": {
    "userId": "1278590757845860352",
    "score": "97.350173950195"
  },
  "msg": "请求中必须至少包含一个有效文件",
  "path": "/userFace/searchFace",
  "extra": null,
  "timestamp": "1594280886691",
  "isSuccess": false,
  "isError": true
}
*/

  String code;
  FaceDateModelData data;
  String msg;
  String path;
  String extra;
  String timestamp;
  bool isSuccess;
  bool isError;

  FaceDateModel({
    this.code,
    this.data,
    this.msg,
    this.path,
    this.extra,
    this.timestamp,
    this.isSuccess,
    this.isError,
  });
  FaceDateModel.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toString();
    data = json["data"] != null ? FaceDateModelData.fromJson(json["data"]) : null;
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
