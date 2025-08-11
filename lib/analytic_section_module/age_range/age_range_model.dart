class InsightAgeGroupModel {
  final List<dynamic> labels;
  final List<int> adultData;
  final List<int> kidsData;
  final List<int> teenData;
  final List<int> youngAdultsData;
  final List<int> middleAgedAdultsData;
  final List<int> olderAdultsData;
  final List<int> seniorAdultsData;
    final String url;



  InsightAgeGroupModel({
    required this.labels,
    required this.adultData,
    required this.kidsData,
    required this.teenData,
    required this.youngAdultsData,
    required this.middleAgedAdultsData,
    required this.olderAdultsData,
    required this.url,
    required this.seniorAdultsData,
  });

  factory InsightAgeGroupModel.fromJson(Map<String, dynamic> json) {
    return InsightAgeGroupModel(
      labels: json['labels'],
      url: json['url'],
      adultData: List<int>.from(json['adultsData']),
      kidsData: List<int>.from(json['kidsData']),
      teenData: List<int>.from(json['teenData']),
      youngAdultsData: List<int>.from(json['youngAdultsData']),
      middleAgedAdultsData: List<int>.from(json['middleAgedAdultsData']),
      olderAdultsData: List<int>.from(json['olderAdultsData']),
      seniorAdultsData: List<int>.from(json['seniorAdultsData']),
    );
  }
}

