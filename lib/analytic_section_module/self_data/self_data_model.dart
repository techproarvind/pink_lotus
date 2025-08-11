class SelfDataModel {
  List<Data>? data;
  double? loadTime;
  dynamic url;

  SelfDataModel({this.data, this.loadTime, this.url});

  SelfDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    loadTime = json['load_time'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['load_time'] = loadTime;
    data['url'] = url;
    return data;
  }
}

class Data {
  dynamic dATE;
  dynamic hOUROFDAY;
  dynamic numberofHits;
  dynamic sHELFID;
  dynamic zONE;

  Data({this.dATE, this.hOUROFDAY, this.numberofHits, this.sHELFID, this.zONE});

  Data.fromJson(Map<String, dynamic> json) {
    dATE = json['DATE'];
    hOUROFDAY = json['HOUROFDAY'];
    numberofHits = json['NumberofHits'];
    sHELFID = json['SHELF_ID'];
    zONE = json['ZONE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DATE'] = dATE;
    data['HOUROFDAY'] = hOUROFDAY;
    data['NumberofHits'] = numberofHits;
    data['SHELF_ID'] = sHELFID;
    data['ZONE'] = zONE;
    return data;
  }
}
