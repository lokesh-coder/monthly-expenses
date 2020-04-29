import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/models/category.dart';
import 'package:monex/service_locator/service_locator.dart';

class CategoryPicker extends StatelessWidget {
  final Function onSelect;
  final String selected;
  final bool isCredit;
  const CategoryPicker({this.selected, this.onSelect, this.isCredit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 10,
        spacing: 4,
        children: _categories(),
      ),
    );
  }

  List<Widget> _categories() {
    var type = isCredit ? 'CREDIT' : 'DEBIT';
    var categoriesObj = sl<DataRepo>().obj.get<Catagories>('categories');
    var categories = categoriesObj.filterBy(type).map((c) => _category(c));
    return categories.toList();
  }

  Widget _category(Category cat) {
    Color color =
        selected == cat.id ? Clrs.primary.withOpacity(.1) : Colors.transparent;

    return GestureDetector(
      onTap: () => onSelect(cat.id),
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: 80,
        child: Column(
          children: [
            Image.asset(cat.path, width: 35),
            SizedBox(height: 10),
            Text(cat.name, style: Style.label.sm.normal),
          ],
        ),
      ),
    );
  }
}
