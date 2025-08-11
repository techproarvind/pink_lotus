import 'package:flutter/material.dart';
import 'package:pinklotus/alert_module/alert_first_child.dart';
import 'package:pinklotus/analytic_section_module/analytic_section.dart';
import 'package:pinklotus/app_bar_module/app_bar_app_drawer.dart';
import 'package:pinklotus/camera_status_module/camera_status_screen.dart';
import 'package:pinklotus/dashboard_module/dashboard_child_content_page.dart';
import 'package:pinklotus/support_denter/suppoert_center.dart';
import 'package:pinklotus/user_management_module/user_management_page_first.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  // Callback to update selectedIndex
  void _updateSelectedIndex(int index) {
    if (mounted) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("desktop---$screenWidth");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildResponsiveLayout(context),
            // Add other dashboard components here
          ],
        ),
      ),
    );
  }

  Widget buildResponsiveLayout(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        // Sidebar / Drawer
        SizedBox(
          width: 260,
          height: screenHeight,
          child: AppDrawer(
            selectedIndex: selectedIndex, // Pass current selectedIndex
            onItemSlected: _updateSelectedIndex, // Pass callback
          ),
        ),

        // Main Content Area
        Expanded(
          child: SizedBox(
            height: screenHeight,
            child: getSelectedScreen(selectedIndex),
          ),
        ),
      ],
    );
  }

  Widget getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return DashboardChildContentPage(
          onCardTapped: (index) => _updateSelectedIndex(index), // Pass callback
        );
      case 1:
        return AlertFirstChild();
      case 2:
        return CameraStatusPage(
          
        );
      case 3:
        return AnalyticsSection();
      case 4:
        return UserManagementScreenFirst();
      case 5:
        return SupportCenterPage();
      default:
        return Center(child: Text("Page not found"));
    }
  }
}
