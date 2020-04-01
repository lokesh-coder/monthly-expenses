import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BannerBoard extends StatelessWidget {
  final String name;

  const BannerBoard({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 8.0,
                  percent: 0.25,
                  center: new Text(
                    "25%",
                    style:
                        TextStyle(fontSize: 12, color: MonexColors.labelActive),
                  ),
                  progressColor: MonexColors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: MonexColors.light,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 19, color: MonexColors.labelActive),
                    ),
                    Text(
                      '3200',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: MonexColors.primary,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: MonexColors.label,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: MonexColors.label,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
