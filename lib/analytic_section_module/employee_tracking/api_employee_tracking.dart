import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinklotus/network_call/base_network.dart';
import 'employee_tracking_model.dart'; // Import your model

class ApiServiceEmployeeTracking {
  static Future<EmployeeTrackingModel?> fetchData({
    required DateTime fromDate,
    required DateTime toDate,
    required List<String> selection,
    required List<String> stores,
    required List<String> days,
    required List<String> hours,
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
    print("apicalling employyedata$queryString");

    final url = Uri.parse(
      // 2025-07-02, ALL
      "${BaseNetwork.baseUrl}/analytics_api/employeetracking_filter_data_flutter?&$queryString",
    ); // Replace with actual API if different

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("$jsonData-jonsEmployeeData");
        return EmployeeTrackingModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
    }

    return null;
  }
}
