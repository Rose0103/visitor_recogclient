///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class visitorDataModelDataRecordsPersonType {
/*
{
  "desc": "拜访人",
  "code": "VISITOR"
} 
*/

  String desc;
  String code;

  visitorDataModelDataRecordsPersonType({
    this.desc,
    this.code,
  });
  visitorDataModelDataRecordsPersonType.fromJson(Map<String, dynamic> json) {
    desc = json["desc"]?.toString();
    code = json["code"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["desc"] = desc;
    data["code"] = code;
    return data;
  }
}

class visitorDataModelDataRecordsVisitStatus {
/*
{
  "desc": "受访人待确认",
  "code": "INTERVIEWEE_WAIT_VERIFY"
} 
*/

  String desc;
  String code;

  visitorDataModelDataRecordsVisitStatus({
    this.desc,
    this.code,
  });
  visitorDataModelDataRecordsVisitStatus.fromJson(Map<String, dynamic> json) {
    desc = json["desc"]?.toString();
    code = json["code"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["desc"] = desc;
    data["code"] = code;
    return data;
  }
}

class visitorDataModelDataRecordsVisitMethod {
/*
{
  "desc": "名片",
  "code": "VISITING_CARD"
} 
*/

  String desc;
  String code;

  visitorDataModelDataRecordsVisitMethod({
    this.desc,
    this.code,
  });
  visitorDataModelDataRecordsVisitMethod.fromJson(Map<String, dynamic> json) {
    desc = json["desc"]?.toString();
    code = json["code"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["desc"] = desc;
    data["code"] = code;
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataTenantCodeDataArea {
/*
{
  "key": "430102000000",
  "data": "湖南省长沙市芙蓉区"
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsIntervieweeDataTenantCodeDataArea({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsIntervieweeDataTenantCodeDataArea.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataTenantCodeData {
/*
{
  "name": "湖南敏求",
  "area": {
    "key": "430102000000",
    "data": "湖南省长沙市芙蓉区"
  }
} 
*/

  String name;
  visitorDataModelDataRecordsIntervieweeDataTenantCodeDataArea area;

  visitorDataModelDataRecordsIntervieweeDataTenantCodeData({
    this.name,
    this.area,
  });
  visitorDataModelDataRecordsIntervieweeDataTenantCodeData.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    area = json["area"] != null ? visitorDataModelDataRecordsIntervieweeDataTenantCodeDataArea.fromJson(json["area"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    if (area != null) {
      data["area"] = area.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataTenantCode {
/*
{
  "key": "4301022007002",
  "data": {
    "name": "湖南敏求",
    "area": {
      "key": "430102000000",
      "data": "湖南省长沙市芙蓉区"
    }
  }
} 
*/

  String key;
  visitorDataModelDataRecordsIntervieweeDataTenantCodeData data;

  visitorDataModelDataRecordsIntervieweeDataTenantCode({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsIntervieweeDataTenantCode.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsIntervieweeDataTenantCodeData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataStation {
/*
{
  "key": null,
  "data": null
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsIntervieweeDataStation({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsIntervieweeDataStation.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataOrg {
/*
{
  "key": null,
  "data": null
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsIntervieweeDataOrg({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsIntervieweeDataOrg.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataUserIdData {
/*
{
  "id": "1282941883890270208",
  "name": "万超",
  "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
  "idCard": "430781199007282512",
  "mobile": "13307422738",
  "account": "WC27381594712155681"
} 
*/

  String id;
  String name;
  String avatar;
  String idCard;
  String mobile;
  String account;

  visitorDataModelDataRecordsIntervieweeDataUserIdData({
    this.id,
    this.name,
    this.avatar,
    this.idCard,
    this.mobile,
    this.account,
  });
  visitorDataModelDataRecordsIntervieweeDataUserIdData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    avatar = json["avatar"]?.toString();
    idCard = json["idCard"]?.toString();
    mobile = json["mobile"]?.toString();
    account = json["account"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["avatar"] = avatar;
    data["idCard"] = idCard;
    data["mobile"] = mobile;
    data["account"] = account;
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeDataUserId {
/*
{
  "key": "1282941883890270208",
  "data": {
    "id": "1282941883890270208",
    "name": "万超",
    "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
    "idCard": "430781199007282512",
    "mobile": "13307422738",
    "account": "WC27381594712155681"
  }
} 
*/

  String key;
  visitorDataModelDataRecordsIntervieweeDataUserIdData data;

  visitorDataModelDataRecordsIntervieweeDataUserId({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsIntervieweeDataUserId.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsIntervieweeDataUserIdData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsIntervieweeData {
/*
{
  "id": "1285060838637436928",
  "name": "万超",
  "idCard": "430781199007282512",
  "userId": {
    "key": "1282941883890270208",
    "data": {
      "id": "1282941883890270208",
      "name": "万超",
      "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
      "idCard": "430781199007282512",
      "mobile": "13307422738",
      "account": "WC27381594712155681"
    }
  },
  "org": {
    "key": null,
    "data": null
  },
  "station": {
    "key": null,
    "data": null
  },
  "tenantCode": {
    "key": "4301022007002",
    "data": {
      "name": "湖南敏求",
      "area": {
        "key": "430102000000",
        "data": "湖南省长沙市芙蓉区"
      }
    }
  }
} 
*/

  String id;
  String name;
  String idCard;
  visitorDataModelDataRecordsIntervieweeDataUserId userId;
  visitorDataModelDataRecordsIntervieweeDataOrg org;
  visitorDataModelDataRecordsIntervieweeDataStation station;
  visitorDataModelDataRecordsIntervieweeDataTenantCode tenantCode;

  visitorDataModelDataRecordsIntervieweeData({
    this.id,
    this.name,
    this.idCard,
    this.userId,
    this.org,
    this.station,
    this.tenantCode,
  });
  visitorDataModelDataRecordsIntervieweeData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    idCard = json["idCard"]?.toString();
    userId = json["userId"] != null ? visitorDataModelDataRecordsIntervieweeDataUserId.fromJson(json["userId"]) : null;
    org = json["org"] != null ? visitorDataModelDataRecordsIntervieweeDataOrg.fromJson(json["org"]) : null;
    station = json["station"] != null ? visitorDataModelDataRecordsIntervieweeDataStation.fromJson(json["station"]) : null;
    tenantCode = json["tenantCode"] != null ? visitorDataModelDataRecordsIntervieweeDataTenantCode.fromJson(json["tenantCode"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["idCard"] = idCard;
    if (userId != null) {
      data["userId"] = userId.toJson();
    }
    if (org != null) {
      data["org"] = org.toJson();
    }
    if (station != null) {
      data["station"] = station.toJson();
    }
    if (tenantCode != null) {
      data["tenantCode"] = tenantCode.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsInterviewee {
/*
{
  "key": "1285060838637436928",
  "data": {
    "id": "1285060838637436928",
    "name": "万超",
    "idCard": "430781199007282512",
    "userId": {
      "key": "1282941883890270208",
      "data": {
        "id": "1282941883890270208",
        "name": "万超",
        "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
        "idCard": "430781199007282512",
        "mobile": "13307422738",
        "account": "WC27381594712155681"
      }
    },
    "org": {
      "key": null,
      "data": null
    },
    "station": {
      "key": null,
      "data": null
    },
    "tenantCode": {
      "key": "4301022007002",
      "data": {
        "name": "湖南敏求",
        "area": {
          "key": "430102000000",
          "data": "湖南省长沙市芙蓉区"
        }
      }
    }
  }
} 
*/

  String key;
  visitorDataModelDataRecordsIntervieweeData data;

  visitorDataModelDataRecordsInterviewee({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsInterviewee.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsIntervieweeData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataTenantCodeDataArea {
/*
{
  "key": "430102000000",
  "data": "湖南省长沙市芙蓉区"
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsVisitorDataTenantCodeDataArea({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitorDataTenantCodeDataArea.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataTenantCodeData {
/*
{
  "name": "湖南敏求",
  "area": {
    "key": "430102000000",
    "data": "湖南省长沙市芙蓉区"
  }
} 
*/

  String name;
  visitorDataModelDataRecordsVisitorDataTenantCodeDataArea area;

  visitorDataModelDataRecordsVisitorDataTenantCodeData({
    this.name,
    this.area,
  });
  visitorDataModelDataRecordsVisitorDataTenantCodeData.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    area = json["area"] != null ? visitorDataModelDataRecordsVisitorDataTenantCodeDataArea.fromJson(json["area"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    if (area != null) {
      data["area"] = area.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataTenantCode {
/*
{
  "key": "4301022007002",
  "data": {
    "name": "湖南敏求",
    "area": {
      "key": "430102000000",
      "data": "湖南省长沙市芙蓉区"
    }
  }
} 
*/

  String key;
  visitorDataModelDataRecordsVisitorDataTenantCodeData data;

  visitorDataModelDataRecordsVisitorDataTenantCode({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitorDataTenantCode.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsVisitorDataTenantCodeData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataStation {
/*
{
  "key": null,
  "data": null
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsVisitorDataStation({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitorDataStation.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataOrg {
/*
{
  "key": null,
  "data": null
} 
*/

  String key;
  String data;

  visitorDataModelDataRecordsVisitorDataOrg({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitorDataOrg.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = this.data;
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataUserIdData {
/*
{
  "id": "1282967321077350400",
  "name": "何旭东",
  "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
  "idCard": "421022199708291818",
  "mobile": "13974275925",
  "account": "HXD59251594718220380"
} 
*/

  String id;
  String name;
  String avatar;
  String idCard;
  String mobile;
  String account;

  visitorDataModelDataRecordsVisitorDataUserIdData({
    this.id,
    this.name,
    this.avatar,
    this.idCard,
    this.mobile,
    this.account,
  });
  visitorDataModelDataRecordsVisitorDataUserIdData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    avatar = json["avatar"]?.toString();
    idCard = json["idCard"]?.toString();
    mobile = json["mobile"]?.toString();
    account = json["account"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["avatar"] = avatar;
    data["idCard"] = idCard;
    data["mobile"] = mobile;
    data["account"] = account;
    return data;
  }
}

class visitorDataModelDataRecordsVisitorDataUserId {
/*
{
  "key": "1282967321077350400",
  "data": {
    "id": "1282967321077350400",
    "name": "何旭东",
    "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
    "idCard": "421022199708291818",
    "mobile": "13974275925",
    "account": "HXD59251594718220380"
  }
} 
*/

  String key;
  visitorDataModelDataRecordsVisitorDataUserIdData data;

  visitorDataModelDataRecordsVisitorDataUserId({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitorDataUserId.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsVisitorDataUserIdData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsVisitorData {
/*
{
  "id": "1285101800684257280",
  "name": "何旭东",
  "idCard": "421022199708291818",
  "userId": {
    "key": "1282967321077350400",
    "data": {
      "id": "1282967321077350400",
      "name": "何旭东",
      "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
      "idCard": "421022199708291818",
      "mobile": "13974275925",
      "account": "HXD59251594718220380"
    }
  },
  "org": {
    "key": null,
    "data": null
  },
  "station": {
    "key": null,
    "data": null
  },
  "tenantCode": {
    "key": "4301022007002",
    "data": {
      "name": "湖南敏求",
      "area": {
        "key": "430102000000",
        "data": "湖南省长沙市芙蓉区"
      }
    }
  }
} 
*/

  String id;
  String name;
  String idCard;
  visitorDataModelDataRecordsVisitorDataUserId userId;
  visitorDataModelDataRecordsVisitorDataOrg org;
  visitorDataModelDataRecordsVisitorDataStation station;
  visitorDataModelDataRecordsVisitorDataTenantCode tenantCode;

  visitorDataModelDataRecordsVisitorData({
    this.id,
    this.name,
    this.idCard,
    this.userId,
    this.org,
    this.station,
    this.tenantCode,
  });
  visitorDataModelDataRecordsVisitorData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    idCard = json["idCard"]?.toString();
    userId = json["userId"] != null ? visitorDataModelDataRecordsVisitorDataUserId.fromJson(json["userId"]) : null;
    org = json["org"] != null ? visitorDataModelDataRecordsVisitorDataOrg.fromJson(json["org"]) : null;
    station = json["station"] != null ? visitorDataModelDataRecordsVisitorDataStation.fromJson(json["station"]) : null;
    tenantCode = json["tenantCode"] != null ? visitorDataModelDataRecordsVisitorDataTenantCode.fromJson(json["tenantCode"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["idCard"] = idCard;
    if (userId != null) {
      data["userId"] = userId.toJson();
    }
    if (org != null) {
      data["org"] = org.toJson();
    }
    if (station != null) {
      data["station"] = station.toJson();
    }
    if (tenantCode != null) {
      data["tenantCode"] = tenantCode.toJson();
    }
    return data;
  }
}

class visitorDataModelDataRecordsVisitor {
/*
{
  "key": "1285101800684257280",
  "data": {
    "id": "1285101800684257280",
    "name": "何旭东",
    "idCard": "421022199708291818",
    "userId": {
      "key": "1282967321077350400",
      "data": {
        "id": "1282967321077350400",
        "name": "何旭东",
        "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
        "idCard": "421022199708291818",
        "mobile": "13974275925",
        "account": "HXD59251594718220380"
      }
    },
    "org": {
      "key": null,
      "data": null
    },
    "station": {
      "key": null,
      "data": null
    },
    "tenantCode": {
      "key": "4301022007002",
      "data": {
        "name": "湖南敏求",
        "area": {
          "key": "430102000000",
          "data": "湖南省长沙市芙蓉区"
        }
      }
    }
  }
} 
*/

  String key;
  visitorDataModelDataRecordsVisitorData data;

  visitorDataModelDataRecordsVisitor({
    this.key,
    this.data,
  });
  visitorDataModelDataRecordsVisitor.fromJson(Map<String, dynamic> json) {
    key = json["key"]?.toString();
    data = json["data"] != null ? visitorDataModelDataRecordsVisitorData.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    if (data != null) {
      data["data"] = this.data.toJson();
    }
    return data;
  }
}

class Records {
/*
{
  "id": "1285485859038035968",
  "visitor": {
    "key": "1285101800684257280",
    "data": {
      "id": "1285101800684257280",
      "name": "何旭东",
      "idCard": "421022199708291818",
      "userId": {
        "key": "1282967321077350400",
        "data": {
          "id": "1282967321077350400",
          "name": "何旭东",
          "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
          "idCard": "421022199708291818",
          "mobile": "13974275925",
          "account": "HXD59251594718220380"
        }
      },
      "org": {
        "key": null,
        "data": null
      },
      "station": {
        "key": null,
        "data": null
      },
      "tenantCode": {
        "key": "4301022007002",
        "data": {
          "name": "湖南敏求",
          "area": {
            "key": "430102000000",
            "data": "湖南省长沙市芙蓉区"
          }
        }
      }
    }
  },
  "visitorName": "何旭东",
  "visitorTenantName": "湖南敏求",
  "interviewee": {
    "key": "1285060838637436928",
    "data": {
      "id": "1285060838637436928",
      "name": "万超",
      "idCard": "430781199007282512",
      "userId": {
        "key": "1282941883890270208",
        "data": {
          "id": "1282941883890270208",
          "name": "万超",
          "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
          "idCard": "430781199007282512",
          "mobile": "13307422738",
          "account": "WC27381594712155681"
        }
      },
      "org": {
        "key": null,
        "data": null
      },
      "station": {
        "key": null,
        "data": null
      },
      "tenantCode": {
        "key": "4301022007002",
        "data": {
          "name": "湖南敏求",
          "area": {
            "key": "430102000000",
            "data": "湖南省长沙市芙蓉区"
          }
        }
      }
    }
  },
  "reservationTime": "2020-07-22 16:08:00",
  "partnerNumber": 1,
  "visitMethod": {
    "desc": "名片",
    "code": "VISITING_CARD"
  },
  "visitStatus": {
    "desc": "受访人待确认",
    "code": "INTERVIEWEE_WAIT_VERIFY"
  },
  "personType": {
    "desc": "拜访人",
    "code": "VISITOR"
  },
  "showStatusName": "受访人待确认"
} 
*/

  String id;
  visitorDataModelDataRecordsVisitor visitor;
  String visitorName;
  String visitorTenantName;
  visitorDataModelDataRecordsInterviewee interviewee;
  String intervieweeName;
  String reservationTime;
  int partnerNumber;
  visitorDataModelDataRecordsVisitMethod visitMethod;
  visitorDataModelDataRecordsVisitStatus visitStatus;
  visitorDataModelDataRecordsPersonType personType;
  String showStatusName;

  Records({
    this.id,
    this.visitor,
    this.visitorName,
    this.visitorTenantName,
    this.interviewee,
    this.intervieweeName,
    this.reservationTime,
    this.partnerNumber,
    this.visitMethod,
    this.visitStatus,
    this.personType,
    this.showStatusName,
  });
  Records.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    visitor = json["visitor"] != null ? visitorDataModelDataRecordsVisitor.fromJson(json["visitor"]) : null;
    visitorName = json["visitorName"]?.toString();
    visitorTenantName = json["visitorTenantName"]?.toString();
    interviewee = json["interviewee"] != null ? visitorDataModelDataRecordsInterviewee.fromJson(json["interviewee"]) : null;
    intervieweeName = json["intervieweeName"]?.toString();
    reservationTime = json["reservationTime"]?.toString();
    partnerNumber = json["partnerNumber"]?.toInt();
    visitMethod = json["visitMethod"] != null ? visitorDataModelDataRecordsVisitMethod.fromJson(json["visitMethod"]) : null;
    visitStatus = json["visitStatus"] != null ? visitorDataModelDataRecordsVisitStatus.fromJson(json["visitStatus"]) : null;
    personType = json["personType"] != null ? visitorDataModelDataRecordsPersonType.fromJson(json["personType"]) : null;
    showStatusName = json["showStatusName"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    if (visitor != null) {
      data["visitor"] = visitor.toJson();
    }
    data["visitorName"] = visitorName;
    data["visitorTenantName"] = visitorTenantName;
    if (interviewee != null) {
      data["interviewee"] = interviewee.toJson();
    }
    data["intervieweeName"] = intervieweeName;
    data["reservationTime"] = reservationTime;
    data["partnerNumber"] = partnerNumber;
    if (visitMethod != null) {
      data["visitMethod"] = visitMethod.toJson();
    }
    if (visitStatus != null) {
      data["visitStatus"] = visitStatus.toJson();
    }
    if (personType != null) {
      data["personType"] = personType.toJson();
    }
    data["showStatusName"] = showStatusName;
    return data;
  }
}

class visitorDataModelData {
/*
{
  "records": [
    {
      "id": "1285485859038035968",
      "visitor": {
        "key": "1285101800684257280",
        "data": {
          "id": "1285101800684257280",
          "name": "何旭东",
          "idCard": "421022199708291818",
          "userId": {
            "key": "1282967321077350400",
            "data": {
              "id": "1282967321077350400",
              "name": "何旭东",
              "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
              "idCard": "421022199708291818",
              "mobile": "13974275925",
              "account": "HXD59251594718220380"
            }
          },
          "org": {
            "key": null,
            "data": null
          },
          "station": {
            "key": null,
            "data": null
          },
          "tenantCode": {
            "key": "4301022007002",
            "data": {
              "name": "湖南敏求",
              "area": {
                "key": "430102000000",
                "data": "湖南省长沙市芙蓉区"
              }
            }
          }
        }
      },
      "visitorName": "何旭东",
      "visitorTenantName": "湖南敏求",
      "interviewee": {
        "key": "1285060838637436928",
        "data": {
          "id": "1285060838637436928",
          "name": "万超",
          "idCard": "430781199007282512",
          "userId": {
            "key": "1282941883890270208",
            "data": {
              "id": "1282941883890270208",
              "name": "万超",
              "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
              "idCard": "430781199007282512",
              "mobile": "13307422738",
              "account": "WC27381594712155681"
            }
          },
          "org": {
            "key": null,
            "data": null
          },
          "station": {
            "key": null,
            "data": null
          },
          "tenantCode": {
            "key": "4301022007002",
            "data": {
              "name": "湖南敏求",
              "area": {
                "key": "430102000000",
                "data": "湖南省长沙市芙蓉区"
              }
            }
          }
        }
      },
      "reservationTime": "2020-07-22 16:08:00",
      "partnerNumber": 1,
      "visitMethod": {
        "desc": "名片",
        "code": "VISITING_CARD"
      },
      "visitStatus": {
        "desc": "受访人待确认",
        "code": "INTERVIEWEE_WAIT_VERIFY"
      },
      "personType": {
        "desc": "拜访人",
        "code": "VISITOR"
      },
      "showStatusName": "受访人待确认"
    }
  ],
  "total": "1",
  "size": "20",
  "current": "1",
  "orders": [
    1
  ],
  "hitCount": false,
  "searchCount": true,
  "pages": "1"
} 
*/

  List<Records> records;
  String total;
  String size;
  String current;
  List orders;
  bool hitCount;
  bool searchCount;
  String pages;

  visitorDataModelData({
    this.records,
    this.total,
    this.size,
    this.current,
    this.orders,
    this.hitCount,
    this.searchCount,
    this.pages,
  });
  visitorDataModelData.fromJson(Map<String, dynamic> json) {
    if (json["records"] != null) {
      var v = json["records"];
      var arr0 = List<Records>();
      v.forEach((v) {
        arr0.add(Records.fromJson(v));
      });
      records = arr0;
    }
    total = json["total"]?.toString();
    size = json["size"]?.toString();
    current = json["current"]?.toString();
    if (json["orders"] != null) {
      var v = json["orders"];
      var arr0 = List<int>();
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      orders = arr0;
    }
    hitCount = json["hitCount"];
    searchCount = json["searchCount"];
    pages = json["pages"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (records != null) {
      var v = records;
      var arr0 = List();
      v.forEach((v) {
        arr0.add(v.toJson());
      });
      data["records"] = arr0;
    }
    data["total"] = total;
    data["size"] = size;
    data["current"] = current;
    if (orders != null) {
      var v = orders;
      var arr0 = List();
      v.forEach((v) {
        arr0.add(v);
      });
      data["orders"] = arr0;
    }
    data["hitCount"] = hitCount;
    data["searchCount"] = searchCount;
    data["pages"] = pages;
    return data;
  }
}

class visitorDataModel {
/*
{
  "code": 0,
  "data": {
    "records": [
      {
        "id": "1285485859038035968",
        "visitor": {
          "key": "1285101800684257280",
          "data": {
            "id": "1285101800684257280",
            "name": "何旭东",
            "idCard": "421022199708291818",
            "userId": {
              "key": "1282967321077350400",
              "data": {
                "id": "1282967321077350400",
                "name": "何旭东",
                "avatar": "http://120.26.66.211:10000/file/4301022007002/2020/07/797ad555-5ad0-4e6a-ac4e-f821c19c5080.jpeg",
                "idCard": "421022199708291818",
                "mobile": "13974275925",
                "account": "HXD59251594718220380"
              }
            },
            "org": {
              "key": null,
              "data": null
            },
            "station": {
              "key": null,
              "data": null
            },
            "tenantCode": {
              "key": "4301022007002",
              "data": {
                "name": "湖南敏求",
                "area": {
                  "key": "430102000000",
                  "data": "湖南省长沙市芙蓉区"
                }
              }
            }
          }
        },
        "visitorName": "何旭东",
        "visitorTenantName": "湖南敏求",
        "interviewee": {
          "key": "1285060838637436928",
          "data": {
            "id": "1285060838637436928",
            "name": "万超",
            "idCard": "430781199007282512",
            "userId": {
              "key": "1282941883890270208",
              "data": {
                "id": "1282941883890270208",
                "name": "万超",
                "avatar": "http://120.26.66.211:10000/file/2020/07/ce07406d-a32e-4f10-81d6-382effb9b679.jpg",
                "idCard": "430781199007282512",
                "mobile": "13307422738",
                "account": "WC27381594712155681"
              }
            },
            "org": {
              "key": null,
              "data": null
            },
            "station": {
              "key": null,
              "data": null
            },
            "tenantCode": {
              "key": "4301022007002",
              "data": {
                "name": "湖南敏求",
                "area": {
                  "key": "430102000000",
                  "data": "湖南省长沙市芙蓉区"
                }
              }
            }
          }
        },
        "reservationTime": "2020-07-22 16:08:00",
        "partnerNumber": 1,
        "visitMethod": {
          "desc": "名片",
          "code": "VISITING_CARD"
        },
        "visitStatus": {
          "desc": "受访人待确认",
          "code": "INTERVIEWEE_WAIT_VERIFY"
        },
        "personType": {
          "desc": "拜访人",
          "code": "VISITOR"
        },
        "showStatusName": "受访人待确认"
      }
    ],
    "total": "1",
    "size": "20",
    "current": "1",
    "orders": [
      1
    ],
    "hitCount": false,
    "searchCount": true,
    "pages": "1"
  },
  "msg": "操作成功",
  "path": null,
  "extra": null,
  "timestamp": "1595389240300",
  "isSuccess": true,
  "isError": false
} 
*/

  int code;
  visitorDataModelData data;
  String msg;
  String path;
  String extra;
  String timestamp;
  bool isSuccess;
  bool isError;

  visitorDataModel({
    this.code,
    this.data,
    this.msg,
    this.path,
    this.extra,
    this.timestamp,
    this.isSuccess,
    this.isError,
  });
  visitorDataModel.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    data = json["data"] != null ? visitorDataModelData.fromJson(json["data"]) : null;
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