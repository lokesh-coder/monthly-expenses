import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class CategoryPicker extends StatelessWidget {
  final Function onSelect;
  const CategoryPicker({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 10,
        spacing: 5,
        children: _getAllCategories()
            .map(
              (c) => _getCategoryWidget(c[0], c[1]),
            )
            .toList(),
      ),
    );
  }

  List<List<String>> _getAllCategories() {
    return [
      ['assets/icons/icons8-beetroot-and-carrot-100.png', 'Groceries'],
      ['assets/icons/icons8-check-for-payment-100.png', 'Cash'],
      ['assets/icons/icons8-cinema-100.png', 'Movies'],
      ['assets/icons/icons8-money-box-100.png', 'Savings'],
      ['assets/icons/icons8-online-store-100.png', 'Shopping'],
      ['assets/icons/icons8-receipt-approved-100.png', 'Bills'],
      ['assets/icons/icons8-restaurant-100.png', 'Food'],
      ['assets/icons/icons8-tax-100.png', 'Tax'],
      ['assets/icons/icons8-taxi-back-view-100.png', 'Transport'],
      ['assets/icons/icons8-treatment-100.png', 'Medical'],
      ['assets/icons/icons8-transaction-approved-100.png', 'General'],
    ];
  }

  Widget _getCategoryWidget(path, name) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 70,
      child: Column(
        children: <Widget>[
          Image.asset(
            path,
            width: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            // maxLines: 1,
            // overflow: TextOverflow.clip,
            style: TextStyle(
              color: MonexColors.inputLabel,
            ),
          ),
        ],
      ),
    );
  }
}
