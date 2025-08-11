import 'package:flutter/material.dart';

class AgeGroupIndicator extends StatelessWidget {
  final List<Map<String, dynamic>> ageGroups = [
    {'range': '0–10', 'color': Colors.blue.shade900},
    {'range': '10–20', 'color': Colors.blue.shade800},
    {'range': '20–30', 'color': Colors.blue.shade700},
    {'range': '30–40', 'color': Colors.blue.shade500},
    {'range': '40–50', 'color': Colors.blue.shade400},
    {'range': '50–60', 'color': Colors.blue.shade300},
    {'range': '60+', 'color': Colors.blue.shade100},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          ageGroups.map((group) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: group['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    group['range'],
                    style: const TextStyle(color: Colors.black, fontSize: 8),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
