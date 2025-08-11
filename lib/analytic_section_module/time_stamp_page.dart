import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/analytic_section_module/foot_fall.dart';
import 'package:pinklotus/analytic_section_module/time_spent_model.dart';

Widget buildChartTimeSpent(
  TimeSpentModel model,
  bool mainGraphShow,
  bool averageShow,
) {
  return buildChartFootFallFirst(
    model.labels,
    model.intValues,
    true, // mainGraphShow
    false, // averageShow
    true,
    model.averageValue,
    model.insightsFilterType,
  );
}
