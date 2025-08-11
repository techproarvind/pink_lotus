import 'package:dio/dio.dart';
import 'package:pinklotus/camera_status_module/network_call/camera_main_model.dart' as camera;
import 'package:pinklotus/network_call/base_network.dart';

Future<List<camera.Camera>> fetchCameraList({
  required String loginId,
  required String token,
  String store = "All",
  String zone = "All",
  String section = "All",
}) async {
  final Dio dio = Dio();
   String url =
      "${BaseNetwork.baseUrl}/w_cameras?login_id=$loginId&token=$token&store=$store&zone=$zone&section=$section";  
        // Change to your actual base URL

  final Map<String, dynamic> requestData = {
    "login_id": loginId,
    "token": token,
    "store": store,
    "zone": zone,
    "section": section,
  };

  try {
    final response = await dio.post(
      url,
      data: requestData,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200 && response.data != null) {
            final data = response.data['camera'] as List<dynamic>;

           return data.map((e) => camera.Camera.fromJson(e)).toList();

     
    } else {
      print("⚠️ Unexpected response status: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❌ Error during API call to /w_cameras: $e");
    return [];
  }
}


Future<Map<String, dynamic>> fetchStoreOptions() async {
  final Dio dio = Dio();
   String url = '${BaseNetwork.baseUrl}/w_cam_options'; // 🔁 Update if needed

  try {
    final response = await dio.get(
      url,
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200 && response.data != null) {
      print("✅ Response: ${response.data}");
      return Map<String, dynamic>.from(response.data);
    } else {
      print("⚠️ Unexpected status code: ${response.statusCode}");
      return {};
    }
  } catch (e) {
    print("❌ Error calling /w_cam_options: $e");
    return {};
  }
}

