import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/user_management_module/user_management_page.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';

class UserManagementScreenFirst extends StatefulWidget {
  const UserManagementScreenFirst({Key? key}) : super(key: key);

  @override
  State<UserManagementScreenFirst> createState() =>
      _UserManagementScreenFirstState();
}

class _UserManagementScreenFirstState extends State<UserManagementScreenFirst> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  String? _selectedLocation;

  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];

  int _selectedIndex = 0;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeeNameController.dispose();
    _designationController.dispose();
    super.dispose();
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
      backgroundColor: UtilsFile.backgorundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopNavBarCommon( level: level,name: adminName,image: image,
              callback: (){},),
              SizedBox(height: 30),

              // Breadcrumb Navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
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
                    SizedBox(width: 10),
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
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                      ),

                      label: Text(
                        'User Management',
                        style: GoogleFonts.oxygen(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.pinkAccent, // pink-500
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                        'Setup and Manage Your User Accounts',
                        style: GoogleFonts.oxygen(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black, // pink-500
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Search and Filter Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Location Dropdown
                    Container(
                      width: 200,
                      height: 45,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 1,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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
                                color: Color(0xFFA1A1A1),
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
                                            color: Color(0xFF1A1A1A),
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

                    // Search by ID
                    Container(
                      width: 200,
                      height: 45,
                      child: TextFormField(
                        controller: _employeeIdController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFF48FB1),
                              width: 2,
                            ),
                          ),
                          hintText: "Search By ID",
                          hintStyle: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 13,
                          ),
                          suffixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),

                    SizedBox(width: 20),

                    // Search by Name
                    Container(
                      width: 200,
                      height: 45,
                      child: TextFormField(
                        controller: _employeeNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xFFF48FB1),
                              width: 2,
                            ),
                          ),
                          hintText: "Search By Name",
                          hintStyle: TextStyle(
                            color: Color(0xFFA1A1A1),
                            fontSize: 13,
                          ),
                          suffixIcon: Icon(Icons.person, color: Colors.grey),
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),

                    Spacer(),

                    // Create User Button
                    Container(
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            select = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              select == 1 ? Colors.white : Color(0xFFEC4899),
                          foregroundColor:
                              select == 1 ? Colors.black : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side:
                                select == 1
                                    ? BorderSide(color: Color(0xFFE5E7EB))
                                    : BorderSide.none,
                          ),
                          elevation: 0,
                        ),
                        icon: Icon(Icons.add, size: 18),
                        label: Text(
                          'Create User',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              if (select == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // List of Users Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 12,
                                  color: Color(0xFFEC4899),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'List of Users',
                                  style: GoogleFonts.oxygen(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFFEC4899),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Header Row
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8F9FA),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff1F263E),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Employee ID",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff1F263E),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Employee Name",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff1F263E),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                      ],
                                    ),
                                  ),
                                  // User Rows
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 4,
                                    separatorBuilder:
                                        (context, index) => Divider(
                                          height: 1,
                                          color: Color(0xFFE5E7EB),
                                        ),
                                    itemBuilder: (context, index) {
                                      final isSelected =
                                          index ==
                                          1; // Second row (Gautam) is selected
                                      return Container(
                                        color:
                                            isSelected
                                                ? Color(0xFFFCE4EC)
                                                : Colors.white,
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${index + 1}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff1F263E),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                [
                                                  "46016",
                                                  "46019",
                                                  "36017",
                                                  "34015",
                                                ][index],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff1F263E),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                [
                                                  "Sravan",
                                                  "Gautam",
                                                  "Krishna Kumar",
                                                  "Gautam",
                                                ][index],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff1F263E),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              child:
                                                  isSelected
                                                      ? Icon(
                                                        Icons.arrow_forward,
                                                        color: Color(
                                                          0xFFEC4899,
                                                        ),
                                                        size: 20,
                                                      )
                                                      : SizedBox(),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 30),

                      // User Details Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 12,
                                  color: Color(0xFFEC4899),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'User Details',
                                  style: GoogleFonts.oxygen(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFFEC4899),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  ...detailsData.map(
                                    (detail) => _buildDetailRow(detail),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFEC4899),
                                        size: 18,
                                      ),
                                      label: Text(
                                        'Delete User',
                                        style: TextStyle(
                                          color: Color(0xFFEC4899),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              if (select == 2)
                UserManagementScreen(
                  callBack: (value) {
                    setState(() {
                      select = 1;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(Map<String, dynamic> detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "${detail['label']}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B7280),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            ":",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff6B7280),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    detail['value'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1F263E),
                    ),
                  ),
                ),
                if (detail['hasAction'])
                  Row(
                    children: [
                      if (detail['label'] == 'Password')
                        Icon(Icons.refresh, size: 16, color: Color(0xFF10B981)),
                      if (detail['label'] != 'Password')
                        Icon(Icons.edit, size: 16, color: Color(0xFFF59E0B)),
                      if (detail['label'] == 'Password') ...[
                        SizedBox(width: 8),
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int select = 1;

  final List<Map<String, dynamic>> detailsData = [
    {'label': 'Employee', 'value': 'Gautam', 'hasAction': false},
    {'label': 'Employee ID', 'value': '46019', 'hasAction': false},
    {'label': 'Designation', 'value': 'Manager', 'hasAction': false},
    {'label': 'Phone No', 'value': '99x00xx123', 'hasAction': false},
    {'label': 'Access List', 'value': 'Standard Reagents', 'hasAction': true},
    {
      'label': 'Location Name',
      'value': 'Standard Reagents',
      'hasAction': false,
    },
    {'label': 'Access Level', 'value': 'Super Admin', 'hasAction': true},
    {'label': 'Login ID', 'value': '78', 'hasAction': false},
    {'label': 'Password', 'value': 'FR78', 'hasAction': true},
  ];

  final List<Employee> employees = [
    Employee(name: 'Employee', age: "Arvind"),
    Employee(name: 'Employee Id ', age: "28"),
    Employee(name: 'Designation', age: "Manager"),
    Employee(name: 'Access List', age: "Standard Reagents"),
    Employee(name: 'Location Name', age: "Standard Reagents"),
    Employee(name: 'Access Level', age: "Super Admin"),
    Employee(name: 'Login Id', age: "1212"),
    Employee(name: 'Password', age: "Frsad"),
  ];
}

class Employee {
  final String name;
  final String age;

  Employee({required this.name, required this.age});
}
