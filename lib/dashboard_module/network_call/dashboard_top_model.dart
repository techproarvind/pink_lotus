class DashboardTopModel {
  dynamic aLERTS;
  dynamic cAMERAS;
  dynamic sTOREDATA;
  dynamic sTORES;
  List<StoreWiseAlerts>? storeWiseAlerts;

  DashboardTopModel({
    this.aLERTS,
    this.cAMERAS,
    this.sTOREDATA,
    this.sTORES,
    this.storeWiseAlerts,
  });

  DashboardTopModel.fromJson(Map<String, dynamic> json) {
    aLERTS = json['ALERTS'];
    cAMERAS = json['CAMERAS'];
    sTOREDATA = json['STOREDATA'];
    sTORES = json['STORES'];
    if (json['StoreWiseAlerts'] != null) {
      storeWiseAlerts = <StoreWiseAlerts>[];
      json['StoreWiseAlerts'].forEach((v) {
        storeWiseAlerts!.add(new StoreWiseAlerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ALERTS'] = this.aLERTS;
    data['CAMERAS'] = this.cAMERAS;
    data['STOREDATA'] = this.sTOREDATA;
    data['STORES'] = this.sTORES;
    if (this.storeWiseAlerts != null) {
      data['StoreWiseAlerts'] =
          this.storeWiseAlerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreWiseAlerts {
  dynamic sTORE;
  dynamic no;
  dynamic yes;

  StoreWiseAlerts({this.sTORE, this.no, this.yes});

  StoreWiseAlerts.fromJson(Map<String, dynamic> json) {
    sTORE = json['STORE'];
    no = json['no'];
    yes = json['yes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STORE'] = this.sTORE;
    data['no'] = this.no;
    data['yes'] = this.yes;
    return data;
  }
}
