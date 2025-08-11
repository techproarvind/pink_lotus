import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinklotus/auth_module/login_screen.dart';
import 'package:pinklotus/model_module/auth_module/login_response.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/support_denter/suppoert_center.dart';
import 'package:pinklotus/utils/utils_file.dart';

class AppDrawer extends StatefulWidget {
  final int selectedIndex; // Current selected index from DashboardScreen
  final Function(int) onItemSlected;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSlected,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLoading = false;
  File? selectedImage;
  String? imageUrl;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMasterStoreList();
    });
    super.initState();
  }

  String masterStoreList = '';

  void getMasterStoreList() async {
    Map<String, dynamic>? loadedUser = await LocalStorage.getUserData();
    if (mounted) {
      String rawStoreList = loadedUser?['master_storelist'] ?? '';

      List<String> stores = rawStoreList
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("'", "")
          .split(',');

      String firstStore = stores.isNotEmpty ? stores.first.trim() : '';

      setState(() {
        masterStoreList = firstStore;
      });
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1F263E),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    "assets/drawer/header_logo.png",
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                ),
                ListTile(
                  title: Text(
                    masterStoreList,
                    style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildMenuItem(
                  index: 0,
                  icon: "assets/drawer/dashbaord.png",
                  title: 'Dashboard',
                ),
                _buildMenuItem(
                  index: 1,
                  icon: "assets/drawer/alert.png",
                  title: 'Alerts',
                ),
                _buildMenuItem(
                  index: 2,
                  icon: "assets/drawer/cameras.png",
                  title: 'Cameras',
                ),
                _buildMenuItem(
                  index: 3,
                  icon: "assets/drawer/analytics.png",
                  title: 'Analytics',
                ),
                _buildMenuItem(
                  index: 4,
                  icon: "assets/drawer/user_management.png",
                  title: 'User Management',
                ),
                _buildMenuItem(
                  index: 5,
                  icon: "assets/drawer/support_center.png",
                  title: 'Support Center',
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Account',
                    style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildMenuItem(
                  index: 6,
                  icon: "assets/drawer/notification_icon.png",
                  title: 'Notifications',
                ),
                _buildMenuItem(
                  index: 7,
                  icon: "assets/drawer/setting.png",
                  title: 'Settings',
                ),
                _buildMenuItem(
                  index: 8,
                  icon: "assets/drawer/faq.png",
                  title: 'FAQ',
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 1,
                color: Colors.white.withOpacity(0.2),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
              _buildMenuItem(
                index: 9,
                icon: "assets/drawer/logout.png",
                title: 'Log Out',
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: SupportCenterPage.pink600,
                ),
                onTap: () async {
                  await LocalStorage.clearLocalStorage();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required int index,
    required String icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      color:
          widget.selectedIndex == index
              ? Colors.white.withValues(alpha: 0.05)
              : null,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color:
                  widget.selectedIndex == index
                      ? Colors.pinkAccent
                      : Colors.transparent,
            ),
          ),
          Expanded(
            child: ListTile(
              selectedTileColor: Colors.white,
              selected: widget.selectedIndex == index,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor:
                  widget.selectedIndex == index
                      ? Colors.white
                      : Colors.transparent,
              leading: Image.asset(
                icon,
                color:
                    widget.selectedIndex == index
                        ? Colors.pinkAccent
                        : Colors.white,
                height: 20,
                width: 20,
              ),
              title: Text(
                title,
                style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontWeight:
                      widget.selectedIndex == index
                          ? FontWeight.w700
                          : FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              trailing:
                  trailing ??
                  (widget.selectedIndex == index
                      ? Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.pinkAccent,
                        size: 15,
                      )
                      : null),
              onTap:
                  onTap ??
                  () {
                    widget.onItemSlected(index);
                  },
            ),
          ),
        ],
      ),
    );
  }
}
