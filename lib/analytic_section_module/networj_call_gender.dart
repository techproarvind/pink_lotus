import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinklotus/analytic_section_module/age_group_module/age_group_model.dart';
import 'package:pinklotus/analytic_section_module/age_range/age_range_model.dart';
import 'package:pinklotus/analytic_section_module/self_data/self_data_model.dart';
import 'package:pinklotus/analytic_section_module/time_spent_model.dart';
import 'package:pinklotus/network_call/base_network.dart';

class GenderInsightService {
  static Future<GenderInsightsModel?> fetchInsightData(duration) async {
    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/gender_filter_timeline?filterType=$duration',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return GenderInsightsModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<AgeGroupModelData?> fetchInsightDataAgeGroup(duration) async {
    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/age_filter_timeline?filterType=$duration',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return AgeGroupModelData.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<InsightAgeGroupModel?> fetchInsightDataAgeGroupRange(
    duration,
  ) async {
    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/age_category_timeline?filterType=$duration',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return InsightAgeGroupModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<InsightAgeGroupModel?> fetchInsightDataAgeGroupRangeFilter({
    required List<String> hours,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    String passFromDate =
        "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ...selection.map((e) => 'selectedSections=$e'),
      ...stores.map((e) => 'selectedStores=$e'),
      ...days.map((e) => 'selectedDays=$e'),
      ...hours.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');

    final url = Uri.parse(
      "${BaseNetwork.baseUrl}/analytics_api/age_category_filter_data?&$queryString",
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return InsightAgeGroupModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<SelfDataModel?> fetchSelfDataApiCalling({
    required List<String> hours,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    String passFromDate =
        "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ...selection.map((e) => 'selectedSections=$e'),
      ...stores.map((e) => 'selectedStores=$e'),
      ...days.map((e) => 'selectedDays=$e'),
      ...hours.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');

    final url = Uri.parse(
      "${BaseNetwork.baseUrl}/analytics_api/shelfdata_filter_data_flutter?&$queryString",
    ); // Replace with actual API if different

    debugPrint("selfData${url}");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SelfDataModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<TimeSpentModel?> fetchTimeSpentData(duration) async {
    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/timespent_filter_timeline?filterType=$duration',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TimeSpentModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<TimeSpentModel?> fetchTimeSpentDataFilter({
    required List<String> hours,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required List<String> zones,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    String passFromDate =
        "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ...selection.map((e) => 'selectedSections=$e'),
      ...zones.map((e) => 'selectedZones=$e'),
      ...stores.map((e) => 'selectedStores=$e'),
      ...days.map((e) => 'selectedDays=$e'),
      ...hours.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');

    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/timespent_filter_data?&$queryString',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TimeSpentModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<GenderInsightsModel?> fetchInsightDataFilter({
    required List<String> hours,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    String passFromDate =
        "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ...selection.map((e) => 'selectedSections=$e'),
      ...stores.map((e) => 'selectedStores=$e'),
      ...days.map((e) => 'selectedDays=$e'),
      ...hours.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');

    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/gender_filter_data?&$queryString',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return GenderInsightsModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }

  static Future<AgeGroupFilterModel?> fetchAgeFilterTimeLineFilter({
    required List<String> hours,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    String passFromDate =
        "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ...selection.map((e) => 'selectedSections=$e'),
      ...stores.map((e) => 'selectedStores=$e'),
      ...days.map((e) => 'selectedDays=$e'),
      ...hours.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');
    print("FilterDat==$queryString");

    final url = Uri.parse(
      '${BaseNetwork.baseUrl}/analytics_api/age_filter_data?&$queryString',
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return AgeGroupFilterModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }
}

class GenderInsightsModel {
  final List<int> femaleData;
  final String insightsDf;
  final String insightsFilterType; // "1D", "1W", "1M"
  final List<dynamic> labels; // can be int or String
  final List<int> maleData;
  final String url;

  GenderInsightsModel({
    required this.femaleData,
    required this.insightsDf,
    required this.insightsFilterType,
    required this.labels,
    required this.maleData,
    required this.url,
  });

  factory GenderInsightsModel.fromJson(Map<String, dynamic> json) {
    return GenderInsightsModel(
      femaleData: List<int>.from(json['femaleData']),
      insightsDf: json['insights_df'],
      insightsFilterType: json['insights_filter_type'],
      labels: List<dynamic>.from(json['labels']),
      maleData: List<int>.from(json['maleData']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'femaleData': femaleData,
    'insights_df': insightsDf,
    'insights_filter_type': insightsFilterType,
    'labels': labels,
    'maleData': maleData,
    'url': url,
  };
}

class GenderInsightsModelFilter {
  List<dynamic>? femaleValues;
  String? insightsDf;
  List<dynamic>? labels;
  double? loadTime;
  List<dynamic>? maleValues;
  String? url;

  GenderInsightsModelFilter({
    this.femaleValues,
    this.insightsDf,
    this.labels,
    this.loadTime,
    this.maleValues,
    this.url,
  });

  GenderInsightsModelFilter.fromJson(Map<String, dynamic> json) {
    femaleValues = json['femaleValues'].cast<int>();
    insightsDf = json['insights_df'];
    labels = json['labels'].cast<String>();
    loadTime = json['load_time'];
    maleValues = json['maleValues'].cast<int>();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['femaleValues'] = this.femaleValues;
    data['insights_df'] = this.insightsDf;
    data['labels'] = this.labels;
    data['load_time'] = this.loadTime;
    data['maleValues'] = this.maleValues;
    data['url'] = this.url;
    return data;
  }
}
