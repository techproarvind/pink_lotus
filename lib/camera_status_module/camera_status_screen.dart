import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/camera_status_module/camera_insde_calls.dart';
import 'package:pinklotus/camera_status_module/camera_insde_calls_location.dart';
import 'package:pinklotus/camera_status_module/network_call/camera_main_model.dart' as camera;
import 'package:pinklotus/camera_status_module/network_call/camera_network_call.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';

class CameraStatusPage extends StatefulWidget {
  @override
  _CameraStatusPageState createState() => _CameraStatusPageState();
}

class _CameraStatusPageState extends State<CameraStatusPage> {
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
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBarCommon(level: level, name: adminName, image: image,
              callback: () {},
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        selecinde = 1;
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
                      'Cameras',
                      style: GoogleFonts.oxygen(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color:
                            selecinde == 1 ? Colors.pinkAccent : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (selecinde != 1)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          selecinde = 2;
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: Row(
                        children: [
                          Text(
                            selecinde == 2 ? 'Add Camera' : 'Add New Location',
                            style: GoogleFonts.oxygen(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color:
                                  selecinde == 2 || selecinde == 3
                                      ? Colors.pinkAccent
                                      : Colors.black, // pink-500
                            ),
                          ),
                        ],
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
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Filter and Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Filters Row
                      if (selecinde == 1)
                        Expanded(
                          child: Row(
                            children: [
                              _buildModernDropdown(
                                'Select Location',
                                _selectedLocation,
                                _locations,
                              ),
                              const SizedBox(width: 16),
                              _buildModernDropdown(
                                'Select Store',
                                _selectedLocation,
                                _locations,
                              ),
                              const SizedBox(width: 16),
                              _buildModernDropdown(
                                'Select Floor',
                                _selectedLocation,
                                _locations,
                              ),
                              const SizedBox(width: 16),
                              _buildModernDropdown(
                                'Select Section',
                                _selectedLocation,
                                _locations,
                              ),
                            ],
                          ),
                        ),
                      if (selecinde == 2 || selecinde == 3) const Spacer(),

                      // Action Buttons
                      Row(
                        children: [
                          if (selecinde == 1 || selecinde == 3)
                            _buildActionButton(
                              'Create Camera',
                              Icons.add,
                              false,
                              () {
                                setState(() {
                                  selecinde = 2;
                                });
                              },
                            ),
                          if (selecinde == 2)
                            _buildActionButton(
                              'Create Camera',
                              Icons.add,
                              true,
                              () {
                                setState(() {
                                  selecinde = 1;
                                });
                              },
                            ),
                          const SizedBox(width: 16),
                          if (selecinde == 1 || selecinde == 2)
                            _buildActionButton(
                              'Add Location',
                              Icons.add,
                              false,
                              () {
                                setState(() {
                                  selecinde = 3;
                                });
                              },
                            ),
                          if (selecinde == 3)
                            _buildActionButton(
                              'Add Location',
                              Icons.add,
                              true,
                              () {
                                setState(() {
                                  selecinde = 1;
                                });
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Content Area
                  if (selecinde == 1) CameraZoneTable(),
                  if (selecinde != 1)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selecinde = 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                selecinde == 2
                                    ? "Camera List"
                                    : "Add New Location",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (selecinde == 2) CameraFormPage(),
                          if (selecinde == 3) CameraFormPageLocation(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDropdown(String hint, String? value, List<String> items) {
    return Container(
      width: 180,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              hint,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          value: value,
          icon: const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF6B7280),
              size: 20,
            ),
          ),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          item,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF1F2937),
                          ),
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
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    bool isPrimary,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFEC4899) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isPrimary ? null : Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isPrimary ? Colors.white : const Color(0xFF6B7280),
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isPrimary ? Colors.white : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int selecinde = 1;
  String? _selectedLocation;

  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];

  Widget _statusDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class CameraZoneTable extends StatelessWidget {
  const CameraZoneTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<camera.Camera>>(
      future: fetchCameraList(loginId: "1010", token: "GVFRDERSSDS"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final cameras = snapshot.data!;
        final block1Cameras =
            cameras.where((cam) => cam.zONE == "Block-1 Ground Floor").toList();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header here...
              // Pass actual data:
              CameraZoneTile(
                zone: "Block-1 Ground Floor",
                cameras: block1Cameras,
              ),
              ...List.generate(6, (i) {
                return OtherZoneTile(
                  index: i + 2,
                  zone: 'Block-${i + 2} Floor',
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class CameraZoneTile extends StatefulWidget {
  final String zone;
  final List<camera.Camera> cameras;

  const CameraZoneTile({super.key, required this.zone, required this.cameras});

  @override
  State<CameraZoneTile> createState() => _CameraZoneTileState();
}

class _CameraZoneTileState extends State<CameraZoneTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main row
        GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                isExpanded = !isExpanded;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    "1",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Block-1 Ground Floor",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "03",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      StatusBox(label: "Online", count: 3, isOnline: true),
                      const SizedBox(width: 8),
                      Text(
                        "03",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      StatusBox(label: "Offline", count: 0, isOnline: false),
                      const SizedBox(width: 8),
                      Text(
                        "0",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFF6B7280),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expanded content
        if (isExpanded)
          Container(
            color: const Color(0xFFFEF7F0),
            child: Column(
              children: [
                // Sub-header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAF5F0),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Camera',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Location',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Section',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Zone',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Status',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      const SizedBox(width: 100, child: Text('Edit')),
                    ],
                  ),
                ),
                // Camera rows
                ...List.generate(widget.cameras.length, (i) {
                  final cam = widget.cameras[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          i < widget.cameras.length - 1
                              ? const Border(
                                bottom: BorderSide(
                                  color: Color(0xFFF3F4F6),
                                  width: 0.5,
                                ),
                              )
                              : null,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            "${i + 1}",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            cam.bRAND ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            cam.sTORE ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cam.sECTION,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cam.zONE ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: StatusBox(
                            label: cam.sTATUS == "1" ? "Online" : "Offline",
                            isOnline: cam.sTATUS == "1",
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}

class OtherZoneTile extends StatelessWidget {
  final String zone;
  final int index;

  const OtherZoneTile({super.key, required this.zone, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              "$index",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              zone,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              index == 2
                  ? "01"
                  : index == 3
                  ? "01"
                  : index == 4
                  ? "01"
                  : index == 5
                  ? "02"
                  : index == 6
                  ? "01"
                  : "02",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                StatusBox(label: "Online", isOnline: true),
                const SizedBox(width: 8),
                Text(
                  index == 2
                      ? "01"
                      : index == 3
                      ? "01"
                      : index == 4
                      ? "01"
                      : index == 5
                      ? "02"
                      : index == 6
                      ? "01"
                      : "02",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                StatusBox(label: "Offline", isOnline: false),
                const SizedBox(width: 8),
                Text(
                  "0",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF6B7280),
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBox extends StatelessWidget {
  final String label;
  final int? count;
  final bool isOnline;

  const StatusBox({
    super.key,
    required this.label,
    this.count,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOnline ? const Color(0xFFDCFCE7) : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color:
                  isOnline ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color:
                  isOnline ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 4),
            Text(
              "$count",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color:
                    isOnline
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFDC2626),
              ),
            ),
          ],
        ],
      ),
    );
  }
}



