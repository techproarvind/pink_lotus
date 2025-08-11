class AlertReviewModel {
  List<DailyData>? dailyData;
  dynamic endDate;
  dynamic startDate;
  dynamic storeCode;
  dynamic weekNumber;

  AlertReviewModel({
    this.dailyData,
    this.endDate,
    this.startDate,
    this.storeCode,
    this.weekNumber,
  });

  AlertReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['daily_data'] != null) {
      dailyData = <DailyData>[];
      json['daily_data'].forEach((v) {
        dailyData!.add(new DailyData.fromJson(v));
      });
    }
    endDate = json['end_date'];
    startDate = json['start_date'];
    storeCode = json['store_code'];
    weekNumber = json['week_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dailyData != null) {
      data['daily_data'] = this.dailyData!.map((v) => v.toJson()).toList();
    }
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['store_code'] = this.storeCode;
    data['week_number'] = this.weekNumber;
    return data;
  }
}

class DailyData {
  dynamic date;
  dynamic notifications;
  dynamic resolvePercent;

  DailyData({this.date, this.notifications, this.resolvePercent});

  DailyData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    notifications = json['notifications'];
    resolvePercent = json['resolve_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['notifications'] = this.notifications;
    data['resolve_percent'] = this.resolvePercent;
    return data;
  }
}
