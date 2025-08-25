import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/analytic_section_module/networj_call_gender.dart';

class GenderInsightChart extends StatefulWidget {
  final String duration;
  final bool isLoading;
  final GenderInsightsModelFilter? insightDataFilter;
  final GenderInsightsModel? insightData;
  final String insigethGenderData;
  final bool maleShow;
  final bool femaleShow;
  final bool isFilter;
  const GenderInsightChart({
    super.key,
    required this.duration,
    required this.insightData,
    required this.insightDataFilter,
    required this.isLoading,
    required this.insigethGenderData,
    required this.maleShow,
    required this.femaleShow,
    required this.isFilter,
  });

  @override
  State<GenderInsightChart> createState() => _GenderInsightChartState();
}

class _GenderInsightChartState extends State<GenderInsightChart> {
  @override
  void initState() {
    super.initState();
    print("insigethGenderData: ${widget.insigethGenderData}");
    print("insightDataFilter: ${widget.insightDataFilter}");
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(
          child: CircularProgressIndicator(color: Colors.pinkAccent),
        )
        : widget.insightData == null && widget.insightDataFilter == null
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
                                      widget.insightData!.labels[group.x
                                          .toInt()];
                                  final gender =
                                      rodIndex == 0 ? "Male" : "Female";
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
                                      widget.insightData!.labels.length <= 30
                                          ? widget.duration == "1D"
                                              ? 2
                                              : widget.duration == "1W"
                                              ? 1
                                              : 5
                                          : 30,

                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 &&
                                        index <
                                            widget.insightData!.labels.length) {
                                      final label =
                                          widget.insightData!.labels[index];

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
                                      widget.insightDataFilter!.labels![group.x
                                          .toInt()];
                                  final gender =
                                      rodIndex == 0 ? "Male" : "Female";
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
                                                .insightDataFilter!
                                                .labels!
                                                .length) {
                                      final label =
                                          widget
                                              .insightDataFilter!
                                              .labels![index];

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

    // Use top-level log and ln10 from dart:math
    double exponent = (log(roughInterval) / ln10).floorToDouble();
    double base = pow(10, exponent).toDouble();

    List<double> niceSteps = [1, 2, 5, 10];

    for (double step in niceSteps) {
      if (step * base >= roughInterval) {
        return step * base;
      }
    }

    return 10 * base;
  }

  double _getInterval() {
    final maxY = _getMaxY();
    return _getNiceInterval(maxY, 5);
  }

  double _getIntervalFilter() {
    final maxY = _getMaxYFilter();
    return _getNiceInterval(maxY, 5);
  }

  double _getMaxYFilter() {
    final allValues = [
      ...widget.insightDataFilter!.maleValues!,
      ...widget.insightDataFilter!.femaleValues!,
    ];
    final max =
        allValues.isNotEmpty ? allValues.reduce((a, b) => a > b ? a : b) : 100;
    return (max * 1.2);
  }

  double _getMaxY() {
    final allValues = [
      ...widget.insightData!.maleData,
      ...widget.insightData!.femaleData,
    ];
    final max =
        allValues.isNotEmpty ? allValues.reduce((a, b) => a > b ? a : b) : 100;
    return (max * 1.2);
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(widget.insightData!.labels.length, (index) {
      final male = widget.insightData!.maleData[index].toDouble();
      final female = widget.insightData!.femaleData[index].toDouble();

      print("withoutfilet-$male");
      return BarChartGroupData(
        x: index,

        barRods: [
          BarChartRodData(
            toY: male,
            color: widget.maleShow ? Colors.blue : Colors.transparent,
            width: 12,
            borderRadius: BorderRadius.circular(0),
          ),
          BarChartRodData(
            toY: female,

            color: widget.femaleShow ? Colors.pink : Colors.transparent,
            width: 12,
            borderRadius: BorderRadius.circular(0),
          ),
        ],
        barsSpace: 0,
      );
    });
  }

  List<BarChartGroupData> _buildBarGroupsFilter() {
    return List.generate(widget.insightDataFilter!.labels!.length, (index) {
      final male = widget.insightDataFilter!.maleValues![index].toDouble();
      final female = widget.insightDataFilter!.femaleValues![index].toDouble();
      print("fil;er-$male");
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: male,
            color: widget.maleShow ? Colors.blue : Colors.transparent,
            width: 12,
            borderRadius: BorderRadius.circular(0),
          ),
          BarChartRodData(
            toY: female,
            color: widget.femaleShow ? Colors.pink : Colors.transparent,
            width: 12,
            borderRadius: BorderRadius.circular(0),
          ),
        ],
        barsSpace: 0,
      );
    });
  }
}
