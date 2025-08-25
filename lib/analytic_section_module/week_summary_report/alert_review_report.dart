import 'package:flutter/material.dart';
import 'package:pinklotus/analytic_section_module/alert_review/alert_review_model.dart';

Widget tableContewntViewAlertReview(context, AlertReviewModel response) {
  print("response: $response");
  return Container(
    height: MediaQuery.sizeOf(context).height / 1.4,
    width: MediaQuery.sizeOf(context).width,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
            const DataColumn(
              headingRowAlignment: MainAxisAlignment.spaceBetween,
              label: Text('No'),
            ),
            const DataColumn(
              headingRowAlignment: MainAxisAlignment.spaceBetween,
              label: Text('Date'),
            ),

            const DataColumn(
              headingRowAlignment: MainAxisAlignment.spaceBetween,
              label: Text('No Of Notification'),
            ),
            const DataColumn(
              headingRowAlignment: MainAxisAlignment.spaceBetween,
              label: Text('Resolve %'),
            ),

            DataColumn(
              headingRowAlignment: MainAxisAlignment.spaceBetween,
              label: Text("Resolve %"),
            ),
          ],
          rows:
              response.dailyData?.asMap().entries.map((entry) {
                final index = entry.key + 1; // +1 to start from 1
                final e = entry.value;

                return DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(e.date ?? '')), // from your model
                    DataCell(Text(e.notifications?.toString() ?? '0')),
                    DataCell(_buildStatusChip("${e.resolvePercent ?? 0}%")),
                    DataCell(_buildStatusChipRed("${e.resolvePercent ?? 0}%")),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    ),
  );
}

Widget _buildStatusChip(String status) {
  return Row(
    children: [
      Image.asset("assets/Group 5.png", width: 100, height: 12),
      SizedBox(width: 14),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),

        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffF55772)),
          color: Color(0xffFFF1F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Color(0xffF43F5E),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget _buildStatusChipRed(String status) {
  return Row(
    children: [
      Image.asset("assets/Group 6.png", width: 100, height: 12),
      SizedBox(width: 14),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3AC47D)),
          color: Color.fromARGB(255, 231, 241, 236),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Color(0xFF3AC47D),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

