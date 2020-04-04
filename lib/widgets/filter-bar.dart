import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff6156A4),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.lens,
                      size: 13,
                      color: MonexColors.yellow,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'ALL',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Opacity(
                  opacity: 0.4,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lens,
                        size: 13,
                        color: MonexColors.green,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'CREDIT',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Opacity(
                  opacity: 0.4,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lens,
                        size: 13,
                        color: MonexColors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'DEBIT',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
