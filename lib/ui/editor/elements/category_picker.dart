import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/models/category.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/ui/common/button.dart';

class CategoryPicker extends StatelessWidget {
  final Function onSelect;
  final String selected;
  final bool isCredit;
  const CategoryPicker({this.selected, this.onSelect, this.isCredit});

  @override
  Widget build(BuildContext context) {
    final type = isCredit ? 'CREDIT' : 'DEBIT';
    final categoriesObj = sl<DataRepo>().obj.get<Catagories>('categories');
    final categories = categoriesObj.filterBy(type);
    return Flexible(
      child: GridView.builder(
        padding: EdgeInsets.all(0),
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          final item = categories[index];
          return _CategoryItem(item, onSelect: onSelect, selected: selected);
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category cat;
  final Function onSelect;
  final String selected;
  const _CategoryItem(this.cat, {this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = selected == cat.id ? Clrs.light : Colors.transparent;

    return Button(
      color: bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(cat.path, height: 35, cacheHeight: 35),
          SizedBox(height: 10),
          Text(cat.name, style: Style.label.sm.normal),
        ],
      ),
      onPressed: () => onSelect(cat.id),
    );
  }
}
