class EmployeeTrackingModel {
  List<Data>? data;
  double? loadTime;
  String? url;

  EmployeeTrackingModel({this.data, this.loadTime, this.url});

  EmployeeTrackingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    loadTime = json['load_time'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['load_time'] = this.loadTime;
    data['url'] = this.url;
    return data;
  }
}

class Data {
  String? s1stINTIME;
  String? dATE;
  int? eMPID;
  String? lastOUTTIME;
  String? tOTALTIMESPENTONFLOOR;

  Data(
      {this.s1stINTIME,
      this.dATE,
      this.eMPID,
      this.lastOUTTIME,
      this.tOTALTIMESPENTONFLOOR});

  Data.fromJson(Map<String, dynamic> json) {
    s1stINTIME = json['1st IN TIME'];
    dATE = json['DATE'];
    eMPID = json['EMP_ID'];
    lastOUTTIME = json['Last OUT TIME'];
    tOTALTIMESPENTONFLOOR = json['TOTAL TIME SPENT ON FLOOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1st IN TIME'] = this.s1stINTIME;
    data['DATE'] = this.dATE;
    data['EMP_ID'] = this.eMPID;
    data['Last OUT TIME'] = this.lastOUTTIME;
    data['TOTAL TIME SPENT ON FLOOR'] = this.tOTALTIMESPENTONFLOOR;
    return data;
  }
}

