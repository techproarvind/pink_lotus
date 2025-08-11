import 'package:flutter/material.dart';
import 'package:pinklotus/analytics_module_main_page/analytics_child_2.dart';

class AnalyticsChild1 extends StatefulWidget {
  final Function(int) callback;
  const AnalyticsChild1({super.key, required this.callback});

  @override
  State<AnalyticsChild1> createState() => _AnalyticsChild1State();
}

class _AnalyticsChild1State extends State<AnalyticsChild1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          widget.callback.call(2);
        },
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 300,
              child: Image.asset(
                getImageName[index],
                fit: BoxFit.contain,
                height: 300,
                filterQuality: FilterQuality.high,
              ),
            );
          },
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 16);
          }, // Adjust based on your data
        ),
      ),
    );
  }

  List<String> getImageName = [
    'assets/security.png',
    "assets/packing.png",
    "assets/RND.png",
  ];
}
