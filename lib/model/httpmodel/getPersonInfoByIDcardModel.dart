//根据身份证号
class personInfobyidcardModel {
  int code;
  Data data;
  String msg;
  String path;
  String extra;
  String timestamp;
  bool isSuccess;
  bool isError;

  personInfobyidcardModel(
      {this.code,
        this.data,
        this.msg,
        this.path,
        this.extra,
        this.timestamp,
        this.isSuccess,
        this.isError});

  personInfobyidcardModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    path = json['path'];
    extra = json['extra'];
    timestamp = json['timestamp'];
    isSuccess = json['isSuccess'];
    isError = json['isError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['path'] = this.path;
    data['extra'] = this.extra;
    data['timestamp'] = this.timestamp;
    data['isSuccess'] = this.isSuccess;
    data['isError'] = this.isError;
    return data;
  }
}

class Data {
  String userId;
  String name;
  String mobile;
  String idCard;
  List<TenantList> tenantList;

  Data({this.userId, this.name, this.mobile, this.idCard, this.tenantList});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    mobile = json['mobile'];
    idCard = json['idCard'];
    if (json['tenantList'] != null) {
      tenantList = new List<TenantList>();
      json['tenantList'].forEach((v) {
        tenantList.add(new TenantList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['idCard'] = this.idCard;
    if (this.tenantList != null) {
      data['tenantList'] = this.tenantList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TenantList {
  String employeeId;
  String tenantName;

  TenantList({this.employeeId, this.tenantName});

  TenantList.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    tenantName = json['tenantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['tenantName'] = this.tenantName;
    return data;
  }
}