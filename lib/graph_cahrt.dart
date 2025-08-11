import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ChartHomePage extends StatefulWidget {
  @override
  _ChartHomePageState createState() => _ChartHomePageState();
}

class _ChartHomePageState extends State<ChartHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _charts = [
    LineChartCard(),
    BarChartCard(),
    PieChartCard(),
    AreaChartCard(),
    //  ScatterChartCard(),
  ];

  final List<String> _chartTitles = [
    "Line Chart",
    "Bar Chart",
    "Pie Chart",
    "Area Chart",
    "Scatter Chart",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Text(
                  'Graph Showcase',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
                Spacer(),
                ...List.generate(_chartTitles.length, (index) {
                  bool isSelected = index == _selectedIndex;
                  return Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _chartTitles[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 700),
          switchInCurve: Curves.easeOutQuint,
          switchOutCurve: Curves.easeInQuint,
          child: Container(
            key: ValueKey<int>(_selectedIndex),
            width: 800,
            height: 480,
            child: _charts[_selectedIndex],
          ),
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final Widget chartWidget;

  const ChartCard({required this.title, required this.chartWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Expanded(child: chartWidget),
          ],
        ),
      ),
    );
  }
}

class LineChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: "Smooth Animated Line Chart",
      chartWidget: LineChart(
        LineChartData(
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 6,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 1),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 1),
            ),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            verticalInterval: 1,
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              curveSmoothness: 0.4,
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 2),
                FlSpot(2, 5),
                FlSpot(3, 3.1),
                FlSpot(4, 4),
                FlSpot(5, 3),
                FlSpot(6, 4),
                FlSpot(7, 3.5),
              ],
              barWidth: 4,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blueAccent.withOpacity(0.2),
              ),
              color: Colors.blueAccent,
            ),
          ],
        ),
         duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      
      ),
    );
  }
}

class BarChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barGroups = List.generate(7, (index) {
      final yVals = [3, 5, 2, 7, 4, 6, 1];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: yVals[index].toDouble(),
            color: Colors.deepPurpleAccent,
            width: 20,
            borderRadius: BorderRadius.circular(6),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 8,
              color: Colors.deepPurpleAccent.withOpacity(0.1),
            ),
          ),
        ],
      );
    });

    return ChartCard(
      title: "Animated Bar Chart",
      chartWidget: BarChart(
        BarChartData(
          barGroups: barGroups,
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            drawVerticalLine: false,
            getDrawingHorizontalLine:
                (value) => FlLine(
                  color: Colors.grey.withOpacity(0.1),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black54),
              left: BorderSide(width: 1, color: Colors.black54),
              right: BorderSide.none,
              top: BorderSide.none,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 1),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  String text = '';
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    text = days[value.toInt()];
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
                interval: 1,
              ),
            ),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
          ),
          maxY: 8,
        ),
      duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

class PieChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sections = [
      PieChartSectionData(
        value: 40,
        color: Colors.amberAccent,
        title: '40%',
        radius: 90,
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        badgeWidget: const Icon(Icons.star, color: Colors.amber, size: 28),
        badgePositionPercentageOffset: 1.35,
      ),
      PieChartSectionData(
        value: 30,
        color: Colors.lightBlueAccent,
        title: '30%',
        radius: 75,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      PieChartSectionData(
        value: 15,
        color: Colors.pinkAccent,
        title: '15%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      PieChartSectionData(
        value: 15,
        color: Colors.greenAccent,
        title: '15%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ];

    return ChartCard(
      title: "Animated Pie Chart",
      chartWidget: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 50,
          startDegreeOffset: 270,
          sectionsSpace: 4,
          borderData: FlBorderData(show: false),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,      ),
    );
  }
}

class AreaChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: "Animated Area Chart",
      chartWidget: LineChart(
        LineChartData(
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 8,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final labels = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                  ];
                  if (value.toInt() < labels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        labels[value.toInt()],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 2),
            ),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black45, width: 1),
          ),
          gridData: FlGridData(show: true, horizontalInterval: 2),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 4),
                FlSpot(3, 3.6),
                FlSpot(4, 5),
                FlSpot(5, 3.2),
                FlSpot(6, 4),
                FlSpot(7, 3),
              ],
              isCurved: true,
              curveSmoothness: 0.5,
              color: Colors.teal,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.teal.withOpacity(0.3),
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withOpacity(0.5),
                    Colors.teal.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,      ),
    );
  }
}
