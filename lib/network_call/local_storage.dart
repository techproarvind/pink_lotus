import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  /// Save token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert the entire object to JSON string
    String jsonString = jsonEncode(userData);

    await prefs.setString('user_data', jsonString);
    print('User data saved successfully.');
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString('user_data');

    if (jsonString != null) {
      return jsonDecode(jsonString);
    } else {
      print('No user data found.');
      return null;
    }
  }

  /// Save userId
  static Future<void> saveUserId(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, token);
  }

  /// Get userId
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  /// Delete token (on logout)
  static Future<void> clearLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


}
