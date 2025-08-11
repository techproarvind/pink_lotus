import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pinklotus/model_module/auth_module/login_response.dart';
import 'package:pinklotus/network_call/base_network.dart';

Future<LoginApiResponseModel?> loginUser({
  required String loginId,
  required String password,
}) async {
   String url = '${BaseNetwork.baseUrl}/wlogin'; // 🔁 Update this URL

  final Dio dio = Dio();

  try {
    final response = await dio.post(
      url,
      data: {"login_id": loginId, "password": password},
    );

    debugPrint('Status: ${response.statusCode}');
    debugPrint('Response: ${response.data}');

    if (response.statusCode == 200) {
      final data = response.data;

      if (data['status'] == 'Success') {
        return LoginApiResponseModel.fromJson(data);
      } else {
        // Handle error statuses like:
        // - "Enter user id and Password"
        // - "Username and Password doesn't match"
        // - "LoginID does not exist"
        debugPrint('Login failed: ${data['status']}');
        return LoginApiResponseModel(status: data['status']);
      }
    } else {
      debugPrint('Unexpected status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    debugPrint('Login Error: $e');
    return null;
  }
}
