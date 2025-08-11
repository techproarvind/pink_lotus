import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';

class AlertFirstChild extends StatefulWidget {
  const AlertFirstChild({super.key});

  @override
  State<AlertFirstChild> createState() => _AlertFirstChildState();
}

class _AlertFirstChildState extends State<AlertFirstChild> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _pickDate({required bool isFrom}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isFrom ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
    super.initState();
  }

  String adminName = "", level = "", storeName = "", image = "";

  List<dynamic> getStoralist = [];

  void getUserData() async {
    Map<String, dynamic>? loadedUser = await LocalStorage.getUserData();
    if (mounted) {
      setState(() {
        adminName = loadedUser?['emp_name'];
        level = loadedUser?['user_designation'];
        getStoralist = loadedUser?['STORES'];
        image = loadedUser?['image_url'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor, // Light blue background
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              TopNavBarCommon(
                level: level,
                name: adminName,
                image: image,
                callback: () {},
              ),

              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Image.asset(
                      "assets/triangle_left.png",
                      height: 10,
                      width: 10,
                      color: Colors.black,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                    ),

                    label: Text(
                      'Welcome',
                      style: GoogleFonts.oxygen(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black, // pink-500
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        indexselectio = 2;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Image.asset(
                      "assets/triangle_left.png",
                      height: 10,
                      width: 10,
                      color: Colors.black,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                    ),

                    label: Text(
                      'Alert',
                      style: GoogleFonts.oxygen(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color:
                            indexselectio == 2
                                ? Color(0xFFEC4899)
                                : Colors.black, // pink-500
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        indexselectio = 3;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Text(
                      'Customer Monitoring',
                      style: GoogleFonts.oxygen(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color:
                            indexselectio == 2
                                ? Colors.black
                                : Color(0xFFEC4899), // pink-500
                      ),
                    ),
                    label: Image.asset(
                      "assets/triangle_left.png",
                      height: 10,
                      width: 10,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              if (indexselectio == 2) SizedBox(height: 20),
              if (indexselectio == 2)
                Row(
                  children: [
                    SizedBox(width: 20),
                    SizedBox(
                      width: 230,
                      height: 45,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 1,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFF48FB1),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Location',
                              style: GoogleFonts.oxygen(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            value: _selectedLocation,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            items:
                                _locations
                                    .map(
                                      (loc) => DropdownMenuItem<String>(
                                        value: loc,
                                        child: Text(
                                          loc,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLocation = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 230,
                      height: 45,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFF48FB1),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Store',
                              style: GoogleFonts.oxygen(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,

                                color: Colors.black,
                              ),
                            ),
                            value: _selectedLocation,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            items:
                                _locations
                                    .map(
                                      (loc) => DropdownMenuItem<String>(
                                        value: loc,
                                        child: Text(
                                          loc,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLocation = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 220,
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'From:',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => _pickDate(isFrom: true),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 14),
                                  SizedBox(width: 10),
                                  Text(
                                    fromDate != null
                                        ? "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}"
                                        : "DD/MM/YYYY",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 200,
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => _pickDate(isFrom: false),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,

                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 18),
                                  SizedBox(width: 10),
                                  Text(
                                    toDate != null
                                        ? "${toDate!.day}/${toDate!.month}/${toDate!.year}"
                                        : "DD/MM/YYYY",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (indexselectio == 2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 20,
                    verticalDirection: VerticalDirection.down,
                    spacing: 10,
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexselectio = 3;
                          });
                        },
                        child: Container(
                          width: 400,
                          height: 150,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Icon container
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/Customer-Monitoring.png',
                                    height: 28,
                                    width: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Content section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Title
                                    Text(
                                      "Customer Monitoring",
                                      style: GoogleFonts.oxygen(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    // Stats row
                                    Row(
                                      children: [
                                        // Resolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Resolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "126",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/arro_up_green.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        // Unresolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Unresolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "24",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/ArrowFall.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Percentage section
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ), // Push percentage down
                                            Row(
                                              children: [
                                                Text(
                                                  "78%",
                                                  style: GoogleFonts.oxygen(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.red,
                                                  size: 15,
                                                  weight: 0.5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexselectio = 3;
                          });
                        },
                        child: Container(
                          width: 400,
                          height: 150,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300, // Light grey border
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200, // 10% black shadow
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue, // Fill color of container
                                  shape:
                                      BoxShape.circle, // Makes it fully rounded
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/Customer-Monitoring 1.png', // Replace with your image
                                    height: 28,
                                    width: 28,
                                    color:
                                        Colors.white, // Makes the image white
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Employee Monitoring",
                                      style: GoogleFonts.oxygen(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        // Resolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Resolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "126",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/arro_up_green.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        // Unresolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Unresolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "32",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/ArrowFall.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Percentage section
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ), // Push percentage down
                                            Row(
                                              children: [
                                                Text(
                                                  "78%",
                                                  style: GoogleFonts.oxygen(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.red,
                                                  size: 15,
                                                  weight: 0.5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexselectio = 3;
                          });
                        },
                        child: Container(
                          width: 400,
                          height: 150,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300, // Light grey border
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200, // 10% black shadow
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color:
                                      Colors
                                          .greenAccent, // Fill color of container
                                  shape:
                                      BoxShape.circle, // Makes it fully rounded
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/Customer-Monitoring_camera.png', // Replace with your image
                                    height: 28,
                                    width: 28,
                                    color:
                                        Colors.white, // Makes the image white
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Others",
                                      style: GoogleFonts.oxygen(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        // Resolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Resolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "126",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/arro_up_green.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        // Unresolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Unresolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "32",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/ArrowFall.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Percentage section
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ), // Push percentage down
                                            Row(
                                              children: [
                                                Text(
                                                  "78%",
                                                  style: GoogleFonts.oxygen(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.red,
                                                  size: 15,
                                                  weight: 0.5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexselectio = 3;
                          });
                        },
                        child: Container(
                          width: 400,
                          height: 150,
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 10,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300, // Light grey border
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200, // 10% black shadow
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue, // Fill color of container
                                  shape:
                                      BoxShape.circle, // Makes it fully rounded
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/Customer-Monitoring_setting.png', // Replace with your image
                                    height: 28,
                                    width: 28,
                                    color:
                                        Colors.white, // Makes the image white
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Maintenance",
                                      style: GoogleFonts.oxygen(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        // Resolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Resolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "126",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/arro_up_green.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        // Unresolved section
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Unresolved",
                                                style: GoogleFonts.oxygen(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "24",
                                                    style: GoogleFonts.oxygen(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    'assets/ArrowFall.png',
                                                    height: 12,
                                                    width: 12,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Percentage section
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ), // Push percentage down
                                            Row(
                                              children: [
                                                Text(
                                                  "78%",
                                                  style: GoogleFonts.oxygen(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.red,
                                                  size: 15,
                                                  weight: 0.5,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (indexselectio == 3) alertViewSecondView(context),
            ],
          ),
        ),
      ),
    );
  }

  int indexselectio = 2;

  Widget alertViewSecondView(context) {
    Theme.of(context);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: GridView.builder(
          itemCount: 30,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 2 columns = 4 tiles (2x2)
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 340 / 194, // width / total height
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (_) => _DialogContent(),
                );
              },
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Image with top rounded corners
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset(
                        height: 170,
                        width: MediaQuery.sizeOf(context).width,
                        'assets/image.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    // Row with 3 texts at the bottom
                    SizedBox(height: 5),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "10923",
                            style: GoogleFonts.oxygen(fontSize: 14),
                          ),
                          Text(
                            "12 Mar",
                            style: GoogleFonts.oxygen(fontSize: 14),
                          ),
                          const Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _selectedLocation;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  void _scrollToIndex(int index) {
    const itemWidth = 60.0;
    _scrollController.animateTo(
      index * itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _selectPrevious() {
    if (_selectedIndex > 0) {
      setState(() => _selectedIndex--);
      _scrollToIndex(_selectedIndex);
    }
  }

  void _selectNext() {
    if (_selectedIndex < 6) {
      setState(() => _selectedIndex++);
      _scrollToIndex(_selectedIndex);
    }
  }

  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];
}

class _DialogContent extends StatefulWidget {
  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<_DialogContent> {
  bool isResolvedSelected = false;
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(40),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.5,
        width: MediaQuery.sizeOf(context).width / 1.5,
        child: Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: InteractiveViewer(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 1.1,
                    height: MediaQuery.sizeOf(context).height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      height: MediaQuery.sizeOf(context).height / 2,
                      width: MediaQuery.sizeOf(context).width / 1.1,
                      'assets/image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Close button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    // Information rows
                    _buildInfoRow("ID", "1056705"),
                    SizedBox(height: 16),
                    _buildInfoRow("Camera", "Billing Counter 5"),
                    SizedBox(height: 16),
                    _buildInfoRow("Store", "GMRHDF"),
                    SizedBox(height: 16),
                    _buildInfoRow("Time", "2025-04-04 05:16:18"),
                    SizedBox(height: 16),
                    _buildInfoRow("Status", "UnResolved"),
                    SizedBox(height: 16),
                    _buildInfoRow("Reason", "Possible Theft"),

                    const SizedBox(height: 25),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                isResolvedSelected = true;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  isResolvedSelected
                                      ? Colors.pink
                                      : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              side: BorderSide(
                                color:
                                    isResolvedSelected
                                        ? Colors.pink
                                        : Color(0xFF6B7280),
                              ),
                            ),
                            child: Text(
                              'Resolved',
                              style: GoogleFonts.oxygen(
                                color:
                                    isResolvedSelected
                                        ? Colors.white
                                        : Color(0xFF374151),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Error In Scenario action
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              side: const BorderSide(color: Color(0xFF6B7280)),
                            ),
                            child: Text(
                              'Error In Scenario',
                              style: GoogleFonts.oxygen(
                                color: Color(0xFF374151),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Show text field when Resolved is selected
                    if (isResolvedSelected) ...[
                      SizedBox(height: 16),
                      TextField(
                        controller: reasonController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFC1C5D3),
                          hintText: 'Enter',
                          hintStyle: GoogleFonts.oxygen(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        style: GoogleFonts.oxygen(fontSize: 14),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton(
                          onPressed: () {
                            // Submit action
                            print("Submitted: ${reasonController.text}");
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            side: const BorderSide(color: Color(0xFF6B7280)),
                          ),
                          child: Text(
                            'SUBMIT',
                            style: GoogleFonts.oxygen(
                              color: Color(0xFF374151),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "$label :",
            style: GoogleFonts.oxygen(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.oxygen(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
