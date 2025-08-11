import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/analytic_section_module/age_group_module/age_group_model.dart';
import 'package:pinklotus/analytic_section_module/age_group_module/age_group_ui.dart';
import 'package:pinklotus/analytic_section_module/age_range/age_range_model.dart';
import 'package:pinklotus/analytic_section_module/age_range/age_range_ui.dart';
import 'package:pinklotus/analytic_section_module/age_range/widget_top.dart';
import 'package:pinklotus/analytic_section_module/alert_review/alert_camera_model.dart';
import 'package:pinklotus/analytic_section_module/alert_review/alert_review_model.dart';
import 'package:pinklotus/analytic_section_module/alert_review/network_call_alert_review.dart';
import 'package:pinklotus/analytic_section_module/employee_tracking/api_employee_tracking.dart';
import 'package:pinklotus/analytic_section_module/employee_tracking/employee_tracking_model.dart';
import 'package:pinklotus/analytic_section_module/employee_tracking/employee_tracking_ui.dart';
import 'package:pinklotus/analytic_section_module/foot_fall.dart';
import 'package:pinklotus/analytic_section_module/gender_data.dart';
import 'package:pinklotus/analytic_section_module/insight_week.dart';
import 'package:pinklotus/analytic_section_module/insitestdata.dart';
import 'package:pinklotus/analytic_section_module/networj_call_gender.dart';
import 'package:pinklotus/analytic_section_module/self_data/self_data_model.dart';
import 'package:pinklotus/analytic_section_module/self_data/self_data_ui.dart';
import 'package:pinklotus/analytic_section_module/time_spent_model.dart';
import 'package:pinklotus/analytic_section_module/time_stamp_page.dart';
import 'package:pinklotus/analytics_module_main_page/analytics_main_page.dart';
import 'package:http/http.dart' as http;
import 'package:pinklotus/network_call/base_network.dart';
import 'package:pinklotus/network_call/local_storage.dart' as local;
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';
import 'package:url_launcher/url_launcher.dart';

class AnalyticsSection extends StatefulWidget {
  const AnalyticsSection({super.key});
  @override
  _AnalyticsSectionState createState() => _AnalyticsSectionState();
}

