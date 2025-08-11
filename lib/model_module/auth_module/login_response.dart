class LoginApiResponseModel {
  dynamic rEGION;
  List<String>? sTORES;
  dynamic desiginationName;
  dynamic empName;
  dynamic imageUrl;
  dynamic level;
  dynamic masterStorelist;
  dynamic section;
  dynamic status;
  StoreMapping? storeMapping;
  dynamic token;
  dynamic userDesignation;
  dynamic userprivileges;
  dynamic zones;

  LoginApiResponseModel({
    this.rEGION,
    this.sTORES,
    this.desiginationName,
    this.empName,
    this.imageUrl,
    this.level,
    this.masterStorelist,
    this.section,
    this.status,
    this.storeMapping,
    this.token,
    this.userDesignation,
    this.userprivileges,
    this.zones,
  });

  LoginApiResponseModel.fromJson(Map<String, dynamic> json) {
    rEGION = json['REGION'];
    sTORES = json['STORES'].cast<String>();
    desiginationName = json['desigination_name'];
    empName = json['emp_name'];
    imageUrl = json['image_url'];
    level = json['level'];
    masterStorelist = json['master_storelist'];
    section = json['section'];
    status = json['status'];
    storeMapping =
        json['store_mapping'] != null
            ? new StoreMapping.fromJson(json['store_mapping'])
            : null;
    token = json['token'];
    userDesignation = json['user_designation'];
    userprivileges = json['userprivileges'];
    zones = json['zones'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REGION'] = this.rEGION;
    data['STORES'] = this.sTORES;
    data['desigination_name'] = this.desiginationName;
    data['emp_name'] = this.empName;
    data['image_url'] = this.imageUrl;
    data['level'] = this.level;
    data['master_storelist'] = this.masterStorelist;
    data['section'] = this.section;
    data['status'] = this.status;
    if (this.storeMapping != null) {
      data['store_mapping'] = this.storeMapping!.toJson();
    }
    data['token'] = this.token;
    data['user_designation'] = this.userDesignation;
    data['userprivileges'] = this.userprivileges;
    data['zones'] = this.zones;
    return data;
  }
}

class StoreMapping {
  GMRHDF? gMRHDF;

  StoreMapping({this.gMRHDF});

  StoreMapping.fromJson(Map<String, dynamic> json) {
    gMRHDF =
        json['GMRHDF'] != null ? new GMRHDF.fromJson(json['GMRHDF']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gMRHDF != null) {
      data['GMRHDF'] = this.gMRHDF!.toJson();
    }
    return data;
  }
}

class GMRHDF {
  BILLINGCOUNTER? bILLINGCOUNTER;
  CHOCOLATE? cHOCOLATE;
  ENTRANCE? eNTRANCE;
  EXIT? eXIT;
  LIQUOR? lIQUOR;
  OPTICALS? oPTICALS;
  PATHWAY? pATHWAY;
  PERFUMES? pERFUMES;
  TOBACCO? tOBACCO;
  WATCHES? wATCHES;

  GMRHDF({
    this.bILLINGCOUNTER,
    this.cHOCOLATE,
    this.eNTRANCE,
    this.eXIT,
    this.lIQUOR,
    this.oPTICALS,
    this.pATHWAY,
    this.pERFUMES,
    this.tOBACCO,
    this.wATCHES,
  });

  GMRHDF.fromJson(Map<String, dynamic> json) {
    bILLINGCOUNTER =
        json['BILLING_COUNTER'] != null
            ? new BILLINGCOUNTER.fromJson(json['BILLING_COUNTER'])
            : null;
    cHOCOLATE =
        json['CHOCOLATE'] != null
            ? new CHOCOLATE.fromJson(json['CHOCOLATE'])
            : null;
    eNTRANCE =
        json['ENTRANCE'] != null
            ? new ENTRANCE.fromJson(json['ENTRANCE'])
            : null;
    eXIT = json['EXIT'] != null ? new EXIT.fromJson(json['EXIT']) : null;
    lIQUOR =
        json['LIQUOR'] != null ? new LIQUOR.fromJson(json['LIQUOR']) : null;
    oPTICALS =
        json['OPTICALS'] != null
            ? new OPTICALS.fromJson(json['OPTICALS'])
            : null;
    pATHWAY =
        json['PATH_WAY'] != null
            ? new PATHWAY.fromJson(json['PATH_WAY'])
            : null;
    pERFUMES =
        json['PERFUMES'] != null
            ? new PERFUMES.fromJson(json['PERFUMES'])
            : null;
    tOBACCO =
        json['TOBACCO'] != null ? new TOBACCO.fromJson(json['TOBACCO']) : null;
    wATCHES =
        json['WATCHES'] != null ? new WATCHES.fromJson(json['WATCHES']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bILLINGCOUNTER != null) {
      data['BILLING_COUNTER'] = this.bILLINGCOUNTER!.toJson();
    }
    if (this.cHOCOLATE != null) {
      data['CHOCOLATE'] = this.cHOCOLATE!.toJson();
    }
    if (this.eNTRANCE != null) {
      data['ENTRANCE'] = this.eNTRANCE!.toJson();
    }
    if (this.eXIT != null) {
      data['EXIT'] = this.eXIT!.toJson();
    }
    if (this.lIQUOR != null) {
      data['LIQUOR'] = this.lIQUOR!.toJson();
    }
    if (this.oPTICALS != null) {
      data['OPTICALS'] = this.oPTICALS!.toJson();
    }
    if (this.pATHWAY != null) {
      data['PATH_WAY'] = this.pATHWAY!.toJson();
    }
    if (this.pERFUMES != null) {
      data['PERFUMES'] = this.pERFUMES!.toJson();
    }
    if (this.tOBACCO != null) {
      data['TOBACCO'] = this.tOBACCO!.toJson();
    }
    if (this.wATCHES != null) {
      data['WATCHES'] = this.wATCHES!.toJson();
    }
    return data;
  }
}

class BILLINGCOUNTER {
  List<String>? bILLINGCOUNTER2;
  List<String>? bILLINGCOUNTER3;
  List<String>? bILLINGCOUNTER4;
  List<String>? bILLINGCOUNTER5;
  List<String>? bILLINGCOUNTER6;
  List<String>? bILLINGCOUNTER7;
  List<String>? bILLINGCOUNTER9;

  BILLINGCOUNTER({
    this.bILLINGCOUNTER2,
    this.bILLINGCOUNTER3,
    this.bILLINGCOUNTER4,
    this.bILLINGCOUNTER5,
    this.bILLINGCOUNTER6,
    this.bILLINGCOUNTER7,
    this.bILLINGCOUNTER9,
  });

  BILLINGCOUNTER.fromJson(Map<String, dynamic> json) {
    bILLINGCOUNTER2 = json['BILLING_COUNTER_2'].cast<String>();
    bILLINGCOUNTER3 = json['BILLING_COUNTER_3'].cast<String>();
    bILLINGCOUNTER4 = json['BILLING_COUNTER_4'].cast<String>();
    bILLINGCOUNTER5 = json['BILLING_COUNTER_5'].cast<String>();
    bILLINGCOUNTER6 = json['BILLING_COUNTER_6'].cast<String>();
    bILLINGCOUNTER7 = json['BILLING_COUNTER_7'].cast<String>();
    bILLINGCOUNTER9 = json['BILLING_COUNTER_9'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BILLING_COUNTER_2'] = this.bILLINGCOUNTER2;
    data['BILLING_COUNTER_3'] = this.bILLINGCOUNTER3;
    data['BILLING_COUNTER_4'] = this.bILLINGCOUNTER4;
    data['BILLING_COUNTER_5'] = this.bILLINGCOUNTER5;
    data['BILLING_COUNTER_6'] = this.bILLINGCOUNTER6;
    data['BILLING_COUNTER_7'] = this.bILLINGCOUNTER7;
    data['BILLING_COUNTER_9'] = this.bILLINGCOUNTER9;
    return data;
  }
}

class CHOCOLATE {
  List<String>? cHOCOLATE1;
  List<String>? cHOCOLATE2;
  List<String>? cHOCOLATE3;
  List<String>? cHOCOLATE6;

  CHOCOLATE({
    this.cHOCOLATE1,
    this.cHOCOLATE2,
    this.cHOCOLATE3,
    this.cHOCOLATE6,
  });

  CHOCOLATE.fromJson(Map<String, dynamic> json) {
    cHOCOLATE1 = json['CHOCOLATE_1'].cast<String>();
    cHOCOLATE2 = json['CHOCOLATE_2'].cast<String>();
    cHOCOLATE3 = json['CHOCOLATE_3'].cast<String>();
    cHOCOLATE6 = json['CHOCOLATE_6'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CHOCOLATE_1'] = this.cHOCOLATE1;
    data['CHOCOLATE_2'] = this.cHOCOLATE2;
    data['CHOCOLATE_3'] = this.cHOCOLATE3;
    data['CHOCOLATE_6'] = this.cHOCOLATE6;
    return data;
  }
}

class ENTRANCE {
  List<String>? eNTRANCE1;

  ENTRANCE({this.eNTRANCE1});

  ENTRANCE.fromJson(Map<String, dynamic> json) {
    eNTRANCE1 = json['ENTRANCE_1'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ENTRANCE_1'] = this.eNTRANCE1;
    return data;
  }
}

class EXIT {
  List<String>? eXIT;

  EXIT({this.eXIT});

  EXIT.fromJson(Map<String, dynamic> json) {
    eXIT = json['EXIT'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EXIT'] = this.eXIT;
    return data;
  }
}

class LIQUOR {
  List<String>? lIQUOR1;
  List<String>? lIQUOR10;
  List<String>? lIQUOR11;
  List<String>? lIQUOR2;
  List<String>? lIQUOR3;
  List<String>? lIQUOR5;
  List<String>? lIQUOR6;
  List<String>? lIQUOR7;
  List<String>? lIQUOR8;
  List<String>? lIQUOR9;

  LIQUOR({
    this.lIQUOR1,
    this.lIQUOR10,
    this.lIQUOR11,
    this.lIQUOR2,
    this.lIQUOR3,
    this.lIQUOR5,
    this.lIQUOR6,
    this.lIQUOR7,
    this.lIQUOR8,
    this.lIQUOR9,
  });

  LIQUOR.fromJson(Map<String, dynamic> json) {
    lIQUOR1 = json['LIQUOR_1'].cast<String>();
    lIQUOR10 = json['LIQUOR_10'].cast<String>();
    lIQUOR11 = json['LIQUOR_11'].cast<String>();
    lIQUOR2 = json['LIQUOR_2'].cast<String>();
    lIQUOR3 = json['LIQUOR_3'].cast<String>();
    lIQUOR5 = json['LIQUOR_5'].cast<String>();
    lIQUOR6 = json['LIQUOR_6'].cast<String>();
    lIQUOR7 = json['LIQUOR_7'].cast<String>();
    lIQUOR8 = json['LIQUOR_8'].cast<String>();
    lIQUOR9 = json['LIQUOR_9'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LIQUOR_1'] = this.lIQUOR1;
    data['LIQUOR_10'] = this.lIQUOR10;
    data['LIQUOR_11'] = this.lIQUOR11;
    data['LIQUOR_2'] = this.lIQUOR2;
    data['LIQUOR_3'] = this.lIQUOR3;
    data['LIQUOR_5'] = this.lIQUOR5;
    data['LIQUOR_6'] = this.lIQUOR6;
    data['LIQUOR_7'] = this.lIQUOR7;
    data['LIQUOR_8'] = this.lIQUOR8;
    data['LIQUOR_9'] = this.lIQUOR9;
    return data;
  }
}

class OPTICALS {
  List<String>? oPTICALS1;
  List<String>? oPTICALS2;

  OPTICALS({this.oPTICALS1, this.oPTICALS2});

  OPTICALS.fromJson(Map<String, dynamic> json) {
    oPTICALS1 = json['OPTICALS_1'].cast<String>();
    oPTICALS2 = json['OPTICALS_2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OPTICALS_1'] = this.oPTICALS1;
    data['OPTICALS_2'] = this.oPTICALS2;
    return data;
  }
}

class PATHWAY {
  List<String>? pATHWAY;
  List<String>? pATHWAY1;
  List<String>? pATHWAY2;

  PATHWAY({this.pATHWAY, this.pATHWAY1, this.pATHWAY2});

  PATHWAY.fromJson(Map<String, dynamic> json) {
    pATHWAY = json['PATH_WAY'].cast<String>();
    pATHWAY1 = json['PATH_WAY-1'].cast<String>();
    pATHWAY2 = json['PATH_WAY-2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PATH_WAY'] = this.pATHWAY;
    data['PATH_WAY-1'] = this.pATHWAY1;
    data['PATH_WAY-2'] = this.pATHWAY2;
    return data;
  }
}

class PERFUMES {
  List<String>? pERFUMES1;
  List<String>? pERFUMES2;

  PERFUMES({this.pERFUMES1, this.pERFUMES2});

  PERFUMES.fromJson(Map<String, dynamic> json) {
    pERFUMES1 = json['PERFUMES_1'].cast<String>();
    pERFUMES2 = json['PERFUMES_2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PERFUMES_1'] = this.pERFUMES1;
    data['PERFUMES_2'] = this.pERFUMES2;
    return data;
  }
}

class TOBACCO {
  List<String>? tOBACCO;

  TOBACCO({this.tOBACCO});

  TOBACCO.fromJson(Map<String, dynamic> json) {
    tOBACCO = json['TOBACCO'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOBACCO'] = this.tOBACCO;
    return data;
  }
}

class WATCHES {
  List<String>? wATCHES;

  WATCHES({this.wATCHES});

  WATCHES.fromJson(Map<String, dynamic> json) {
    wATCHES = json['WATCHES'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WATCHES'] = this.wATCHES;
    return data;
  }
}
