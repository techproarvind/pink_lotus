import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinklotus/network_call/base_network.dart';

/// Call this function when you want to show the image
void showShelfImageDialog(BuildContext context, String shelfId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            width: 600,
            height: 400,
            child: FutureBuilder<Uint8List?>(
              future: fetchShelfImage(shelfId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent,));
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const Expanded(
                        child: Center(child: Text("Image not available")),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
  );
}

/// Fetches image as bytes from API
Future<Uint8List?> fetchShelfImage(String shelfId) async {
  final url = Uri.parse(
    "${BaseNetwork.baseUrl}/analytics_api/shelf_image/$shelfId",
  );

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      debugPrint("Image fetch failed: ${response.statusCode}");
    }
  } catch (e) {
    debugPrint("Error fetching image: $e");
  }

  return null;
}
