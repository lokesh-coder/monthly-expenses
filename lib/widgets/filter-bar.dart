import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffDCC6B6).withOpacity(0.05),
      child: Column(
        children: <Widget>[
          Divider(
            color: MonexColors.border,
            height: 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                      'All',
                      style: TextStyle(fontWeight: FontWeight.w500),
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
                      Text('Credit'),
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
                      Text('Debit'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: MonexColors.border,
            height: 1,
          )
        ],
      ),
    );
  }
}
