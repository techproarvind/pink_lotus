import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart' show mime;
import 'package:path/path.dart';
import 'package:file_selector/file_selector.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinklotus/network_call/base_network.dart';
import 'package:http_parser/http_parser.dart'; // 👈 Required for MediaType

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class ProfileService {
  static const String _endpoint = '/ccweb_edit_profile';

  // Check and request storage permissions (for desktop)
  static Future<bool> _checkPermissions() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // On desktop, we typically don't need runtime permissions, but we'll check file access
      return true;
    }

    // For mobile (if you later adapt this code)
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // Pick an image file
  static Future<File?> pickProfileImage() async {
    try {
      final XFile? file = await openFile(
        acceptedTypeGroups: [
          XTypeGroup(label: 'Images', extensions: ['jpg', 'jpeg', 'png']),
        ],
      );
      return file != null ? File(file.path) : null;
    } catch (e) {
      _showToast('Error selecting image: ${e.toString()}');
      return null;
    }
  }

  // Upload profile with image
  // static Future<bool> updateProfile({
  //   required String empid,
  //   required String empname,
  //   required String designation,
  //   required String storename,
  //   required String mobileno,
  //   required String companyname,
  //   File? profileImage,
  //   Function(int, int)? onUploadProgress,
  // }) async {
  //   try {
  //     // Check permissions
  //     if (!await _checkPermissions()) {
  //       _showToast('Permission denied to access storage');
  //       return false;
  //     }

  //     // Create multipart request
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse("${BaseNetwork.baseUrl}$_endpoint"),
  //     );

  //     // Add text fields
  //     request.fields.addAll({
  //       'empid': empid,
  //       'empname': empname,
  //       'designation': designation,
  //       'storename': storename,
  //       'mobileno': mobileno,
  //       'companyname': companyname,
  //     });

  //     // Add image if provided
  //     if (profileImage != null) {
  //       // Validate image
  //       final mimeType = mime(profileImage.path);
  //       if (mimeType == null ||
  //           !['image/jpeg', 'image/png'].contains(mimeType)) {
  //         _showToast('Invalid image type. Only JPEG/PNG allowed');
  //         return false;
  //       }

  //       // Check file size (e.g., 5MB limit)
  //       if (await profileImage.length() > 5 * 1024 * 1024) {
  //         _showToast('Image too large. Max 5MB allowed');
  //         return false;
  //       }

  //       // Add file to request
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'profilepic',
  //           profileImage.path,
  //           filename:
  //               'profile_${DateTime.now().millisecondsSinceEpoch}${extension(profileImage.path)}',
  //         ),
  //       );
  //     }

  //     // Track upload progress
  //     final streamedResponse = await request.send();

  //     // Listen for progress if callback provided
  //     if (onUploadProgress != null) {
  //       int totalBytes = request.contentLength;
  //       int bytesUploaded = 0;

  //       streamedResponse.stream.listen((List<int> chunk) {
  //         bytesUploaded += chunk.length;
  //         onUploadProgress(bytesUploaded, totalBytes);
  //       }, onDone: () => onUploadProgress(totalBytes, totalBytes));
  //     }

  //     // Get response
  //     final response = await http.Response.fromStream(streamedResponse);
  //     final jsonResponse = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       _showToast('Profile updated successfully!');
  //       return true;
  //     } else {
  //       _showToast(jsonResponse['error'] ?? 'Failed to update profile');
  //       return false;
  //     }
  //   } catch (e) {
  //     _showToast('Error: ${e.toString()}');
  //     return false;
  //   }
  // }

  static Future<bool> editEmployeeProfile({
  required String empid,
  required String empname,
  required String designation,
  required String storename,
  required String mobileno,
  required String companyname,
  File? profileImage,
}) async {
  try {
    var uri = Uri.parse('${BaseNetwork.baseUrl}/ccweb_edit_profile');
    var request = http.MultipartRequest('POST', uri);

    // 🔧 Add text fields
    request.fields.addAll({
      'empid': empid,
      'empname': empname,
      'designation': designation,
      'storename': storename,
      'mobileno': mobileno,
      'companyname': companyname,
    });

    // 🖼️ Add image file if provided
    // if (profileImage != null) {
    //   final mimeType = lookupMimeType(profileImage.path);
    //   if (mimeType == null || !mimeType.startsWith("image/")) {
    //     print('❌ Invalid image type');
    //     return false;
    //   }

    //   request.files.add(
    //     await http.MultipartFile.fromPath(
    //       'profilepic',
    //       profileImage.path,
    //       contentType: MediaType.parse(mimeType),
    //       filename: basename(profileImage.path),
    //     ),
    //   );
    // }

    // 🚀 Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("✅ Success: ${jsonResponse['message']}");
      return true;
    } else {
      print("❌ Server error: ${response.statusCode}");
      print(response.body);
      return true;
    }
  } catch (e) {
    print("⚠️ Exception: $e");
    return true;
  }
}





  static Future<void> uploadProfilePictureDesktop() async {
    try {
      // 🖼️ Pick image from desktop
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null || result.files.single.path == null) {
        print('No image selected.');
        return;
      }

      File imageFile = File(result.files.single.path!);
      String fileName = basename(imageFile.path);
      String? mimeType = lookupMimeType(imageFile.path);

      if (mimeType == null || !(mimeType.startsWith("image/"))) {
        print('Invalid image type');
        return;
      }

      // 💬 Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${BaseNetwork.baseUrl}/upload_profile_pic'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'profilepic',
          imageFile.path,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ),
      );

      // 🚀 Send request
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var jsonData = json.decode(responseBody.body);
        String imageUrl = jsonData['image_url'];
        print('✅ Upload successful! Image URL: $imageUrl');
      } else {
        print('❌ Upload failed: ${response.statusCode}');
        print(responseBody.body);
      }
    } catch (e) {
      print('⚠️ Error uploading image: $e');
    }
  }

  // Helper to show toast messages
  static void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}
