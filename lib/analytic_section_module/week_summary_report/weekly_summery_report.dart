import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinklotus/utils/urls.dart';

class WeeklyReportScreen extends StatefulWidget {
  const WeeklyReportScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyReportScreen> createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends State<WeeklyReportScreen> {
  String selectedStore = '';
  List<TextEditingController> commentControllers = [];
  List<CategoryData> reportData = [];
  String startDate = '';
  String endDate = '';
  bool isLoading = true;

  final Map<String, List<String>> categoryDescriptions = {
    "EMPLOYEES MONITORING": [
      "EMPLOYEE SLEEPING",
      "EMPLOYEES IN GROUP",
      "NO ONE IN COUNTER",
      "PROLONGED MOBILE USAGE",
      "EMPLOYEE WITHOUT UNIFORM",
      "EMPLOYEE GROOMING ISSUE - BEARD",
      "MANPOWER AGAINST CATEGORY",
      "EMPLOYEE NOT SEEN MORE THAN 1 HOUR",
      "SUSPICIOUS ACTIVITY",
      "POSSIBLE THEFT",
      "EMPLOYEE GROOMING ISSUE - INSHIRT",
    ],
    "CUSTOMER MONITORING": [
      "UNATTENDED CUSTOMER",
      "POSSIBLE THEFT",
      "SUSPICIOUS ACTIVITY",
      "HIGH FOOTFALL",
      "HIGH BILLING WAIT TIME",
    ],
    "STORE MAINTENANCE": [
      "OBJECT FALL",
      "DAMAGE",
      "TROLLEY IN SALE AREA",
      "TRASH ON FLOOR",
      "SHELF HAS EMPTY SLOT",
      "PRODUCTS KEPT ASIDE",
    ],
    "OTHERS": [
      "VIOLENCE DETECTED",
      "CUSTOMERS ENTERING THROUGH 2ND ENTRANCE",
      "OBJECTS BLOCKING PATHWAY",
    ],
  };

  @override
  void initState() {
    super.initState();
    fetchWeeklyReport();
  }

  Future<void> fetchWeeklyReport() async {
    setState(() => isLoading = true);
    final url = Uri.parse("${AppURLs.baseURL}/api/weekly_response");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          selectedStore = data["store_code"];
          startDate = data["start_date"];
          endDate = data["end_date"];
          reportData =
              (data["category_data"] as List)
                  .map((e) => CategoryData.fromJson(e))
                  .toList();
          commentControllers = List.generate(
            reportData.length,
            (index) =>
                TextEditingController(text: reportData[index].comment ?? ""),
          );
        });
      } else {
        throw Exception("Failed to load weekly report");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  String getStatus(int prev, int curr) {
    if (prev == curr) return "IDEAL";
    if (curr < prev) return "IMPROVED";
    return "NOT IMPROVED";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "IDEAL":
        return Colors.grey[400]!;
      case "IMPROVED":
        return Colors.green[300]!;
      case "NOT IMPROVED":
        return Colors.red[300]!;
      default:
        return Colors.grey;
    }
  }

  Future<void> submitComment(int cid, String comment) async {
    final url = Uri.parse("${AppURLs.baseURL}/api/update_comments");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"cid": cid, "comments": comment}),
      );
      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update comment"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Store Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.store, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedStore,
                            items:
                                [selectedStore]
                                    .map(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                    )
                                    .toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Report Title
                  Text(
                    'Weekly Summary Report • ($startDate - To $endDate)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Table Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildHeaderCell('No', 40),
                          _buildHeaderCell('Category', 140),
                          _buildHeaderCell('Description', 280),
                          _buildHeaderCell('Previous Week', 120),
                          _buildHeaderCell('Current Week', 120),
                          _buildHeaderCell('Status', 120),
                          _buildHeaderCell('Comments', 220),
                          _buildHeaderCell('Action', 100),
                        ],
                      ),
                    ),

                    // Table Body
                    Expanded(
                      child: ListView.builder(
                        itemCount: reportData.length,
                        itemBuilder: (context, index) {
                          return _buildDataRow(reportData[index], index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildDataRow(CategoryData data, int index) {
    String status = getStatus(data.previousWeek, data.currentWeek);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 40, child: Text("${index + 1}")),
          SizedBox(width: 140, child: Text(data.category)),
          SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  categoryDescriptions[data.category]!
                      .map(
                        (desc) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            desc,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          SizedBox(
            width: 120,
            child: Center(child: Text("${data.previousWeek}")),
          ),
          SizedBox(
            width: 120,
            child: Center(child: Text("${data.currentWeek}")),
          ),
          SizedBox(
            width: 140,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextField(
              controller: commentControllers[index],
              minLines: 4,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {
                submitComment(data.cid, commentControllers[index].text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryData {
  final String category;
  final int cid;
  final int currentWeek;
  final int previousWeek;
  final String? comment;

  CategoryData({
    required this.category,
    required this.cid,
    required this.currentWeek,
    required this.previousWeek,
    this.comment,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      category: json["CATEGORY"],
      cid: json["CID"],
      currentWeek: json["CURRWEEK"],
      previousWeek: json["PREVWEEK"],
      comment: json["L1_COMMENTS"],
    );
  }
}
