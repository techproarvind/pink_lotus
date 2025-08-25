import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinklotus/analytic_section_module/age_range/age_range_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class AgeRangeLineChart extends StatelessWidget {
  final InsightAgeGroupModel? insightDataAgeGroup;
  final InsightAgeGroupModel? insightDataAgeGroupFilter;
  final String duration;
  final bool isLoading;
  final bool isFilter;
  AgeRangeLineChart({
    super.key,
    required this.insightDataAgeGroup,
    required this.insightDataAgeGroupFilter,
    required this.duration,
    required this.isLoading,
    required this.isFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.pinkAccent),
      );
    } else {
      if (insightDataAgeGroup == null) {
        return const Center(child: Text("Failed to load data"));
      } else {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'FOOTFALL',
                  style: GoogleFonts.oxygen(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    maxY: isFilter ? _getMaxYFilter() : _getMaxY(),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.black54,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final labelList =
                              isFilter
                                  ? insightDataAgeGroupFilter!.labels
                                  : insightDataAgeGroup!.labels;

                          final hour = labelList[group.x.toInt()];

                          final groupLabels = [
                            "0-10",
                            "10-20",
                            "20-30",
                            "30-40",
                            "40-50",
                            "50-60",
                            "60+",
                          ];

                          // Get the data for this x-index (i.e., this hour)
                          final x = group.x.toInt();

                          final dataValues = [
                            insightDataAgeGroup!.kidsData[x],
                            insightDataAgeGroup!.teenData[x],
                            insightDataAgeGroup!.youngAdultsData[x],
                            insightDataAgeGroup!.adultData[x],
                            insightDataAgeGroup!.middleAgedAdultsData[x],
                            insightDataAgeGroup!.seniorAdultsData[x],
                            insightDataAgeGroup!.olderAdultsData[x],
                          ];

                          final dataValuesFilter = [
                            insightDataAgeGroupFilter!.kidsData[x],
                            insightDataAgeGroupFilter!.teenData[x],
                            insightDataAgeGroupFilter!.youngAdultsData[x],
                            insightDataAgeGroupFilter!.adultData[x],
                            insightDataAgeGroupFilter!.middleAgedAdultsData[x],
                            insightDataAgeGroupFilter!.seniorAdultsData[x],
                            insightDataAgeGroupFilter!.olderAdultsData[x],
                          ];

                          double total = 0;
                          final buffer = StringBuffer();
                          buffer.writeln("Hour: $hour");

                          for (int i = 0; i < groupLabels.length; i++) {
                            final label = groupLabels[i];
                            final value =
                                isFilter ? dataValuesFilter[i] : dataValues[i];
                            total += value;
                            buffer.writeln("$label: $value");
                          }

                          buffer.writeln("Total: ${total.toInt()}");

                          return BarTooltipItem(
                            buffer.toString(),
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
                              isFilter
                                  ? insightDataAgeGroupFilter!.labels.length <=
                                          30
                                      ? duration == "1D"
                                          ? 3
                                          : duration == "1W"
                                          ? 7
                                          : 30
                                      : 30
                                  : insightDataAgeGroup!.labels.length <= 30
                                  ? duration == "1D"
                                      ? 3
                                      : duration == "1W"
                                      ? 7
                                      : 30
                                  : 30,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            final labelList =
                                isFilter
                                    ? insightDataAgeGroupFilter!.labels
                                    : insightDataAgeGroup!.labels;

                            if (index >= 0 && index < labelList.length) {
                              final label = labelList[index];
                              if (label is int) {
                                return Text(
                                  label.toString(),
                                  style: GoogleFonts.oxygen(fontSize: 10),
                                );
                              } else {
                                return Text(
                                  label.toString().replaceAll(" ", "\n"),
                                  style: GoogleFonts.oxygen(fontSize: 8),
                                  textAlign: TextAlign.center,
                                );
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval:
                              isFilter ? _getIntervalFilter() : _getInterval(),
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
                    barGroups: _buildBarGroups(), // Shared builder function
                  ),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  Color getBlueShade(int value) {
    // Normalize the value to range 0–1
    double normalized = value.clamp(0, 12) / 12;
    // Use HSV to adjust lightness (V)
    return HSVColor.fromAHSV(1, 210, 1, 1 - normalized * 0.5).toColor();
  }

  List<BarChartGroupData> _buildBarGroups() {
    final List<Color> ageGroupColors = [
      Colors.blue.shade900,
      Colors.blue.shade700,
      Colors.blue.shade500,
      Colors.blue.shade300,
      Colors.blue.shade200,
      Colors.blue.shade100,
    ];

    // Assuming you're using these dynamically as per `isFilter`
    final labels =
        isFilter
            ? insightDataAgeGroupFilter!.labels
            : insightDataAgeGroup!.labels;

    final kidsData =
        isFilter
            ? insightDataAgeGroupFilter!.kidsData
            : insightDataAgeGroup!.kidsData;

    final teenData =
        isFilter
            ? insightDataAgeGroupFilter!.teenData
            : insightDataAgeGroup!.teenData;

    final youngAdultsData =
        isFilter
            ? insightDataAgeGroupFilter!.youngAdultsData
            : insightDataAgeGroup!.youngAdultsData;

    final middleAgedAdultsData =
        isFilter
            ? insightDataAgeGroupFilter!.middleAgedAdultsData
            : insightDataAgeGroup!.middleAgedAdultsData;

    final olderAdultsData =
        isFilter
            ? insightDataAgeGroupFilter!.olderAdultsData
            : insightDataAgeGroup!.olderAdultsData;

    final seniorAdultsData =
        isFilter
            ? insightDataAgeGroupFilter!.seniorAdultsData
            : insightDataAgeGroup!.seniorAdultsData;

    final barGroups = List.generate(labels.length, (index) {
      double start = 0;
      final data = [
        kidsData[index],
        teenData[index],
        youngAdultsData[index],
        middleAgedAdultsData[index],
        olderAdultsData[index],
        seniorAdultsData[index],
      ];

      List<BarChartRodStackItem> stackItems = [];
      for (int i = 0; i < data.length; i++) {
        final value = data[i].toDouble() * 0.4; // scale to half height
        stackItems.add(
          BarChartRodStackItem(
            start,
            start + value.toDouble(),
            ageGroupColors[i],
          ),
        );
        start += value;
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: start,
            rodStackItems: stackItems,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });

    return barGroups;
  }

  double _getNiceInterval(double maxY, int divisions) {
    if (maxY == 0) return 1;

    double roughInterval = maxY / divisions;

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

  double _getMaxY() {
    final all = [
      ...insightDataAgeGroup!.kidsData,
      ...insightDataAgeGroup!.teenData,
      ...insightDataAgeGroup!.youngAdultsData,
      ...insightDataAgeGroup!.adultData,
      ...insightDataAgeGroup!.middleAgedAdultsData,
      ...insightDataAgeGroup!.seniorAdultsData,
      ...insightDataAgeGroup!.olderAdultsData,
    ];

    final max = all.isNotEmpty ? all.reduce((a, b) => a > b ? a : b) : 100;

    return max * 1.2; // add headroom
  }

  double _getMaxYFilter() {
    final all = [
      ...insightDataAgeGroupFilter!.kidsData,
      ...insightDataAgeGroupFilter!.teenData,
      ...insightDataAgeGroupFilter!.youngAdultsData,
      ...insightDataAgeGroupFilter!.adultData,
      ...insightDataAgeGroupFilter!.middleAgedAdultsData,
      ...insightDataAgeGroupFilter!.seniorAdultsData,
      ...insightDataAgeGroupFilter!.olderAdultsData,
    ];

    final max = all.isNotEmpty ? all.reduce((a, b) => a > b ? a : b) : 100;

    return max * 1.2; // add headroom
  }

  double _getInterval() {
    final maxY = _getMaxY();
    return _getNiceInterval(maxY, 5);
  }

  double _getIntervalFilter() {
    final maxY = _getMaxYFilter();
    return _getNiceInterval(maxY, 5);
  }
}
