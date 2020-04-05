import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class CategoryPicker extends StatelessWidget {
  final Function onSelect;
  final String selected;
  const CategoryPicker({Key key, this.selected, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 10,
        spacing: 5,
        children: _getAllCategories()
            .map(
              (c) => _getCategoryWidget(c[0], c[1], c[2]),
            )
            .toList(),
      ),
    );
  }

  List<List<String>> _getAllCategories() {
    List<List<String>> icons = [
      ['beetroot-and-carrot', 'Groceries', 'GROCERIES'],
      ['check-for-payment', 'Cash', 'CASH'],
      ['cinema', 'Movies', 'MOVIES'],
      ['money-box', 'Savings', 'SAVINGS'],
      ['online-store', 'Shopping', 'SHOPPING'],
      ['receipt-approved', 'Bills', 'BILLS'],
      ['restaurant', 'Food', 'FOOD'],
      ['tax', 'Tax', 'TAX'],
      ['taxi-back-view', 'Transport', 'TRANSPORT'],
      ['treatment', 'Medical', 'TREATMENT'],
      ['transaction-approved', 'General', 'TRANS_APPROVED'],
    ];

    return icons.map((icon) {
      icon[0] = 'assets/icons/icons8-${icon[0]}-100.png';
      return icon;
    }).toList();
  }

  Widget _getCategoryWidget(path, name, id) {
    return GestureDetector(
      onTap: () => onSelect(id),
      child: Container(
        color: selected == id
            ? MonexColors.primary.withOpacity(.1)
            : Colors.transparent,
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
      ),
    );
  }
}
