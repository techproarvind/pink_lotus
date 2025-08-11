import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class UtilsFile {
  static final backgorundColor = Color(0xFFF5F6FA);
}



class DateUtilsFile {
  /// Format: `04 Jul 2025, 10:30 AM`
  static String formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }


  static String formatLastDateTime(String rawDateTime) {
    try {
      final dateTime = DateFormat(
        'EEE, dd MMM yyyy HH:mm:ss',
      ).parse(rawDateTime);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }
  /// Format: `2025-07-04 10:30:00`
  static String formatDateTimeForBackend(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  /// Format: `04-07-2025 10:30 AM`
  static String formatDateTimeDash(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
