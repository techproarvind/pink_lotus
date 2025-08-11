import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinklotus/network_call/local_storage.dart';
import 'package:pinklotus/utils/top_nav_bar.dart';
import 'package:pinklotus/utils/utils_file.dart';

class SupportCenterPage extends StatefulWidget {
  const SupportCenterPage({Key? key}) : super(key: key);

  static const pink600 = Color(0xFFEC4899);
  static const gray900 = Color(0xFF111827);
  static const gray700 = Color(0xFF374151);
  static const gray600 = Color(0xFF4B5563);
  static const blue600 = Color(0xFF2563EB);
  static const blue100 = Color(0xFFE0E7FF);
  static const yellow500 = Color(0xFFF59E0B);
  static const yellow100 = Color(0xFFFFF4D6);
  static const borderGray300 = Color(0xFFD1D5DB);
  static const bgColor = Color(0xFFFEFEFE);

  @override
  State<SupportCenterPage> createState() => _SupportCenterPageState();
}

class _SupportCenterPageState extends State<SupportCenterPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
    super.initState();
  }

  String adminName = "", level = "", storeName = "", image = "";

  List<dynamic> getStoralist = [];

  void getUserData() async {
    Map<String, dynamic>? loadedUser = await LocalStorage.getUserData();
    if (mounted) {
      setState(() {
        adminName = loadedUser?['emp_name'];
        level = loadedUser?['user_designation'];
        getStoralist = loadedUser?['STORES'];
        image = loadedUser?['image_url'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsFile.backgorundColor,
      body: Column(
        children: [
                       TopNavBarCommon(level: level, name: adminName, image: image,
            callback: () {},
          ),

          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 220,
            // constraints: const BoxConstraints(maxWidth: 700, maxHeight: 300),
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: SupportCenterPage.bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: SupportCenterPage.borderGray300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WELCOME TO OUR SUPPORT CENTER!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffEA4E93),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your satisfaction is important to us.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1F263E),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text:
                                  'We have curated some common queries for the quickest resolution on our ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff1F263E),
                              ),
                            ),
                            TextSpan(
                              text: "FAQ's page.",
                              style: const TextStyle(
                                color: SupportCenterPage.pink600,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                decorationColor: SupportCenterPage.pink600,
                                decoration: TextDecoration.underline,
                              ),
                              // You can add gesture recognizer here if needed
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your previous queries with us:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1F263E),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If you still need help, we are always here to support:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1F263E),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Phone Support
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: SupportCenterPage.blue100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: SupportCenterPage.blue600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 12,
                                color: SupportCenterPage.gray900,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: SupportCenterPage.gray900,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Phone Support',
                                          style: GoogleFonts.oxygen(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' : Call us directly at ',
                                        ),
                                        TextSpan(
                                          text: '+91-7075024141.',
                                          style: GoogleFonts.oxygen(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: SupportCenterPage.gray600,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Available '),
                                        TextSpan(
                                          text: '9:00 AM - 5:00 PM',
                                          style: GoogleFonts.oxygen(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const TextSpan(text: ' daily.'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Divider(color: SupportCenterPage.borderGray300),
                      const SizedBox(height: 12),
                      // Email Support
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: SupportCenterPage.yellow100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.email,
                              color: SupportCenterPage.yellow500,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 12,
                                color: SupportCenterPage.gray900,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: SupportCenterPage.gray900,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Email Support',
                                          style: GoogleFonts.oxygen(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const TextSpan(text: ' : Email us'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: SupportCenterPage.gray900,
                                      ),
                                      children: [
                                        const TextSpan(text: 'at '),
                                        TextSpan(
                                          text: 'info@pinklotus.ai',
                                          style: const TextStyle(
                                            color: SupportCenterPage.pink600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          // You can add gesture recognizer for email tap here
                                        ),
                                        const TextSpan(
                                          text: '. Responses within 4 hours.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: tableContewntView(context),
          ),
        ],
      ),
    );
  }

  final List<Map<String, String>> tickets = const [
    {
      'No': '1',
      'Ticket No': '24',
      'Location': 'Standard Reagents',
      'Subject': 'Billing',
      'Description': 'High wait time at billing',
      'Status': 'Open',
      'Open Time': '06 Dec, 10:08',
      'Closed Time': '',
      'Duration': '',
    },
    {
      'No': '2',
      'Ticket No': '27',
      'Location': 'Standard Reagents',
      'Subject': 'Billing',
      'Description': 'High wait time at billing',
      'Status': 'Open',
      'Open Time': '06 Dec, 10:08',
      'Closed Time': '',
      'Duration': '',
    },
    {
      'No': '3',
      'Ticket No': '31',
      'Location': 'Standard Reagents',
      'Subject': 'Billing',
      'Description': 'High wait time at billing',
      'Status': 'Open',
      'Open Time': '06 Dec, 10:08',
      'Closed Time': '',
      'Duration': '',
    },
  ];

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3AC47D)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Color(0xFF3AC47D),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildHeaderCell(
    String text, {
    Widget? icon,
    bool roundedLeft = false,
    bool roundedRight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: roundedLeft ? const Radius.circular(12) : Radius.zero,
          right: roundedRight ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, SizedBox(width: 8)],
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF3A3F51),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClockIcon() {
    return const Icon(Icons.access_time, size: 14, color: Color(0xFFA1A5B7));
  }

  Widget tableContewntView(context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('No'),
                ),
                const DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('Ticket No'),
                ),
                const DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('Location'),
                ),
                const DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('Subject'),
                ),
                const DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('Description'),
                ),
                const DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: Text('Status'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: _buildHeaderCell('Open Time', icon: _buildClockIcon()),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: _buildHeaderCell(
                    'Closed Time',
                    icon: _buildClockIcon(),
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceBetween,
                  label: _buildHeaderCell('Duration', roundedRight: true),
                ),
              ],
              rows:
                  tickets.map((ticket) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            ticket['No']!,
                            style: TextStyle(
                              color: Color(0xff1F263E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            ticket['Ticket No']!,
                            style: TextStyle(
                              color: Color(0xff1F263E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            ticket['Location']!,
                            style: TextStyle(
                              color: Color(0xff1F263E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            ticket['Subject']!,
                            style: TextStyle(
                              color: Color(0xff1F263E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            ticket['Description']!,
                            style: TextStyle(
                              color: Color(0xff1F263E),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        DataCell(_buildStatusChip(ticket['Status']!)),
                        DataCell(Text(ticket['Open Time']!)),
                        DataCell(Text(ticket['Closed Time']!)),
                        DataCell(Text(ticket['Duration']!)),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
