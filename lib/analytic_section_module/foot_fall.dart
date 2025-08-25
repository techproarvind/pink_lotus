import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as flChart;
import 'package:google_fonts/google_fonts.dart';

Widget buildChartFootFallFirst(
  List<dynamic> labels,
  List<int> values,
  bool mainGraphShow,
  bool averageShow,
  bool isTimeStamp,
  double averageValue,
  String _selectedFilterCValuePasss,
) {
  double getNiceInterval(double maxY, int divisions) {
    if (maxY == 0) return 1;

    double roughInterval = maxY / divisions;

    // Use top-level log() and ln10 for base-10 logarithm
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

  // Calculate min/max values safely
  double minX = 0;
  double maxX = (labels.length - 1).toDouble();
  double maxY =
      values.isNotEmpty
          ? values.reduce((a, b) => a > b ? a : b).toDouble() * 1.2
          : 100;

  double yInterval = getNiceInterval(maxY, 5);

  return Row(
    children: [
      RotatedBox(
        quarterTurns: 3, // 1 = 90°, 2 = 180°, 3 = 270°
        child: Text(
          isTimeStamp ? "AVERAGE TIME SPENT" : 'FOOTFALL',
          style: GoogleFonts.oxygen(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: flChart.LineChart(
          flChart.LineChartData(
            minX: minX,
            maxX: maxX,
            minY: 0,
            lineTouchData: flChart.LineTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              touchTooltipData: flChart.LineTouchTooltipData(
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipColor: (flChart.LineBarSpot spot) {
                  return Colors.black54;
                },
                getTooltipItems: (List<flChart.LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    final x = spot.x.toInt();
                    final y = spot.y;
                    final xLabel =
                        (x >= 0 && x < labels.length)
                            ? _formatLabel(labels[x])
                            : 'X: $x';
                    return flChart.LineTooltipItem(
                      "Time:  $xLabel\n"
                      "${isTimeStamp ? "AvgTimeSpent :  ${y.toStringAsFixed(1)}\n" : "Footfall:  ${y.toStringAsFixed(1)}\n"} "
                      "${isTimeStamp ? "" : "Avg: ${averageValue.toStringAsFixed(1)}"}",
                      textAlign: TextAlign.start,
                      TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),

            maxY: maxY,
            titlesData: flChart.FlTitlesData(
              show: true,
              leftTitles: flChart.AxisTitles(
                sideTitles: flChart.SideTitles(
                  showTitles: true,
                  maxIncluded: true,
                  minIncluded: true,
                  interval: yInterval,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: GoogleFonts.oxygen(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: flChart.AxisTitles(
                drawBelowEverything: true,
                sideTitles: flChart.SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval:
                      labels.length <= 30
                          ? _selectedFilterCValuePasss == "1D"
                              ? 2
                              : _selectedFilterCValuePasss == "1W"
                              ? 1
                              : 3
                          : 20,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < labels.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _formatLabel(labels[index]),
                          style: GoogleFonts.oxygen(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              rightTitles: const flChart.AxisTitles(),
              topTitles: const flChart.AxisTitles(),
            ),

            gridData: flChart.FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: yInterval,
              getDrawingHorizontalLine: (value) {
                return flChart.FlLine(color: Colors.grey[300]!, strokeWidth: 1);
              },
              getDrawingVerticalLine: (value) {
                return flChart.FlLine(color: Colors.grey[300]!, strokeWidth: 1);
              },
            ),
            borderData: flChart.FlBorderData(show: true),
            lineBarsData: [
              // Main data line
              flChart.LineChartBarData(
                isCurved: true,
                show: mainGraphShow,
                preventCurveOverShooting: true,
                color: Colors.pink,
                dotData: flChart.FlDotData(show: true),
                belowBarData: flChart.BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 220, 94, 136).withOpacity(0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                spots: List.generate(
                  values.length,

                  (index) => flChart.FlSpot(
                    index.toDouble(), // Use index as x-position
                    values[index].toDouble(),
                  ),
                ),
                barWidth: 3,
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 228, 82, 131),
                    const Color.fromARGB(255, 196, 99, 131),
                  ],
                ),
              ),
              // Average line
              flChart.LineChartBarData(
                isCurved: true,
                show: averageShow,
                color: Colors.blue,
                dotData: const flChart.FlDotData(show: false),
                belowBarData: flChart.BarAreaData(show: false),
                spots: [
                  flChart.FlSpot(minX, averageValue),
                  flChart.FlSpot(maxX, averageValue),
                ],
                barWidth: 2,
                dashArray: [5, 5],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

String _formatLabel(dynamic label) {
  if (label is int) {
    return '$label'; // Format hours (e.g., 11 -> "11:00")
  } else if (label is String) {
    // Handle date strings like "4th Jul" or "11th Jun"
    final parts = label.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1]}'; // Return "4th Jul" as is
    }
    return label;
  }
  return label.toString();
}
