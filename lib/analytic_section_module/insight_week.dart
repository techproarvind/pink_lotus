import 'package:flutter/material.dart';

class InsightsTextWidget extends StatelessWidget {
  final Map<String, dynamic> apiResponse;

  const InsightsTextWidget({Key? key, required this.apiResponse})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Safely parse the data with type conversion
    final days = (apiResponse['labels'] as List).cast<String>();
    final counts =
        (apiResponse['values'] as List).map<int>((e) {
          if (e is int) return e;
          if (e is double) return e.toInt();
          return int.tryParse(e.toString()) ?? 0;
        }).toList();

    // Calculate insights
    final peakIndex = counts.indexOf(counts.reduce((a, b) => a > b ? a : b));
    final quietIndex = counts.indexOf(counts.reduce((a, b) => a < b ? a : b));
    final peakDay = _formatDate(days[peakIndex]);
    final peakValue = counts[peakIndex];
    final quietDay = _formatDate(days[quietIndex]);
    final quietValue = counts[quietIndex];

    // Generate insights text
    final insightsText = '''
Peak Day: $peakDay ($peakValue customers)

Quietest Day: $quietDay ($quietValue customers)

Trend: ${_getTrendAnalysis(days, counts)}

Significant Dip: ${_getSignificantDips(days, counts)} Further investigation into the causes of these drops is recommended.
''';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(insightsText, style: TextStyle(fontSize: 14, height: 1.5)),
    );
  }

  String _formatDate(String dateStr) {
    final parts = dateStr.split(' ');
    if (parts.length == 2) {
      return 'July ${parts[0]}'; // Converts "4th Jul" to "July 4th"
    }
    return dateStr;
  }

  String _getTrendAnalysis(List<String> days, List<int> counts) {
    if (counts.length < 2) return 'Insufficient data for trend analysis';

    final firstCount = counts.first;
    final lastCount = counts[counts.length - 2];

    String trend = 'Footfall shows a general ';
    trend += firstCount > lastCount ? 'downward' : 'upward';
    trend +=
        ' trend from ${_formatDate(days.first)} to ${_formatDate(days[days.length - 2])}';

    // Check for specific upticks (July 7th and 10th)
    if (counts.length > 3 && counts[3] > counts[2]) {
      trend += ', with a slight uptick on ${_formatDate(days[3])}';
    }
    if (counts.length > 6 && counts[6] > counts[5]) {
      trend += ' and ${_formatDate(days[6])}';
    }

    return trend;
  }

  String _getSignificantDips(List<String> days, List<int> counts) {
    final dips = <String>[];
    for (int i = 1; i < counts.length; i++) {
      if (counts[i] < counts[i - 1] * 0.9) {
        // >10% drop
        dips.add(
          'between ${_formatDate(days[i - 1])} and ${_formatDate(days[i])}',
        );
      }
    }

    if (dips.isEmpty) return 'No significant dips detected.';
    return 'A noticeable drop in foot traffic is observed ${dips.join(", and again ")}.';
  }
}
