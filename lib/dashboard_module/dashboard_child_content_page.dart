import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pinklotus/dashboard_module/edit_user_profile.dart';
import 'package:pinklotus/dashboard_module/network_call/dashboard_api.dart';
import 'package:pinklotus/dashboard_module/network_call/dashboard_top_model.dart';
import 'package:pinklotus/dashboard_module/network_call/message_dashboard_model.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/urls.dart';
import 'package:pinklotus/utils/utils_file.dart';

class DashboardChildContentPage extends StatefulWidget {
  final Function(int) onCardTapped; // Callback for card tap

  const DashboardChildContentPage({super.key, required this.onCardTapped});

  @override
  State<DashboardChildContentPage> createState() =>
      _DashboardChildContentPageState();
}

class _DashboardChildContentPageState extends State<DashboardChildContentPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDashboard("STORE");
      getDashboardMessage();
      startAutoScroll();
      getUserData();
      getEmployeeLog();
    });
    super.initState();
  }

  DashboardTopModel? dashboardTopModel;
  List<MessageDahsboardModel> messaeArray = [];
  int? employeeTotalCount;
  List<String> selectedFilters = [];

  void getDashboard(String filterCategory) async {
    String? tokenGet = await LocalStorage.getToken();
    String? userIdGet = await LocalStorage.getUserId();
    print(
      "filterCategory: $filterCategory, token: $tokenGet, userId: $userIdGet",
    );
    final result = await fetchDashboardData(
      loginId: userIdGet ?? "",
      token: tokenGet ?? "",
      execBlock: "All",
      filterCategory: filterCategory, // "STORE",
    );

    if (result != null) {
      if (mounted) {
        setState(() {
          dashboardTopModel = DashboardTopModel.fromJson(result);
        });
      }
      print(
        "🟢 Store-wise Alerts: ${result["StoreWiseAlerts"]}=====${dashboardTopModel?.cAMERAS}",
      );
    } else {
      print("🔴 Failed to fetch dashboard data.");
    }
  }

  void getEmployeeLog() async {
    String? tokenGet = await LocalStorage.getToken();
    String? userIdGet = await LocalStorage.getUserId();
    final response = await http.post(
      Uri.parse(AppURLs.employeeLogs),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenGet ?? ""}',
      },
      body: jsonEncode({'loginId': userIdGet ?? ""}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (mounted) {
        setState(() {
          employeeTotalCount = data['total_count'] as int?;
        });
      }
      print("🟢 Employee total count: $employeeTotalCount");
    } else {
      print("🔴 Failed to fetch employee log data: ${response.statusCode}");
    }
  }

  void getDashboardMessage() async {
    final result = await fetchMessageBoardTimeline();

    if (result.isNotEmpty) {
      if (mounted) {
        setState(() {
          messaeArray.addAll(result);
        });
      }
      print("🟢 message-board: =====${dashboardTopModel?.cAMERAS}");
    } else {
      print("🔴 Failed to fetch dashboard data.");
    }
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

  int indexProfile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double baseWidth = 1920;
          double scaleFactor = (constraints.maxWidth / baseWidth) + 0.35;
          return Column(
            children: [
              TopNavBarCommon(
                level: level,
                name: adminName,
                image: image,
                callback: () {
                  print("callbackfunction----------");
                  if (mounted) {
                    setState(() {
                      indexProfile = 1;
                    });
                  }
                },
              ),
              if (indexProfile == 0)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20 * scaleFactor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.1,
                          child: Row(
                            children: [
                              buildTextButton(
                                'Welcome',
                                Colors.black,
                                scaleFactor,
                              ),
                              SizedBox(width: 8 * scaleFactor),
                              buildTextButton(
                                'Dashboard',
                                Color(0xFFEC4899),
                                scaleFactor,
                              ),
                              SizedBox(width: 8 * scaleFactor),
                              buildTextButton(
                                'Monitoring & Alert Dashboard',
                                Colors.grey,

                                scaleFactor,
                                isReversed: true,
                              ),
                            ],
                          ),
                        ),
                        if (dashboardTopModel != null)
                          SizedBox(
                            height: constraints.maxHeight * 0.185,
                            child: listVirew(dashboardTopModel!, scaleFactor),
                          ),
                        SizedBox(height: 12 * scaleFactor),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: buildCard(
                                  'Messages',
                                  scaleFactor,
                                  listVirewVWrtical(scaleFactor),
                                ),
                              ),
                              SizedBox(width: 20 * scaleFactor),
                              Expanded(
                                child: buildCardWithFilter(
                                  'Alerts',
                                  scaleFactor,
                                  listVirewVWrticalAlert(scaleFactor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (indexProfile == 1)
                Expanded(
                  child: UserProfileScreen(
                    level: level,
                    name: adminName,
                    image: image,
                    callBack: () {
                      if (mounted) {
                        setState(() {
                          indexProfile = 0;
                        });
                      }
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTextButton(
    String text,
    Color color,
    double scaleFactor, {
    bool isReversed = false,
  }) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      icon:
          isReversed
              ? Text(
                text,
                style: GoogleFonts.oxygen(
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * scaleFactor,
                  color: color,
                ),
              )
              : Image.asset(
                "assets/triangle_left.png",
                height: 10 * scaleFactor,
                width: 10 * scaleFactor,
                color: Colors.black,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
      label:
          isReversed
              ? Image.asset(
                "assets/triangle_left.png",
                height: 10 * scaleFactor,
                width: 10 * scaleFactor,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              )
              : Text(
                text,
                style: GoogleFonts.oxygen(
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * scaleFactor,
                  color: color,
                ),
              ),
    );
  }

  Widget buildCard(String title, double scaleFactor, Widget content) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16 * scaleFactor),
            child: TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              icon: Image.asset(
                "assets/triangle_left.png",
                height: 15 * scaleFactor,
                width: 15 * scaleFactor,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
              label: Text(
                title,
                style: GoogleFonts.oxygen(
                  fontWeight: FontWeight.w700,
                  fontSize: 15 * scaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget buildCardWithFilter(String title, double scaleFactor, Widget content) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16 * scaleFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: Image.asset(
                        "assets/triangle_left.png",
                        height: 15 * scaleFactor,
                        width: 15 * scaleFactor,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                      ),
                      label: Text(
                        title,
                        style: GoogleFonts.oxygen(
                          fontWeight: FontWeight.w700,
                          fontSize: 15 * scaleFactor,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 8 * scaleFactor),
                  ],
                ),
              ),
              Expanded(child: content),
            ],
          ),
          Positioned(
            top: 16 * scaleFactor,
            right: 16 * scaleFactor,
            child: FilterWidget(
              scaleFactor: scaleFactor,
              onFiltersChanged: (filters) {
                setState(() {
                  selectedFilters = filters;
                  Navigator.pop(context);
                  getDashboard(filters.first.toUpperCase());
                });
                print('Selected filters: $filters');
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> listOfImage = [
    'assets/footpath.png',
    "assets/Bitcoin.png",
    "assets/alert_dash.png",
    "assets/data.png",
  ];
  List<String> listOfgraph = [
    "assets/drawer/footfall.png",
    "assets/drawer/cameras_dashboard.png",
    "assets/drawer/alerts_dashboard.png",
    "assets/drawer/data_dashboard.png",
  ];
  List<String> listOfValues = ["58", "128", "26", "73"];
  List<String> listOfChanges = ['-7', '-26', '-6', '-25'];
  List<String> listOftitle = ["Footfall", "Cameras", "Alerts", "Data"];
  List<String> listOfdescriptin = [
    "Store Footfall",
    "Store Cameras",
    "Store Alerts",
    "Employees Data",
  ];

  Widget listVirew(DashboardTopModel dashboardTopModel, double scaleFactor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final separatorWidth = 20.0 * scaleFactor;
        final availableWidth = constraints.maxWidth;
        final cardWidth = (availableWidth - (4 - 1) * separatorWidth) / 4;

        return ListView.separated(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  widget.onCardTapped(3);
                } else if (index == 1) {
                  widget.onCardTapped(2);
                } else if (index == 2) {
                  widget.onCardTapped(1);
                } else {
                  widget.onCardTapped(3);
                }
              }, // Call callback to set index to 3
              child: Container(
                width: cardWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * scaleFactor,
                  vertical: 10 * scaleFactor,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * scaleFactor),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1 * scaleFactor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 2 * scaleFactor,
                      offset: Offset(0, 2 * scaleFactor),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              listOfImage[index],
                              height: 40 * scaleFactor,
                              width: 40 * scaleFactor,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 12 * scaleFactor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listOftitle[index],
                                  style: GoogleFonts.oxygen(
                                    fontSize: 24 * scaleFactor,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                    height: 1.1,
                                  ),
                                ),
                                SizedBox(height: 5 * scaleFactor),
                                Text(
                                  listOfdescriptin[index],
                                  style: GoogleFonts.oxygen(
                                    fontSize: 11 * scaleFactor,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF9CA3AF),
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              index == 0
                                  ? dashboardTopModel.sTORES.toString()
                                  : index == 1
                                  ? dashboardTopModel.cAMERAS.toString()
                                  : index == 2
                                  ? dashboardTopModel.aLERTS.toString()
                                  : employeeTotalCount?.toString() ?? "0",
                              style: GoogleFonts.oxygen(
                                fontSize: 34 * scaleFactor,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 6 * scaleFactor),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18 * scaleFactor),
                    Image.asset(
                      listOfgraph[index],
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      height: 45 * scaleFactor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: separatorWidth);
          },
        );
      },
    );
  }

  final ScrollController _controller = ScrollController();
  final Duration scrollDuration = Duration(milliseconds: 100);
  final double scrollStep = 1.0;
  Timer? _timer;

  void startAutoScroll() {
    _timer = Timer.periodic(scrollDuration, (timer) {
      if (_controller.hasClients) {
        final maxScroll = _controller.position.maxScrollExtent;
        final current = _controller.offset;

        if (current < maxScroll) {
          _controller.jumpTo(current + scrollStep);
        } else {
          _controller.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget listVirewVWrtical(double scaleFactor) {
    return Scrollbar(
      radius: Radius.circular(0),
      controller: _controller,
      thumbVisibility: false,
      child: ListView.separated(
        itemCount: messaeArray.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemBuilder: (context, index) {
          MessageDahsboardModel model = messaeArray[index];
          return AlertCard(model: model, scaleFactor: scaleFactor);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 0);
        },
      ),
    );
  }

  Widget listVirewVWrticalAlert(double scaleFactor) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5 * scaleFactor),
          padding: EdgeInsets.symmetric(
            horizontal: 10 * scaleFactor,
            vertical: 10 * scaleFactor,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFAFBFF),
            border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xFFDFE5F9)),
            ),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    "Location",
                    style: GoogleFonts.oxygen(
                      fontSize: 13 * scaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Date",
                    style: GoogleFonts.oxygen(
                      fontSize: 13 * scaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Resolved",
                    style: GoogleFonts.oxygen(
                      fontSize: 13 * scaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "UnResolved",
                    style: GoogleFonts.oxygen(
                      fontSize: 13 * scaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (dashboardTopModel != null &&
            dashboardTopModel!.storeWiseAlerts != null &&
            dashboardTopModel!.storeWiseAlerts!.isNotEmpty)
          Expanded(
            child: Scrollbar(
              radius: Radius.circular(0),
              thumbVisibility: false,
              child: ListView.separated(
                itemCount: dashboardTopModel!.storeWiseAlerts!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10 * scaleFactor,
                      vertical: 10 * scaleFactor,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12 * scaleFactor),
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            Text(
                              dashboardTopModel!.storeWiseAlerts![index].sTORE,
                              style: GoogleFonts.oxygen(
                                fontSize: 13 * scaleFactor,
                                color: Colors.black,
                                textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Text(
                              DateUtilsFile.formatDateTimeDash(
                                DateTime.now().toString(),
                              ).toString(),

                              style: GoogleFonts.oxygen(
                                fontSize: 13 * scaleFactor,
                                color: Colors.black,
                                textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            statusRow(
                              isGreen: true,
                              text:
                                  "${dashboardTopModel!.storeWiseAlerts![index].yes}",
                              scaleFactor: scaleFactor * 0.75,
                            ),
                            statusRow(
                              isGreen: false,
                              text:
                                  "${dashboardTopModel!.storeWiseAlerts![index].no}",
                              scaleFactor: scaleFactor * 0.75,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder:
                    (context, index) => Container(
                      height: 0.7 * scaleFactor,
                      color: Color(0xffCFD3DF),
                      margin: EdgeInsets.symmetric(vertical: 5 * scaleFactor),
                    ),
              ),
            ),
          ),
      ],
    );
  }

  Widget statusRow({
    required bool isGreen,
    required String text,
    required double scaleFactor,
  }) {
    return Container(
      height: 30 * scaleFactor,
      padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: 50 * scaleFactor),
      decoration: BoxDecoration(
        color: isGreen ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(16 * scaleFactor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10 * scaleFactor,
            height: 10 * scaleFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGreen ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 16 * scaleFactor),
          Text(
            text,
            style: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final MessageDahsboardModel model;
  final double scaleFactor;

  const AlertCard({super.key, required this.model, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    print("${model.timestamp.toString()}dateforamte=====");
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16 * scaleFactor,
        vertical: 6 * scaleFactor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5 * scaleFactor),
        borderRadius: BorderRadius.circular(12 * scaleFactor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16 * scaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateUtilsFile.formatLastDateTime(
                      model.timestamp.toString(),
                    ).toString(),
                    style: GoogleFonts.oxygen(
                      fontSize: 11 * scaleFactor,
                      color: Color(0xFF2A2B31),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8 * scaleFactor),
                  Text(
                    "${model.description} ${model.cameranum}",
                    style: TextStyle(
                      fontSize: 13 * scaleFactor,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF42434B),
                    ),
                  ),
                  SizedBox(height: 8 * scaleFactor),
                  Text(
                    "${model.description} at ${model.cameranum} in Store",
                    style: TextStyle(
                      fontSize: 12 * scaleFactor,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: DiagonalClipper(),
            child: Container(
              width: 110 * scaleFactor,
              height: 115 * scaleFactor,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(
                right: 12 * scaleFactor,
                bottom: 8 * scaleFactor,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12 * scaleFactor),
                  bottomRight: Radius.circular(12 * scaleFactor),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFFB388EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                "Security",
                style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RightTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class FilterWidget extends StatefulWidget {
  final double scaleFactor;
  final Function(List<String>) onFiltersChanged;

  const FilterWidget({
    Key? key,
    required this.scaleFactor,
    required this.onFiltersChanged,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isTooltipVisible = false;
  List<String> _selectedFilters = [];
  final _filterOptions = ['Store', 'Brand', 'Section', 'Region'];
  final _tooltipKey = GlobalKey();
  final _buttonKey = GlobalKey();

  void _toggleTooltip() {
    setState(() {
      _isTooltipVisible = !_isTooltipVisible;
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
    // Ensure callback is called after state update
    Future.microtask(() {
      try {
        widget.onFiltersChanged(List.from(_selectedFilters));
        debugPrint('Filters updated: $_selectedFilters');
      } catch (e) {
        debugPrint('Error in onFiltersChanged: $e');
      }
    });
  }

  void _handleOutsideTap(PointerEvent event) {
    final buttonRenderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final tooltipRenderBox =
        _tooltipKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonRenderBox == null || tooltipRenderBox == null) return;

    final buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
    final buttonSize = buttonRenderBox.size;
    final tooltipPosition = tooltipRenderBox.localToGlobal(Offset.zero);
    final tooltipSize = tooltipRenderBox.size;
    final tapPosition = event.position;

    final isButtonTap =
        tapPosition.dx >= buttonPosition.dx &&
        tapPosition.dx <= buttonPosition.dx + buttonSize.width &&
        tapPosition.dy >= buttonPosition.dy &&
        tapPosition.dy <= buttonPosition.dy + buttonSize.height;

    final isTooltipTap =
        tapPosition.dx >= tooltipPosition.dx &&
        tapPosition.dx <= tooltipPosition.dx + tooltipSize.width &&
        tapPosition.dy >= tooltipPosition.dy &&
        tapPosition.dy <= tooltipPosition.dy + tooltipSize.height;

    if (!isButtonTap && !isTooltipTap && _isTooltipVisible) {
      _toggleTooltip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: _handleOutsideTap, // Changed to onPointerUp for desktop
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main filter button
          GestureDetector(
            key: _buttonKey,
            behavior: HitTestBehavior.opaque,
            onTap: _toggleTooltip,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10 * widget.scaleFactor,
                vertical: 6 * widget.scaleFactor,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8 * widget.scaleFactor),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune,
                    size: 12 * widget.scaleFactor,
                    color: Colors.black,
                  ),
                  SizedBox(width: 6 * widget.scaleFactor),
                  Text(
                    'Filter',
                    style: GoogleFonts.oxygen(
                      fontSize: 14 * widget.scaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter options tooltip
          if (_isTooltipVisible)
            Positioned(
              top: 40 * widget.scaleFactor,
              right: 0,
              child: MouseRegion(
                opaque: false,
                child: Material(
                  type: MaterialType.transparency,
                  child: Material(
                    key: _tooltipKey,
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8 * widget.scaleFactor),
                    child: Container(
                      width: 200 * widget.scaleFactor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widget.scaleFactor,
                        vertical: 12 * widget.scaleFactor,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          8 * widget.scaleFactor,
                        ),
                        border: Border.all(
                          color: const Color(0xFFDFE5F9),
                          width: 1 * widget.scaleFactor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Filter Options',
                            style: GoogleFonts.oxygen(
                              fontSize: 14 * widget.scaleFactor,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8 * widget.scaleFactor),
                          ..._filterOptions.map(
                            (filter) => Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _toggleTooltip,
                                hoverColor: Colors.grey[100],
                                borderRadius: BorderRadius.circular(
                                  4 * widget.scaleFactor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8 * widget.scaleFactor,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 16 * widget.scaleFactor,
                                        height: 16 * widget.scaleFactor,
                                        decoration: BoxDecoration(
                                          color:
                                              _selectedFilters.contains(filter)
                                                  ? const Color(0xFF10B981)
                                                  : Colors.white,
                                          border: Border.all(
                                            color:
                                                _selectedFilters.contains(
                                                      filter,
                                                    )
                                                    ? const Color(0xFF10B981)
                                                    : const Color(0xFFDFE5F9),
                                            width: 1 * widget.scaleFactor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3 * widget.scaleFactor,
                                          ),
                                        ),
                                        child:
                                            _selectedFilters.contains(filter)
                                                ? Icon(
                                                  Icons.check,
                                                  size: 12 * widget.scaleFactor,
                                                  color: Colors.white,
                                                )
                                                : null,
                                      ),
                                      SizedBox(width: 8 * widget.scaleFactor),
                                      Text(
                                        filter,
                                        style: GoogleFonts.oxygen(
                                          fontSize: 13 * widget.scaleFactor,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
