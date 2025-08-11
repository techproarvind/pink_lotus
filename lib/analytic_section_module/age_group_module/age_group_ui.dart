import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/analytic_section_module/age_group_module/age_group_model.dart';

class AgeGroupAdultChildData extends StatefulWidget {
  final String duration;
  final bool isLoading;
  final AgeGroupFilterModel? insightDataAgeGroupFilter;
  final AgeGroupModelData? insightDataAgeGroup;
  final String insigethGenderData;
  final bool adultShow;
  final bool childShow;
  final bool isFilter;
  const AgeGroupAdultChildData({
    super.key,
    required this.duration,
    required this.insightDataAgeGroup,
    required this.insightDataAgeGroupFilter,
    required this.isLoading,
    required this.insigethGenderData,
    required this.adultShow,
    required this.childShow,
    required this.isFilter,
  });

  @override
  State<AgeGroupAdultChildData> createState() => _AgeGroupAdultChildDataState();
}

class _AgeGroupAdultChildDataState extends State<AgeGroupAdultChildData> {
  @override
  void initState() {
    super.initState();
    print(
      "insigethAgeGroupData: ${widget.insigethGenderData}----${widget.isFilter}",
    );
    print("insightDataFilterAgeGroup: ${widget.insightDataAgeGroupFilter}");
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(
          child: CircularProgressIndicator(color: Colors.pinkAccent),
        )
        : widget.insightDataAgeGroup == null &&
            widget.insightDataAgeGroupFilter == null
        ? const Center(child: Text("Failed to load data"))
        : Padding(
          padding: const EdgeInsets.all(16),
          child:
              !widget.isFilter
                  ? Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 3, // 1 = 90°, 2 = 180°, 3 = 270°
                        child: Text(
                          'FOOTFALL',
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceBetween,
                            maxY: _getMaxY(),

                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (group) => Colors.black54,
                                getTooltipItem: (
                                  group,
                                  groupIndex,
                                  rod,
                                  rodIndex,
                                ) {
                                  final hour =
                                      widget.insightDataAgeGroup!.labels[group.x
                                          .toInt()];
                                  final gender =
                                      rodIndex == 0 ? "Adults" : "Kids";
                                  final value = rod.toY;
                                  return BarTooltipItem(
                                    "$gender\nHour: $hour\nCount: ${value.toInt()}",
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(),

                              rightTitles: AxisTitles(),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval:
                                      widget.duration == "1D"
                                          ? 2
                                          : widget.duration == "1W"
                                          ? 1
                                          : 5,

                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 &&
                                        index <
                                            widget
                                                .insightDataAgeGroup!
                                                .labels
                                                .length) {
                                      final label =
                                          widget
                                              .insightDataAgeGroup!
                                              .labels[index];

                                      if (label is int) {
                                        // Hour (for 1D)
                                        return Text(
                                          label.toString(),
                                          style: GoogleFonts.oxygen(
                                            fontSize: 10,
                                          ),
                                        );
                                      } else if (label is String) {
                                        // Day (for 1W, 1M)
                                        return Text(
                                          label.replaceAll(
                                            " ",
                                            "\n",
                                          ), // Wrap label
                                          style: GoogleFonts.oxygen(
                                            fontSize: 8,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,

                                  interval: _getInterval(),
                                  getTitlesWidget:
                                      (value, meta) => Text(
                                        value.toStringAsFixed(0),
                                        style: GoogleFonts.oxygen(fontSize: 10),
                                      ),
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black, width: 1),
                            ),

                            barGroups: _buildBarGroups(),
                          ),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 3, // 1 = 90°, 2 = 180°, 3 = 270°
                        child: Text(
                          'FOOTFALL',
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceBetween,
                            maxY: _getMaxYFilter(),
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (group) => Colors.black54,
                                getTooltipItem: (
                                  group,
                                  groupIndex,
                                  rod,
                                  rodIndex,
                                ) {
                                  final hour =
                                      widget
                                          .insightDataAgeGroupFilter!
                                          .labels![group.x.toInt()];
                                  final gender =
                                      rodIndex == 0 ? "Adults" : "Kids";
                                  final value = rod.toY;
                                  return BarTooltipItem(
                                    "$gender\nHour: $hour\nCount: ${value.toInt()}",
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(),

                              rightTitles: AxisTitles(),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval:
                                      widget.duration == "1D"
                                          ? 2
                                          : widget.duration == "1W"
                                          ? 1
                                          : 5,

                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 &&
                                        index <
                                            widget
                                                .insightDataAgeGroupFilter!
                                                .labels
                                                !.length) {
                                      final label =
                                          widget
                                              .insightDataAgeGroupFilter!
                                              .labels![index];

                                      if (label is int) {
                                        // Hour (for 1D)
                                        return Text(
                                          label.toString(),
                                          style: GoogleFonts.oxygen(
                                            fontSize: 10,
                                          ),
                                        );
                                      } else {
                                        // Day (for 1W, 1M)
                                      return Text(
                                        label.replaceAll(
                                          " ",
                                          "\n",
                                        ), // Wrap label
                                        style: GoogleFonts.oxygen(
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      );
                                      }
                                    
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: _getIntervalFilter(),
                                  getTitlesWidget:
                                      (value, meta) => Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.oxygen(fontSize: 10),
                                      ),
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            barGroups: _buildBarGroupsFilter(),
                          ),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ],
                  ),
        );
  }

  double _getNiceInterval(double maxY, int divisions) {
    if (maxY == 0) return 1;

    double roughInterval = maxY / divisions;

    // Compute the exponent of the nearest lower power of 10
    double exponent = (log(roughInterval) / ln10).floorToDouble();
    double base = pow(10, exponent).toDouble();

    // Define clean steps (can extend if needed)
    List<double> niceSteps = [1, 2, 5, 10];

    for (double step in niceSteps) {
      if (step * base >= roughInterval) {
        return step * base;
      }
    }

    return 10 * base; // Fallback
  }

  double _getInterval() {
    final maxY = _getMaxY();
    return _getNiceInterval(maxY, 5); // 5 = number of Y-axis divisions
  }

  double _getIntervalFilter() {
    final maxY = _getMaxYFilter();
    return _getNiceInterval(maxY, 5); // 5 = number of Y-axis divisions
  }

  double _getMaxY() {
    final allValues = [
      ...widget.insightDataAgeGroup!.adultData,
      ...widget.insightDataAgeGroup!.kidsData,
    ];

    final max =
        allValues.isNotEmpty ? allValues.reduce((a, b) => a > b ? a : b) : 100;

    return max * 1.2; // Add headroom
  }

  double _getMaxYFilter() {
    final allValues = [
      ...widget.insightDataAgeGroupFilter!.adultData!,
      ...widget.insightDataAgeGroupFilter!.kidsData!,
    ];

    final max =
        allValues.isNotEmpty ? allValues.reduce((a, b) => a > b ? a : b) : 100;

    return max * 1.2; // Add headroom
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(widget.insightDataAgeGroup!.labels.length, (index) {
      final adult = widget.insightDataAgeGroup!.adultData[index].toDouble();
      final kids = widget.insightDataAgeGroup!.kidsData[index].toDouble();
      return BarChartGroupData(
        x: index,

        barRods: [
          BarChartRodData(
            toY: adult,
            width: 12,
            borderRadius: BorderRadius.circular(0),
            gradient:
                widget.adultShow
                    ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffDC6060), // Top color
                        Color(0xffFFA07A), // Bottom color (lighter shade)
                      ],
                    )
                    : null,
          ),
          BarChartRodData(
            toY: kids,
            width: 12,
            borderRadius: BorderRadius.circular(0),
            gradient:
                widget.childShow
                    ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff66AFEB), Color(0xffADD8E6)],
                    )
                    : null,
          ),
        ],
        barsSpace: 0,
      );
    });
  }

  List<BarChartGroupData> _buildBarGroupsFilter() {
    return List.generate(widget.insightDataAgeGroupFilter!.labels!.length, (
      index,
    ) {
      final adult =
          widget.insightDataAgeGroupFilter!.adultData![index].toDouble();
      final kids = widget.insightDataAgeGroupFilter!.kidsData![index].toDouble();
      return BarChartGroupData(
        x: index,

        barRods: [
          BarChartRodData(
            toY: adult,
            width: 12,
            borderRadius: BorderRadius.circular(0),
            gradient:
                widget.adultShow
                    ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffDC6060), // Top color
                        Color(0xffFFA07A), // Bottom color (lighter shade)
                      ],
                    )
                    : null,
          ),
          BarChartRodData(
            toY: kids,
            width: 12,
            borderRadius: BorderRadius.circular(0),
            gradient:
                widget.childShow
                    ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff66AFEB), Color(0xffADD8E6)],
                    )
                    : null,
          ),
        ],
        barsSpace: 0,
      );
    });
  }
}
