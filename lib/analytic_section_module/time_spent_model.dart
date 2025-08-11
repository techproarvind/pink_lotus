class TimeSpentModel {
  final String insightsDf;
  final String insightsFilterType;
  final List<dynamic> labels;
  final String url;
  final List<dynamic> values;

  TimeSpentModel({
    required this.insightsDf,
    required this.insightsFilterType,
    required this.labels,
    required this.url,
    required this.values,
  });

  factory TimeSpentModel.fromJson(Map<String, dynamic> json) {
    return TimeSpentModel(
      insightsDf: json['insights_df'] ?? '',
      insightsFilterType: json['insights_filter_type'] ?? '',
      labels: json['labels'] ?? [],
      url: json['url'] ?? '',
      values: json['values'] ?? [],
    );
  }

  double get averageValue {
    if (values.isEmpty) return 0.0;
    final numericValues =
        values.map((e) {
          if (e is String) return double.tryParse(e) ?? 0.0;
          if (e is int) return e.toDouble();
          return e as double;
        }).toList();
    return numericValues.reduce((a, b) => a + b) / numericValues.length;
  }

  List<int> get intValues =>
      values.map((e) {
        if (e is String) return double.tryParse(e)?.round() ?? 0;
        if (e is int) return e;
        return 0;
      }).toList();
}
