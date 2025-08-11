import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/analytics_module_main_page/analytics_child_1.dart';
import 'package:pinklotus/analytics_module_main_page/analytics_child_2.dart';
import 'package:pinklotus/utils/utils_file.dart';

class AnalyticsMainPage extends StatefulWidget {
  const AnalyticsMainPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsMainPage> createState() => _AnalyticsMainPageState();
}

class _AnalyticsMainPageState extends State<AnalyticsMainPage> {
  int selectioninde = 0;
  final List<FloorData> floors = const [
    FloorData(
      title: 'Block- 1 Ground Floor',
      totalEmployees: 85,
      nowEmployees: 77,
      sections: 3,
    ),
    FloorData(
      title: 'Block- 2 Second Floor',
      totalEmployees: 68,
      nowEmployees: 56,
      sections: 3,
    ),
    FloorData(
      title: 'Block- 3 First Floor',
      totalEmployees: 56,
      nowEmployees: 52,
      sections: 3,
    ),
    FloorData(
      title: 'Block- 3 Fourth Floor',
      totalEmployees: 85,
      nowEmployees: 77,
      sections: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectioninde = 1;
            });
          },
          child:
              selectioninde == 0
                  ? ListView.separated(
                    itemCount: floors.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final floor = floors[index];
                      return FloorCard(floor: floor);
                    },
                  )
                  : selectioninde == 1
                  ? AnalyticsChild1(
                    callback: (p0) {
                      setState(() {
                        selectioninde = p0;
                      });
                    },
                  )
                  : AnalyticsChild2(
                    callback: (p0) {
                      setState(() {
                        selectioninde = p0;
                      });
                    },
                  ),
        ),
      ),
    );
  }
}

class FloorData {
  final String title;
  final int totalEmployees;
  final int nowEmployees;
  final int sections;

  const FloorData({
    required this.title,
    required this.totalEmployees,
    required this.nowEmployees,
    required this.sections,
  });
}

class FloorCard extends StatefulWidget {
  final FloorData floor;

  const FloorCard({Key? key, required this.floor}) : super(key: key);

  @override
  State<FloorCard> createState() => _FloorCardState();
}

class _FloorCardState extends State<FloorCard> {
  int selectioninde = 0;
  @override
  Widget build(BuildContext context) {
    // The blue wavy line graph is a placeholder image from the original screenshot.
    // Using a placeholder network image with alt text description.
    const graphImageUrl = 'assets/graph_image.png';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)), // gray-200
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Left side: icon, title, employees label, graph
          Expanded(
            child: Row(
              children: [
                // Icon circle with stairs icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                    ), // gray-300
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.stairs,
                      size: 20,
                      color: Color(0xFF374151), // gray-700
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Title and employees label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.floor.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF111827), // gray-900
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.groups,
                            size: 14,
                            color: Color(0xFF6B7280), // gray-500
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Employees',
                            style: GoogleFonts.oxygen(
                              fontSize: 12,
                              color: Color(0xFF6B7280), // gray-500
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Graph image
                Image.asset(
                  graphImageUrl,
                  width: 120,
                  height: 40,
                  fit: BoxFit.contain,
                  // semanticLabel:
                  //     'Blue wavy line graph with gradient fade on right side',
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Middle: Total Employees and Now Employees
          SizedBox(
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _EmployeeInfo(
                  label: 'Total Employees',
                  count: widget.floor.totalEmployees,
                ),
                _EmployeeInfo(
                  label: 'Now Employees',
                  count: widget.floor.nowEmployees,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right side: sections count and arrow button
          Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFD1D5DB)), // gray-300
              ),
            ),
            padding: const EdgeInsets.only(left: 24),
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.floor.sections}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF111827), // gray-900
                  ),
                ),
                Text(
                  'Sections',
                  style: GoogleFonts.oxygen(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF111827), // gray-900
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(32, 32),
                    backgroundColor: const Color(0xFFFCE7F3), // pink-100
                    foregroundColor: const Color(0xFFEC4899), // pink-500
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Icon(Icons.arrow_forward, size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeInfo extends StatelessWidget {
  final String label;
  final int count;

  const _EmployeeInfo({Key? key, required this.label, required this.count})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF374151), // gray-700
          ),
        ),
        Text(
          '$count',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF111827), // gray-900
            height: 1,
          ),
        ),
      ],
    );
  }
}
