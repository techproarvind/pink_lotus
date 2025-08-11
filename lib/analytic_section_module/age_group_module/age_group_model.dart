class AgeGroupModelData {
  final List<dynamic> labels;
  final List<int> adultData;
  final List<int> kidsData;
  final String insightsFilterType;
  final String url;

  AgeGroupModelData({
    required this.labels,
    required this.adultData,
    required this.kidsData,
    required this.insightsFilterType,
    required this.url,
  });

  factory AgeGroupModelData.fromJson(Map<String, dynamic> json) {
    return AgeGroupModelData(
      labels: (json['labels'] as List).map((e) => e.toString()).toList(),
      adultData: List<int>.from(json['adultData']),
      kidsData: List<int>.from(json['kidsData']),
      insightsFilterType: json['insights_filter_type'],
      url: json['url'],
    );
  }
}

class AgeGroupFilterModel {
  List<int>? adultData;
  String? insightsDf;
  List<int>? kidsData;
  List<String>? labels;
  double? loadTime;
  String? url;

  AgeGroupFilterModel({
    this.adultData,
    this.insightsDf,
    this.kidsData,
    this.labels,
    this.loadTime,
    this.url,
  });

  AgeGroupFilterModel.fromJson(Map<String, dynamic> json) {
    adultData = json['adultData'].cast<int>();
    insightsDf = json['insights_df'];
    kidsData = json['kidsData'].cast<int>();
    labels = json['labels'].cast<String>();
    loadTime = json['load_time'];

    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adultData'] = this.adultData;
    data['insights_df'] = this.insightsDf;
    data['kidsData'] = this.kidsData;
    data['labels'] = this.labels;
    data['load_time'] = this.loadTime;

    data['url'] = this.url;
    return data;
  }
}
