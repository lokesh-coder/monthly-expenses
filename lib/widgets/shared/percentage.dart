import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Percentage extends StatelessWidget {
  final double value;

  const Percentage({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 4.0,
      percent: value / 100,
      center: new Text(
        "${value.round()}%",
        style: TextStyle(fontSize: 12, color: Colors.white38),
      ),
      progressColor: MonexColors.green,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.white12,
    );
  }
}
