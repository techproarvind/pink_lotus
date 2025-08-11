
import 'package:flutter/material.dart';

class AnalyticsChild2 extends StatefulWidget {
    final Function(int) callback;

  const AnalyticsChild2({super.key, required this.callback});

  @override
  State<AnalyticsChild2> createState() => _AnalyticsChild2State();
}

class _AnalyticsChild2State extends State<AnalyticsChild2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: 300,
        child: GestureDetector(
          onTap: () {
            widget.callback.call(0);
          },
          child: Image.asset(
            "assets/srb1pkgfcam.png",
            fit: BoxFit.contain,
            height: 300,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
