import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pinklotus/dashboard_module/network_call/message_dashboard_model.dart';
import 'package:pinklotus/network_call/base_network.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchDashboardData({
  required String loginId,
  required String token,
  required String execBlock, // 'All', '5', '4'
  required String filterCategory, // e.g. 'STORE'
}) async {
  String url =
      '${BaseNetwork.baseUrl}/dashboard_page'; // ✅ Replace with real API

  final Dio dio = Dio();

  final Map<String, dynamic> requestData = {
    "login_id": loginId,
    "token": token,
    "exec_block": execBlock,
    "filter_category": filterCategory,
  };

  try {
    final Response response = await dio.post(url, data: requestData);

    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null && data is Map<String, dynamic>) {
        debugPrint("✅ Dashboard API Success: $data");
        return data;
      } else {
        debugPrint("⚠️ Unexpected response format.");
        return null;
      }
    } else {
      debugPrint("❌ HTTP Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    debugPrint("🚨 Exception: $e");
    return null;
  }
}

Future<void> fetchEmployeeLogs() async {
  final Dio dio = Dio();

  String url = '${BaseNetwork.baseUrl}/employee_log';

  try {
    final Response response = await dio.post(
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      final data = response.data;

      if (data is List) {
        for (var employee in data) {
          print('👤 EMPLOYEE ID: ${employee["EMPLOYEE ID"]}');
          print('📛 NAME: ${employee["EMPLOYEE NAME"]}');
          print('🏢 DEPARTMENT: ${employee["DEPARTMENT"]}');
          print('🎖 DESIGNATION: ${employee["DESIGNATION"]}');
          print('🕘 IN TIME: ${employee["TODAY IN TIME"]}');
          print('👀 LAST SEEN: ${employee["LAST SEEN TIME"]}');
          print('📷 CAMERA: ${employee["LAST SEEN CAMERA"]}');
          print('-------------------------');
        }
      } else {
        print("❌ Unexpected response format: $data");
      }
    } else {
      print("❌ Failed with status: ${response.statusCode}");
    }
  } on DioException catch (e) {
    if (e.response != null) {
      print("🚨 Error Response: ${e.response?.data}");
    } else {
      print("⚠️ Network/Other Error: ${e.message}");
    }
  } catch (e) {
    print("🛑 Unexpected error: $e");
  }
}

Future<List<MessageDahsboardModel>> fetchMessageBoardTimeline() async {
  String url = '${BaseNetwork.baseUrl}/message_board';
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return parseAlerts(jsonList);
    } else {
      print("⚠️ Unexpected response: ${response}");
      return [];
    }
  } catch (e) {
    print("❌ Error fetching message board: $e");
    return [];
  }

  
}

List<MessageDahsboardModel> parseAlerts(List<dynamic> data) {
  return data.map((item) => MessageDahsboardModel.fromJson(item)).toList();
}


Future<Map<String, dynamic>> fetchAlertsPage({
  required String loginId,
  String store = 'All',
  String fromDate = '',
  String toDate = '',
  String zone = 'All',
}) async {
  final Dio dio = Dio();
  String url =
      '${BaseNetwork.baseUrl}/alerts_page'; // Update base URL if different

  final Map<String, dynamic> requestData = {
    "login_id": loginId,
    "store": store,
    "fromdate":
        fromDate.isEmpty
            ? DateTime.now().toIso8601String().split("T")[0]
            : fromDate,
    "todate":
        toDate.isEmpty
            ? DateTime.now().toIso8601String().split("T")[0]
            : toDate,
    "zone": zone,
  };

  try {
    final response = await dio.get(
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
      queryParameters: requestData,
    );

    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      debugPrint("✅ Alerts fetched successfully.");
      return Map<String, dynamic>.from(response.data);
    } else {
      debugPrint("⚠️ Unexpected response: ${response.statusCode}");
      return {};
    }
  } catch (e) {
    debugPrint("❌ Error fetching alerts: $e");
    return {};
  }
}
