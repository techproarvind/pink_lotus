class AlertCameraModel {
  final dynamic filename;
  final dynamic camNo;
  final dynamic alertReason;
  final dynamic alertTime;
  final dynamic comments;
  final dynamic timestampFeedback;
  final dynamic feedback;
  final dynamic currStatus;
  final dynamic transtype;
  final dynamic store;
  final dynamic notificationId;
  final dynamic zone;
  final dynamic section;
  final dynamic category;
  final dynamic notificationCat;

  AlertCameraModel({
    required this.filename,
    required this.camNo,
    required this.alertReason,
    required this.alertTime,
    required this.comments,
    required this.timestampFeedback,
    required this.feedback,
    required this.currStatus,
    required this.transtype,
    required this.store,
    required this.notificationId,
    required this.zone,
    required this.section,
    required this.category,
    required this.notificationCat,
  });

  factory AlertCameraModel.fromJson(Map<dynamic, dynamic> json) {
    return AlertCameraModel(
      filename: json['FILENAME'] ?? '',
      camNo: json['CAM_NO'] ?? '',
      alertReason: json['Alert_reason'] ?? '',
      alertTime: json['Alert_Time'] ?? '',
      comments: json['Comments'] ?? '',
      timestampFeedback: json['Timestamp_feedback'] ?? '',
      feedback: json['Feedback'] ?? '',
      currStatus: json['Curr_Status'] ?? '',
      transtype: json['TRANSTYPE'] ?? '',
      store: json['STORE'] ?? '',
      notificationId: json['NotificationID'] ?? 0,
      zone: json['ZONE'] ?? '',
      section: json['SECTION'] ?? '',
      category: json['13'] ?? '',
      notificationCat: json['NOTIFICATION_CAT'] ?? '',
    );
  }
}

class AlertResponse {
  final List<AlertCameraModel> others;
  final List<AlertCameraModel> employeeMonitoring;
  final List<AlertCameraModel> storeMaintenance;

  AlertResponse({
    required this.others,
    required this.employeeMonitoring,
    required this.storeMaintenance,
  });

  factory AlertResponse.fromJson(Map<dynamic, dynamic> json) {
    return AlertResponse(
      others:
          (json['OTHERS'] as List<dynamic>?)
              ?.map((e) => AlertCameraModel.fromJson(e))
              .toList() ??
          [],
      employeeMonitoring:
          (json['EMPLOYEE MONITORING'] as List<dynamic>?)
              ?.map((e) => AlertCameraModel.fromJson(e))
              .toList() ??
          [],
      storeMaintenance:
          (json['STORE MAINTENANCE'] as List<dynamic>?)
              ?.map((e) => AlertCameraModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
