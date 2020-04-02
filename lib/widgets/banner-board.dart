import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'modules/sandwich/model.dart';

class BannerBoard extends StatelessWidget {
  final int index;
  final dynamic data;
  final PageController ctrl;

  const BannerBoard(this.index, this.data, this.ctrl, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var sandwich = Provider.of<SandwichModel>(context, listen: true);
    // print('@@#### ${sandwich.yDistance}');
    return Container(
      color: Color(0xff6156A4),
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
                      'hello-$index',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white30,
                      ),
                    ),
                    Text(
                      '3200',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Colors.white70,
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
