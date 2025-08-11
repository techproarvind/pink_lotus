import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';

class AlertViewScreen extends StatefulWidget {
  const AlertViewScreen({super.key});

  @override
  State<AlertViewScreen> createState() => _AlertViewScreenState();
}

class _AlertViewScreenState extends State<AlertViewScreen> {
  String adminName = "", level = "", storeName = "", image = "";

  List<String> getStoralist = [];

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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

              SizedBox(height: 16),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    Row(
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
                            'Alert',
                            style: GoogleFonts.oxygen(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          icon: Row(
                            children: [
                              Image.asset(
                                "assets/triangle_left.png",
                                height: 10,
                                width: 10,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Customer Monitoring Scanarios',
                                style: GoogleFonts.oxygen(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.black, // pink-500
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                          ),

                          label: Text(
                            'Posible Theft (24)',
                            style: GoogleFonts.oxygen(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 440,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Left arrow
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                color: theme.primaryColor,
                                onPressed: _selectPrevious,
                              ),

                              // Horizontal ListView
                              SizedBox(
                                height: 30,
                                width: 350,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  itemBuilder: (context, index) {
                                    final isSelected = index == _selectedIndex;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() => _selectedIndex = index);
                                      },
                                      child: Container(
                                        width: 30,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),

                                          color:
                                              !isSelected
                                                  ? theme.primaryColor
                                                      .withOpacity(0.1)
                                                  : Colors.pinkAccent,
                                        ),
                                        child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.oxygen(
                                            color:
                                                !isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Right arrow
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: theme.primaryColor,
                                onPressed: _selectNext,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: GridView.builder(
                        itemCount: 30,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 2 columns = 4 tiles (2x2)
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 200 / 110, // width / total height
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => Dialog(
                                      insetPadding: EdgeInsets.all(40),
                                      backgroundColor: Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap:
                                                  () => Navigator.pop(context),
                                              child: InteractiveViewer(
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(
                                                        context,
                                                      ).width /
                                                      1.1,
                                                  height:
                                                      MediaQuery.sizeOf(
                                                        context,
                                                      ).height /
                                                      2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    color: Colors.transparent,
                                                  ),

                                                  child: Image.asset(
                                                    height:
                                                        MediaQuery.sizeOf(
                                                          context,
                                                        ).height /
                                                        2,
                                                    width:
                                                        MediaQuery.sizeOf(
                                                          context,
                                                        ).width /
                                                        1.1,
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
                                              padding: const EdgeInsets.all(
                                                30.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 50),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(""),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                        onPressed:
                                                            () => Navigator.pop(
                                                              context,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 200),

                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "ID",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      Text(
                                                        "120129120",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Status",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      Text(
                                                        "UnResolved",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Time",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      Text(
                                                        "2025-04-04 05:16:18",
                                                        style:
                                                            GoogleFonts.oxygen(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          top: 40,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              // Save action
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        40,
                                                                    vertical:
                                                                        14,
                                                                  ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      9999,
                                                                    ),
                                                              ),
                                                              elevation: 0,
                                                              textStyle:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                              // Gradient background
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor:
                                                                  Colors
                                                                      .transparent,
                                                            ),
                                                            child: Ink(
                                                              decoration: const BoxDecoration(
                                                                gradient: LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                      0xFFE83E7D,
                                                                    ),
                                                                    Color(
                                                                      0xFFF48FB1,
                                                                    ),
                                                                  ],
                                                                  begin:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  end:
                                                                      Alignment
                                                                          .centerRight,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                      Radius.circular(
                                                                        9999,
                                                                      ),
                                                                    ),
                                                              ),
                                                              child: Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                      minWidth:
                                                                          100,
                                                                    ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Resolved',
                                                                  style: GoogleFonts.oxygen(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            // Clear action
                                                          },
                                                          style: OutlinedButton.styleFrom(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      40,
                                                                  vertical: 14,
                                                                ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    9999,
                                                                  ),
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                                  color: Color(
                                                                    0xFF4B5563,
                                                                  ),
                                                                ), // gray-600
                                                            textStyle:
                                                                const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                    0xFF4B5563,
                                                                  ),
                                                                ),
                                                          ),
                                                          child: Text(
                                                            'Error In Scenario',
                                                            style:
                                                                GoogleFonts.oxygen(
                                                                  color: Color(
                                                                    0xFF4B5563,
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
                                          ),
                                        ],
                                      ),
                                    ),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // Fully rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              clipBehavior:
                                  Clip.antiAlias, // To clip child corners
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
                                      'assets/image.png', // Replace with your image
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),

                                  // Row with 3 texts at the bottom
                                  Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.all(12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "10923",
                                          style: GoogleFonts.oxygen(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "12 Mar",
                                          style: GoogleFonts.oxygen(
                                            fontSize: 14,
                                          ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