class _AnalyticsSectionState extends State<AnalyticsSection>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _subTabController;
  List<dynamic> labels = [];
  List<int> values = [];
  bool isLoadingMainGraph = true;

  bool averageShow = true;
  bool maleShow = true;
  bool ageGroupAdultShow = true;
  bool ageGroupChildShow = true;

  bool mainGraphShow = true;
  bool femaleShow = true;

  String errorMessage = '', downloadUrl = "", insightValue = "";
  double averageValue = 0;

  EmployeeTrackingModel? futureDataEmployeeTracking;
  SelfDataModel? futureDataSelfData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
      fetchAlertReviewData();
      fetchFootFallData();
      loadGenderData();
      loadAgeGroupData();
      loadAgeGroupRangeData();
      loadTimeSpentData();
    });
    _mainTabController = TabController(length: 3, vsync: this);
    _subTabController = TabController(length: 7, vsync: this);
  }

  String adminName = "", level = "", storeName = "", image = "", loginId = "";

  List<dynamic> getStoralist = [];

  void getUserData() async {
    Map<String, dynamic>? loadedUser = await local.LocalStorage.getUserData();
    String? loginId = await local.LocalStorage.getUserId();
    if (mounted) {
      setState(() {
        adminName = loadedUser?['emp_name'];
        loginId = loginId;
        level = loadedUser?['user_designation'];
        getStoralist = loadedUser?['STORES'];
        image = loadedUser?['image_url'];
      });
    }
  }

  Future<void> _openUrl(downloadUrl) async {
    if (!await launchUrl(Uri.parse(downloadUrl))) {
      throw Exception('Could not launch $downloadUrl');
    }
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _subTabController.dispose();
    _removeDropdown();
    _removeDropdown2();
    _removeDropdown3();
    _removeDropdown4();
    super.dispose();
  }

  List<String> _selectedItems = [];
  List<String> _selectedItemsPass = [];
  List<String> _selectedStore = ["GMRHDF"];
  List<String> _selectedHours = [];
  List<String> _selectedDays = [];
  List<int> _selectedDaysPass = [];
  List<int> _selectedHoursPass = [];
  AlertReviewModel? alertResponse;
  String insigethGenderData = '';
  GenderInsightsModel? insightData;
  TimeSpentModel? insightDataTimeSpent;
  InsightAgeGroupModel? insightDataAgeGroupRange;
  InsightAgeGroupModel? insightDataAgeGroupRangeFilter;
  AgeGroupFilterModel? filterAgeGroup;
  AgeGroupModelData? ageGroup;

  GenderInsightsModelFilter? insightDataFilter;
  bool isFilter = false;
  var data = {};

  Future<void> fetchFootFallData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }
    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse(
          '${BaseNetwork.baseUrl}/analytics_api/footfall_filter_timeline?filterType=$_selectedFilterCValuePasss',
        ),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            data = json.decode(response.body);
            labels = List<dynamic>.from(data['labels']);
            values = List<int>.from(data['values']);
            downloadUrl = "";
            downloadUrl = data["url"];
            averageValue = calculateAverage(values);
            isLoadingMainGraph = false;
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingMainGraph = false;
          errorMessage = 'Error loading data: ${e.toString()}';
        });
      }
    }
  }

  Future<void> fetchAlertReviewData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }
    alertResponse = await AlertService().fetchAlertsReview();
    if (alertResponse != null) {
      if (mounted) {
        setState(() {
          isLoadingMainGraph = false;
        });
      }
      print("response: $alertResponse");
    }
  }

  Future fetchGenderInsights(
    GenderInsightsModel? insightData,
    GenderInsightsModelFilter? insightDataFilter,
  ) async {
    String url = '${BaseNetwork.baseUrl}/api/gender-insights';

    final requestBody = {
      "df": {
        "HOUR": insightData!.labels,
        "MALE_COUNT_IN_HOUR": insightData.maleData,
        "FEMALE_COUNT_IN_HOUR": insightData.femaleData,
      },
      "time_period": _selectedFilterCValuePasss,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse: $jsonResponse");

        final insights = jsonResponse['insights'] as String?;

        if (mounted) {
          setState(() {
            insigethGenderData = insights ?? "";
          });
        }

        print("insigethGenderData: $insigethGenderData");
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  void loadGenderData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    final data = await GenderInsightService.fetchInsightData(
      _selectedFilterCValuePasss,
    );
    if (mounted) {
      setState(() {
        print("data: $data");
        print("insightData: $insightData");
        if (data != null) {
          insightData = data;
          downloadUrl = "";
          downloadUrl = insightData!.url;
          fetchGenderInsights(insightData, insightDataFilter);
        }
        isLoadingMainGraph = false;
        isFilter = false;
      });
    }
  }

  void loadSelfDataApi() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    print("fromDate: $fromDate");
    print("toDate: $toDate");
    print("days: $_selectedDays");
    print("hours: $_selectedHours");
    print("selection: $_selectedItemsPass");
    print("stores: $_selectedStore");
    final data = await GenderInsightService.fetchSelfDataApiCalling(
      fromDate: fromDate ?? DateTime.now(),
      toDate: toDate ?? DateTime.now(),
      days: _selectedDays,
      hours: _selectedHours,
      selection: _selectedItemsPass,
      stores: _selectedStore,
    );
    print("data: $data");
    if (mounted) {
      setState(() {
        print("data: $data");
        print("insightData: $insightData");
        if (data != null) {
          futureDataSelfData = data;
          downloadUrl = "";
          downloadUrl = insightData!.url;
        }
        isLoadingMainGraph = false;
        isFilter = true;
      });
    }
  }

  void loadAgeGroupRangeData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    final data = await GenderInsightService.fetchInsightDataAgeGroupRange(
      _selectedFilterCValuePasss,
    );
    if (mounted) {
      setState(() {
        if (data != null) {
          insightDataAgeGroupRange = data;
          downloadUrl = "";
          downloadUrl = insightDataAgeGroupRange!.url;
        }
        isLoadingMainGraph = false;
        isFilter = false;
      });
    }
  }

  void loadAgeGroupRangeDataFilter() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }
    final data = await GenderInsightService.fetchInsightDataAgeGroupRangeFilter(
      fromDate: fromDate ?? DateTime.now(),
      toDate: toDate ?? DateTime.now(),
      days: _selectedDays,
      hours: _selectedHours,
      selection: _selectedItemsPass,
      stores: _selectedStore,
    );
    if (mounted) {
      setState(() {
        if (data != null) {
          insightDataAgeGroupRangeFilter = data;
          downloadUrl = "";
          downloadUrl = insightDataAgeGroupRangeFilter!.url;
        }
        isLoadingMainGraph = false;
        isFilter = true;
      });
    }
  }

  void loadEmployeeTrakcingData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }

    print("$_items");
    print("$_selectedStore");
    print("$_selectedDays");
    print("$_selectedHours");
    print("$_selectedItemsPass");
    print("$fromDate");
    print("$toDate");

    final data = await ApiServiceEmployeeTracking.fetchData(
      fromDate: fromDate ?? DateTime.now(),
      toDate: toDate ?? DateTime.now(),
      days: _selectedDays,
      hours: _selectedHours,
      selection: _selectedItemsPass,
      stores: _selectedStore,
    );
    print("data: $data");
    if (mounted) {
      setState(() {
        if (data != null) {
          futureDataEmployeeTracking = data;
          downloadUrl = "";
          downloadUrl = futureDataEmployeeTracking?.url.toString() ?? "";
        }
        isLoadingMainGraph = false;
        isFilter = true;
      });
    }
  }

  void loadTimeSpentData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    final data = await GenderInsightService.fetchTimeSpentData(
      _selectedFilterCValuePasss,
    );
    print("data: $data");
    if (mounted) {
      setState(() {
        print("data: $data");
        if (data != null) {
          insightDataTimeSpent = data;
          downloadUrl = "";
          downloadUrl = insightDataTimeSpent!.url;
          print("downloadUrlTimeSpent: $downloadUrl");
        }
        isLoadingMainGraph = false;
        isFilter = false;
      });
    }
  }

  void loadTimeSpentDataFilter() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    final data = await GenderInsightService.fetchTimeSpentDataFilter(
      fromDate: fromDate ?? DateTime.now(),
      toDate: toDate ?? DateTime.now(),
      days: _selectedDays,
      hours: _selectedHours,
      selection: _selectedItemsPass,
      stores: _selectedStore,
    );
    print("data: $data");
    if (mounted) {
      setState(() {
        print("data: $data");
        if (data != null) {
          insightDataTimeSpent = data;
          downloadUrl = "";
          downloadUrl = insightDataTimeSpent!.url;
          print("downloadUrlTimeSpent: $downloadUrl");
        }
        isLoadingMainGraph = false;
        isFilter = true;
      });
    }
  }

  void loadAgeGroupData() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = false;
      });
    }
    final data = await GenderInsightService.fetchInsightDataAgeGroup(
      _selectedFilterCValuePasss,
    );
    if (mounted) {
      setState(() {
        print("data: $data");
        print("insightDataAgeGroup: $ageGroup");
        if (data != null) {
          ageGroup = data;
          downloadUrl = "";
          downloadUrl = ageGroup!.url;
          print("downloadUrlAgeGroup: $downloadUrl");
        }
        isLoadingMainGraph = false;
        isFilter = false;
      });
    }
  }

  void loadAgeGroupDataFilter() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }
    final data = await GenderInsightService.fetchAgeFilterTimeLineFilter(
      fromDate: fromDate ?? DateTime.now(),
      toDate: toDate ?? DateTime.now(),
      days: _selectedDays,
      hours: _selectedHours,
      selection: _selectedItemsPass,
      stores: _selectedStore,
    );
    if (mounted) {
      setState(() {
        print("data: $data");
        print("insightDataFilterAgeGroup: ${ageGroup?.adultData}");
        if (data != null) {
          filterAgeGroup = data;
          downloadUrl = "";
          downloadUrl = ageGroup!.url;
          print("downloadUrlAgeGroup: $downloadUrl");
        }
        isLoadingMainGraph = false;
        isFilter = true;
      });
    }
  }

  Future<void> fetchDataFilter() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
      });
    }
    print("$_items");
    print("$_selectedStore");
    print("$_selectedDays");
    print("$_selectedHours");
    print("$_selectedItemsPass");
    print("$fromDate");
    print("$toDate");
    String passFromDate =
        "${fromDate?.year}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate?.year}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}";

    final queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ..._selectedItemsPass.map((e) => 'selectedSections=$e'),
      ..._selectedStore.map((e) => 'selectedStores=$e'),
      ..._selectedDaysPass.map((e) => 'selectedDays=$e'),
      ..._selectedHoursPass.map((e) => 'selectedHours=$e'),
    ];

    final queryString = queryParams.join('&');
    try {
      // Replace with your actual API endpoin
      String url =
          '${BaseNetwork.baseUrl}/analytics_api/footfall_filter_data?&$queryString';

      print(url);

      final response = await http.get(Uri.parse(url));

      print("$url ${response.body}");

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            data = json.decode(response.body);
            labels = List<dynamic>.from(data['labels']);
            values = List<int>.from(data['values']);
            downloadUrl = "";
            downloadUrl = data["url"];
            averageValue = calculateAverage(values);
            isLoadingMainGraph = false;
            isFilter = true;
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingMainGraph = false;
          errorMessage = 'Error loading data: ${e.toString()}';
        });
      }
    }
  }

  Future<void> fetchDataFilterGender() async {
    if (mounted) {
      setState(() {
        isLoadingMainGraph = true;
        isFilter = true;
      });
    }
    print("$_items");
    print("$_selectedStore");
    print("$_selectedDays");
    print("$_selectedHours");
    print("$_selectedItemsPass");
    print("$fromDate");
    print("$toDate");
    String passFromDate =
        "${fromDate?.year}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}";

    String passToDate =
        "${toDate?.year}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}";

    var queryParams = <String>[
      'fromDate=$passFromDate',
      'toDate=$passToDate',
      ..._selectedItemsPass.map((e) => 'selectedSections=$e'),
      ..._selectedStore.map((e) => 'selectedStores=$e'),
      ..._selectedDaysPass.map((e) => 'selectedDays=$e'),
      ..._selectedHoursPass.map((e) => 'selectedHours=$e'),
    ];

    String queryString = queryParams.join('&');

    String url =
        '${BaseNetwork.baseUrl}/analytics_api/gender_filter_data?fromDate=$passFromDate&toDate=$passToDate&$queryString';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (mounted) {
        setState(() {
          print("data: $response");
          print("insightData fileer: $insightData");
          final jsonData = json.decode(response.body);

          insightDataFilter = GenderInsightsModelFilter.fromJson(jsonData);
          downloadUrl = "";
          downloadUrl = insightDataFilter!.url ?? "";
          fetchGenderInsights(insightData, insightDataFilter);
          isLoadingMainGraph = false;
          isFilter = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingMainGraph = false;
          errorMessage = 'Error loading data: ${e.toString()}';
        });
      }
      print('API Error: $e');
    }
  }

  double calculateAverage(List<int> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  bool _showInsights = false;

  Widget footFallChart(title) {
    print("selection title $title");
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.7,
      width: MediaQuery.sizeOf(context).width,
      child:
          isLoadingMainGraph
              ? const Center(
                child: CircularProgressIndicator(color: Colors.pinkAccent),
              )
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use Flexible instead of Expanded to avoid nested Expanded issues
                    Flexible(
                      flex: 2,
                      child:
                          title == 'Gender'
                              ? GenderInsightChart(
                                duration: _selectedFilterCValuePasss,
                                insightData: insightData,
                                insightDataFilter: insightDataFilter,
                                isFilter: isFilter,
                                isLoading: isLoadingMainGraph,
                                maleShow: maleShow,
                                femaleShow: femaleShow,
                                insigethGenderData: insigethGenderData,
                              )
                              : title == 'Age Group'
                              ? AgeGroupAdultChildData(
                                duration: _selectedFilterCValuePasss,
                                insigethGenderData: insigethGenderData,
                                adultShow: ageGroupAdultShow,
                                childShow: ageGroupChildShow,
                                insightDataAgeGroup: ageGroup,
                                insightDataAgeGroupFilter: filterAgeGroup,
                                isFilter: isFilter,
                                isLoading: isLoadingMainGraph,
                              )
                              : title == 'Age Range'
                              ? AgeRangeLineChart(
                                isLoading: isLoadingMainGraph,
                                duration: _selectedFilterCValuePasss,
                                insightDataAgeGroup: insightDataAgeGroupRange,
                                insightDataAgeGroupFilter:
                                    insightDataAgeGroupRangeFilter,
                                isFilter: isFilter,
                              )
                              : title == 'Time spent'
                              ? buildChartTimeSpent(
                                insightDataTimeSpent ??
                                    TimeSpentModel(
                                      url: "",
                                      labels: [],
                                      values: [],
                                      insightsDf: '',
                                      insightsFilterType: '',
                                    ),
                                true,
                                true,
                              )
                              : title == 'Shelf Data'
                              ? SelfDataTableScreen(
                                dataList: futureDataSelfData?.data ?? [],
                              )
                              : title == 'Employee Tracking'
                              ? EmployeeTrackingTableScreen(
                                dataList:
                                    futureDataEmployeeTracking?.data ?? [],
                              )
                              : buildChartFootFallFirst(
                                labels,
                                values,
                                mainGraphShow,
                                averageShow,
                                false,
                                averageValue,
                                _selectedFilterCValuePasss,
                              ), // footfall
                    ),
                    const SizedBox(height: 8),
                    if (title != 'Shelf Data')
                      Center(
                        child: Text(
                          "DAYS/HOURS",
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (title != 'Shelf Data')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 14,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _showInsights = !_showInsights;
                          });
                        },
                        child: Text(
                          _showInsights
                              ? 'Hide $title Insights'
                              : 'Show $title Insights',
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    if (insigethGenderData.isNotEmpty &&
                        title == 'Gender' &&
                        _showInsights)
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            insigethGenderData,
                            style: GoogleFonts.oxygen(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                    if (_showInsights && title == 'Footfall')
                      Flexible(
                        flex: 1,
                        child:
                            _selectedFilterCValuePasss == "1D"
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 20),

                                  child: InsightsView(
                                    type: _selectedFilterCValuePasss,
                                    counts: labels,
                                    hours: values,
                                  ),
                                )
                                : Padding(
                                  padding: const EdgeInsets.only(top: 20),

                                  child: InsightsTextWidget(
                                    apiResponse: data as Map<String, dynamic>,
                                  ),
                                ),
                      ),
                  ],
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor, // Light blue background
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopNavBarCommon(
                    level: level,
                    name: adminName,
                    image: image,
                    callback: () {},
                  ),

                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 18),
                    child: TabBar(
                      controller: _mainTabController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ), // Inner padding around the TabBar

                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: Color(
                          0xFFD73B73,
                        ).withOpacity(0.8), // Inner tab background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      automaticIndicatorColorAdjustment: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (value) {
                        // Handle tab change if needed
                        print("Selected Tab: $value");
                        setIndex(
                          value + 1,
                        ); // Update index based on selected tab
                      },

                      labelColor: Colors.white, // Selected text color
                      unselectedLabelColor:
                          Colors.black, // Unselected text color
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Tab(
                            child: Text(
                              "Analytics",
                              style: GoogleFonts.oxygen(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Tab(
                            child: Text(
                              "Alert Reviews",
                              style: GoogleFonts.oxygen(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Tab(
                            child: Text(
                              "Weekly Summary",
                              style: GoogleFonts.oxygen(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  if (index == 1) tabSlectionOne(),
                  if (index == 2)
                    isLoadingMainGraph
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          ),
                        )
                        : tableContewntViewAlertReview(context, alertResponse!),
                  if (index == 3) AnalyticsMainPage(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int index = 1; // Change this to switch between tabs
  void setIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  String _selectedFilter = '1 Day'; // Default selected button
  String _selectedFilterCValuePasss = '1D'; // Default selected button

  Widget _buildTimeButton(String text, passwvalue) {
    final isSelected = _selectedFilter == text;
    final backgroundColor =
        isSelected
            ? Colors.pink[100] // Light pink for selected
            : Colors.grey[100]; // Grey for unselected

    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedFilter = text;
            _selectedFilterCValuePasss = passwvalue;
            print("selectionINdex: $selectionINdex");
            if (selectionINdex == 0) {
              fetchFootFallData();
            } else if (selectionINdex == 1) {
              loadGenderData();
            } else if (selectionINdex == 2) {
              loadAgeGroupData();
            } else if (selectionINdex == 3) {
              loadAgeGroupRangeData();
            } else if (selectionINdex == 4) {
              loadTimeSpentData();
            } else if (selectionINdex == 5) {
              loadSelfDataApi();
            } else if (selectionINdex == 6) {
              loadEmployeeTrakcingData();
            }
          });
          // Add your filter logic here
        },
        style: ElevatedButton.styleFrom(
          // elevation: 1,
          backgroundColor: backgroundColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(
          text,
          style: GoogleFonts.oxygen(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget tabSlectionOne() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 1.3,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _subTabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.pink,
                    indicatorWeight: 1,
                    onTap: (value) {
                      setState(() {
                        selectionINdex = value;
                        _selectedFilterCValuePasss = "1D";
                        _selectedFilter = "1 Day";
                        _buildTimeButton("1 Day", "1D");
                        if (selectionINdex == 0) {
                          fetchFootFallData();
                        } else if (selectionINdex == 1) {
                          loadGenderData();
                        } else if (selectionINdex == 2) {
                          loadAgeGroupData();
                        } else if (selectionINdex == 3) {
                          loadAgeGroupRangeData();
                        } else if (selectionINdex == 4) {
                          loadTimeSpentData();
                        } else if (selectionINdex == 5) {
                          loadSelfDataApi();
                        } else if (selectionINdex == 6) {
                          loadEmployeeTrakcingData();
                        }
                      });
                    },
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    indicatorColor: Colors.pink,
                    tabs: [
                      Tab(text: 'Footfall'),
                      Tab(text: 'Gender'),
                      Tab(text: 'Age Group'),
                      Tab(text: 'Age Range'),
                      Tab(text: 'Time spent'),
                      Tab(text: 'Shelf Data'),
                      Tab(text: 'Employee Tracking'),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            selectionINdex == 0
                                ? 'Store Footfall'
                                : selectionINdex == 1
                                ? 'Store Footfall  Gender Distribution'
                                : selectionINdex == 2
                                ? 'Store Footfall Age Distribution'
                                : selectionINdex == 3
                                ? 'Footfall-Age Category Distribution'
                                : selectionINdex == 4
                                ? 'Store Footfall Time spent'
                                : selectionINdex == 5
                                ? 'SHELF DATA'
                                : selectionINdex == 6
                                ? "Employee Tracking"
                                : "",
                            style: GoogleFonts.oxygen(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          if (selectionINdex != 5 && selectionINdex != 6)
                            Row(
                              children: [
                                SizedBox(width: 8),
                                _buildTimeButton("1 Day", "1D"),
                                SizedBox(width: 8),
                                SizedBox(width: 8),
                                _buildTimeButton("1 Week", "1W"),
                                SizedBox(width: 8),
                                SizedBox(width: 8),
                                _buildTimeButton("1 Month", "1M"),
                                SizedBox(width: 8),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(width: 10),

                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (selectionINdex == 0)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      mainGraphShow = !mainGraphShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/kids.svg",
                                    width: 80,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),
                            if (selectionINdex == 0) SizedBox(width: 8),
                            if (selectionINdex == 0)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      averageShow = !averageShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/adults.svg",
                                    width: 90,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),
                            if (selectionINdex == 1)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      maleShow = !maleShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/male.svg",
                                    width: 80,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),
                            if (selectionINdex == 1) SizedBox(width: 8),
                            if (selectionINdex == 1)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      femaleShow = !femaleShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/female.svg",
                                    width: 90,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),
                            if (selectionINdex == 2)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      ageGroupAdultShow = !ageGroupAdultShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/adults_new.svg",
                                    width: 80,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),

                            if (selectionINdex == 2) SizedBox(width: 8),
                            if (selectionINdex == 2)
                              GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      ageGroupChildShow = !ageGroupChildShow;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 90,
                                  child: SvgPicture.asset(
                                    "assets/kids_1.svg",
                                    width: 90,
                                    fit: BoxFit.contain,
                                  ), // kids , //buy button
                                ),
                              ),

                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                _openUrl(downloadUrl);
                              },
                              child: SizedBox(
                                width: 100,
                                child: SvgPicture.asset(
                                  "assets/buy button.svg",
                                  width: 100,
                                  fit: BoxFit.fill,
                                ), // kids , //buy button
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (selectionINdex == 3) AgeGroupIndicator(),
                  if (selectionINdex == 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 22, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${averageValue.toStringAsFixed(2)} %',
                            style: GoogleFonts.oxygen(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Total Average',
                            style: GoogleFonts.oxygen(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child:
                            selectionINdex == 0
                                ? footFallChart('Footfall')
                                : selectionINdex == 1
                                ? footFallChart('Gender')
                                : selectionINdex == 2
                                ? footFallChart('Age Group')
                                : selectionINdex == 3
                                ? footFallChart('Age Range')
                                : selectionINdex == 4
                                ? footFallChart('Time spent')
                                : selectionINdex == 5
                                ? footFallChart('Shelf Data')
                                : selectionINdex == 6
                                ? footFallChart('Employee Tracking')
                                : SizedBox(),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Container(
              // margin: EdgeInsets.only(top: 35, bottom: 50),
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  width: 300,
                  height: MediaQuery.sizeOf(context).height / 1.3,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            _pickDate(isFrom: true);
                          },
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  fromDate != null
                                      ? "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}"
                                      : 'Select End Date',
                              enabled: false,
                              hintStyle: TextStyle(
                                color:
                                    fromDate != null
                                        ? Colors.black
                                        : Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.pinkAccent,
                              ),
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'To',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),

                        GestureDetector(
                          onTap: () {
                            _pickDate(isFrom: false);
                          },
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  toDate != null
                                      ? "${toDate!.day}/${toDate!.month}/${toDate!.year}"
                                      : 'Select To Date',
                              enabled: false,
                              hintStyle: TextStyle(
                                color:
                                    toDate != null ? Colors.black : Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.pinkAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 14),
                        Text(
                          'Store',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),

                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: CompositedTransformTarget(
                            link: _layerLink4,
                            child: GestureDetector(
                              onTap: _toggleDropdown4,
                              child: Container(
                                key: _key4,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                width: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _selectedStore.isEmpty
                                            ? 'Select Store'
                                            : _selectedStore.join(', '),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 14),
                        Text(
                          'Zone',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),

                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: CompositedTransformTarget(
                            link: _layerLink,
                            child: GestureDetector(
                              onTap:
                                  selectionINdex == 5
                                      ? _toggleDropdownShelfData
                                      : _toggleDropdown,
                              child: Container(
                                key: _key,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                width: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _selectedItems.isEmpty
                                            ? 'Select Zone'
                                            : _selectedItems.join(', '),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Day Of Week',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: CompositedTransformTarget(
                            link: _layerLink2,
                            child: GestureDetector(
                              onTap: _toggleDropdown2,
                              child: Container(
                                key: _key2,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                width: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _selectedDays.isEmpty
                                            ? 'Select Day Of Week'
                                            : _selectedDays.join(', '),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 14),
                        Text(
                          'Hours Of Day',
                          style: GoogleFonts.oxygen(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: CompositedTransformTarget(
                            link: _layerLink3,
                            child: GestureDetector(
                              onTap: _toggleDropdown3,
                              child: Container(
                                key: _key3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                width: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _selectedHours.isEmpty
                                            ? 'Select Hours Of Day'
                                            : _selectedHours.join(', '),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFD73B73),
                                Color(0xFFF57AA3),
                              ], // dark pink to light pink
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // match button shape
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (fromDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select Start date'),
                                  ),
                                );
                              } else if (toDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select End date'),
                                  ),
                                );
                              } else {
                                if (selectionINdex == 1) {
                                  fetchDataFilterGender();
                                } else if (selectionINdex == 2) {
                                  loadAgeGroupDataFilter();
                                } else if (selectionINdex == 3) {
                                  loadAgeGroupRangeDataFilter();
                                } else if (selectionINdex == 4) {
                                  loadTimeSpentDataFilter();
                                } else if (selectionINdex == 5) {
                                  loadSelfDataApi();
                                } else if (selectionINdex == 6) {
                                  loadEmployeeTrakcingData();
                                } else {
                                  fetchDataFilter();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                            ),
                            child: Text(
                              'APPLY',
                              style: GoogleFonts.oxygen(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 207, 206, 206),
                                Color.fromARGB(255, 226, 223, 224),
                              ], // dark pink to light pink
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // match button shape
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  fromDate = null;
                                  toDate = null;
                                  _selectedStore = [];
                                  _selectedItems = [];
                                  _selectedDays = [];
                                  _selectedHours = [];
                                  _selectedDaysPass = [];
                                  _selectedHoursPass = [];
                                  _selectedFilterCValuePasss = "1D";
                                  _selectedFilter = "1 Day";
                                  _buildTimeButton("1 Day", "1D");
                                  if (selectionINdex == 0) {
                                    fetchFootFallData();
                                  } else if (selectionINdex == 1) {
                                    loadGenderData();
                                  } else if (selectionINdex == 2) {
                                    loadAgeGroupData();
                                  } else if (selectionINdex == 3) {
                                    loadAgeGroupRangeData();
                                  } else if (selectionINdex == 4) {
                                    loadTimeSpentData();
                                  } else if (selectionINdex == 5) {
                                    loadSelfDataApi();
                                  } else if (selectionINdex == 6) {
                                    loadEmployeeTrakcingData();
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                            ),
                            child: Text(
                              'CLEAR FILTERS',
                              style: GoogleFonts.oxygen(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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

          SizedBox(width: 20),
        ],
      ),
    );
  }

  final List<String> _items = [
    'ENTRANCE',
    'PATH_WAY',
    'BILLING',
    'PERFUMES',
    'LIQUOR',
    'OPTICALS',
    'PERFUMES',
    'TOBACCO',
    'WATCHES',
    'CHOCOLATE',
  ];

  final List<String> _itemsShelfData = [
    'LIQUOR',
    'OPTICALS',
    'PERFUMES',
    'PERFUMES',
    'TOBACCO',
    'WATCHES',
    'CHOCOLATE',
  ];

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _storeName = ['GMRHDF'];

  final List<String> _hourSlots = List.generate(24, (index) {
    final from = index.toString().padLeft(2, '0');
    final to = ((index + 1) % 24).toString().padLeft(2, '0');
    return '$from-$to';
  });

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _pickDate({required bool isFrom}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isFrom ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
          toDate = DateTime.now();
        } else {
          toDate = picked;
        }
      });
    }
  }

  final LayerLink _layerLink = LayerLink();
  final LayerLink _layerLink2 = LayerLink();
  final LayerLink _layerLink3 = LayerLink();
  final LayerLink _layerLink4 = LayerLink();

  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayEntry2;
  OverlayEntry? _overlayEntry3;
  OverlayEntry? _overlayEntry4;

  final GlobalKey _key = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();

  void _toggleDropdown4() {
    if (_overlayEntry4 == null) {
      _showDropdown4();
    } else {
      _removeDropdown4();
    }
  }

  void _toggleDropdown3() {
    if (_overlayEntry3 == null) {
      _showDropdown3();
    } else {
      _removeDropdown3();
    }
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _toggleDropdownShelfData() {
    if (_overlayEntry == null) {
      _showDropdownShelfData();
    } else {
      _removeDropdown();
    }
  }

  void _toggleDropdown2() {
    if (_overlayEntry2 == null) {
      _showDropdown2();
    } else {
      _removeDropdown2();
    }
  }

  void _showDropdown3() {
    final renderBox = _key3.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry3 = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          height: 200,
          child: CompositedTransformFollower(
            link: _layerLink3,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (context, localSetState) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children:
                          _hourSlots.map((item) {
                            final isSelected = _selectedHours.contains(item);
                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    _selectedHours.add(item);
                                    _selectedHoursPass.add(
                                      int.parse(item.split('-')[0]),
                                    );
                                  } else {
                                    _selectedHours.remove(item);
                                    _selectedHoursPass.remove(
                                      int.parse(item.split('-')[0]),
                                    );
                                  }
                                });
                                localSetState(() {});
                              },
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry3!);
  }

  void _showDropdown4() {
    final renderBox = _key4.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry4 = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink4,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (context, localSetState) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children:
                          _storeName.map((item) {
                            final isSelected = _selectedStore.contains(item);
                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    _selectedStore.add(item);
                                  } else {
                                    _selectedStore.remove(item);
                                  }
                                });
                                localSetState(() {});
                              },
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry4!);
  }

  void _showDropdown2() {
    final renderBox = _key2.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry2 = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink2,

            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (
                    BuildContext context,
                    void Function(void Function()) setStateNew,
                  ) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children:
                          daysOfWeek.map((item) {
                            final isSelected = _selectedDays.contains(item);
                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    _selectedDays.add(item);
                                    if (item == 'Sunday') {
                                      _selectedDaysPass.add(1);
                                    } else if (item == 'Monday') {
                                      _selectedDaysPass.add(2);
                                    } else if (item == 'Tuesday') {
                                      _selectedDaysPass.add(3);
                                    } else if (item == 'Wednesday') {
                                      _selectedDaysPass.add(4);
                                    } else if (item == 'Thursday') {
                                      _selectedDaysPass.add(5);
                                    } else if (item == 'Friday') {
                                      _selectedDaysPass.add(6);
                                    } else if (item == 'Saturday') {
                                      _selectedDaysPass.add(7);
                                    }
                                  } else {
                                    _selectedDays.remove(item);
                                    if (item == 'Sunday') {
                                      _selectedDaysPass.remove(1);
                                    } else if (item == 'Monday') {
                                      _selectedDaysPass.remove(2);
                                    } else if (item == 'Tuesday') {
                                      _selectedDaysPass.remove(3);
                                    } else if (item == 'Wednesday') {
                                      _selectedDaysPass.remove(4);
                                    } else if (item == 'Thursday') {
                                      _selectedDaysPass.remove(5);
                                    } else if (item == 'Friday') {
                                      _selectedDaysPass.remove(6);
                                    } else if (item == 'Saturday') {
                                      _selectedDaysPass.remove(7);
                                    }
                                  }
                                });
                                setStateNew(() {});
                              },
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry2!);
  }

  void _showDropdown() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (context, localSetState) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children:
                          _items.map((item) {
                            final isSelected = _selectedItems.contains(item);
                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    if (item == "BILLING") {
                                      _selectedItemsPass.add("BILLING_COUNTER");
                                    } else if (item == "CHOCOLATE") {
                                      _selectedItemsPass.add("CHOCOLATES");
                                    } else {
                                      _selectedItemsPass.add(item);
                                    }
                                    _selectedItems.add(item);
                                  } else {
                                    if (item == "BILLING") {
                                      _selectedItemsPass.remove(
                                        "BILLING_COUNTER",
                                      );
                                    } else if (item == "CHOCOLATE") {
                                      _selectedItemsPass.remove("CHOCOLATES");
                                    } else {
                                      _selectedItemsPass.remove(item);
                                    }
                                    _selectedItems.remove(item);
                                  }
                                });
                                localSetState(() {});
                              },
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _showDropdownShelfData() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 200,
                child: StatefulBuilder(
                  builder: (context, localSetState) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children:
                          _itemsShelfData.map((item) {
                            final isSelected = _selectedItems.contains(item);
                            return CheckboxListTile(
                              value: isSelected,
                              title: Text(item),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    if (item == "BILLING") {
                                      _selectedItemsPass.add("BILLING_COUNTER");
                                    } else if (item == "CHOCOLATE") {
                                      _selectedItemsPass.add("CHOCOLATES");
                                    } else {
                                      _selectedItemsPass.add(item);
                                    }
                                    _selectedItems.add(item);
                                  } else {
                                    if (item == "BILLING") {
                                      _selectedItemsPass.remove(
                                        "BILLING_COUNTER",
                                      );
                                    } else if (item == "CHOCOLATE") {
                                      _selectedItemsPass.remove("CHOCOLATES");
                                    } else {
                                      _selectedItemsPass.remove(item);
                                    }
                                    _selectedItems.remove(item);
                                  }
                                });
                                localSetState(() {});
                              },
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _removeDropdown2() {
    _overlayEntry2?.remove();
    _overlayEntry2 = null;
  }

  void _removeDropdown3() {
    _overlayEntry3?.remove();
    _overlayEntry3 = null;
  }

  void _removeDropdown4() {
    _overlayEntry4?.remove();
    _overlayEntry4 = null;
  }

  int selectionINdex = 0;

  Widget _buildStatusChip(String status) {
    return Row(
      children: [
        Image.asset("assets/Group 5.png", width: 100, height: 12),
        SizedBox(width: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),

          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffF55772)),
            color: Color(0xffFFF1F2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Color(0xffF43F5E),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChipRed(String status) {
    return Row(
      children: [
        Image.asset("assets/Group 6.png", width: 100, height: 12),
        SizedBox(width: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3AC47D)),
            color: Color.fromARGB(255, 231, 241, 236),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Color(0xFF3AC47D),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  int tableINdex = 0;
  Widget tableContewntViewAlertReview(context, AlertReviewModel response) {
    print("response: $response");
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.4,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width / 1.2,
          ),

          child: DataTable(
            headingRowHeight: 48,
            dataRowHeight: 48,
            columnSpacing: 24,
            headingTextStyle: const TextStyle(
              color: Color(0xFF3A3F51),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            dataTextStyle: const TextStyle(
              color: Color(0xFF3A3F51),
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),

            columns: [
              const DataColumn(
                headingRowAlignment: MainAxisAlignment.spaceBetween,
                label: Text('No'),
              ),
              const DataColumn(
                headingRowAlignment: MainAxisAlignment.spaceBetween,
                label: Text('Date'),
              ),

              const DataColumn(
                headingRowAlignment: MainAxisAlignment.spaceBetween,
                label: Text('No Of Notification'),
              ),
              const DataColumn(
                headingRowAlignment: MainAxisAlignment.spaceBetween,
                label: Text('Resolve %'),
              ),

              DataColumn(
                headingRowAlignment: MainAxisAlignment.spaceBetween,
                label: Text("Resolve %"),
              ),
            ],
            rows:
                response.dailyData?.asMap().entries.map((entry) {
                  final index = entry.key + 1; // +1 to start from 1
                  final e = entry.value;

                  return DataRow(
                    cells: [
                      DataCell(Text(index.toString())),
                      DataCell(Text(e.date ?? '')), // from your model
                      DataCell(Text(e.notifications?.toString() ?? '0')),
                      DataCell(_buildStatusChip("${e.resolvePercent ?? 0}%")),
                      DataCell(
                        _buildStatusChipRed("${e.resolvePercent ?? 0}%"),
                      ),
                    ],
                  );
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
