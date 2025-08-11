import 'dart:io';
import 'package:dio/dio.dart';

Future<void> updateEmployeeProfile({
  required String empId,
  required String empName,
  required String designation,
  required String storeName,
  required String mobileNo,
  required String companyName,
  File? profileImageFile, // Optional
}) async {
  final dio = Dio();

  final formData = FormData.fromMap({
    "empid": empId,
    "empname": empName,
    "designation": designation,
    "storename": storeName,
    "mobileno": mobileNo,
    "companyname": companyName,
    if (profileImageFile != null)
      "profilepic": await MultipartFile.fromFile(profileImageFile.path),
  });

  try {
    final response = await dio.post(
      "https://gmrhdf.pinklotus.ai/ccweb_edit_profile",
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200 && response.data['message'] != null) {
      print("✅ Success: ${response.data['message']}");
    } else {
      print("⚠️ Error: Unexpected response - ${response.data}");
    }
  } catch (e) {
    print("❌ API Error: $e");
  }
}
