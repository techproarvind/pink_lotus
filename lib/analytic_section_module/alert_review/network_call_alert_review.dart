import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pinklotus/analytic_section_module/alert_review/alert_camera_model.dart';
import 'package:pinklotus/analytic_section_module/alert_review/alert_review_model.dart';
import 'package:pinklotus/network_call/base_network.dart';

class AlertService {
  Future<AlertResponse?> fetchPageAlerts(
    String loginId,
    String store,

    String zone,
  ) async {
    print("loginId: $loginId");
    print("store: $store");

    print("zone: $zone");

    final today = DateTime.now();

    // Find current week's Monday
    final currentMonday = today.subtract(Duration(days: today.weekday - 1));

    // Previous week's Monday and Sunday
    final prevMonday = currentMonday.subtract(Duration(days: 7));
    final prevSunday = currentMonday.subtract(Duration(days: 1));

    // Format the dates
    final formatter = DateFormat('yyyy-MM-dd');
    final fromDate = formatter.format(prevMonday);
    final toDate = formatter.format(prevSunday);

    print("toDate=====$fromDate, $toDate");
    try {
      final response = await http.get(
        Uri.parse(
          '${BaseNetwork.baseUrl}/alerts_page?login_id=$loginId&store=$store&fromdate=$fromDate&todate=$toDate&zone=$zone',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("alert response: $data");
        return AlertResponse.fromJson(data);
      } else {
        print("Failed to load alerts. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching alerts: $e");
      return null;
    }
  }

    Future<AlertReviewModel?> fetchAlertsReview(
  ) async {


    try {
      final response = await http.get(
        Uri.parse(
          '${BaseNetwork.baseUrl}/api/weekly_report',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("alert response: $data");
        return AlertReviewModel.fromJson(data);
      } else {
        print("Failed to load alerts. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching alerts: $e");
      return null;
    }
  }
}
