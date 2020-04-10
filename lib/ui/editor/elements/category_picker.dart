import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/service_locator/service_locator.dart';

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
        children: _categories(),
      ),
    );
  }

  List<Widget> _categories() {
    var categoriesObj = sl<DataRepo>().obj.get<Catagories>('categories');
    var categories = categoriesObj.all.map((c) => _category(c[0], c[1], c[2]));
    return categories.toList();
  }

  Widget _category(path, name, id) {
    Color color = selected == id
        ? MonexColors.primary.withOpacity(.1)
        : Colors.transparent;

    return GestureDetector(
      onTap: () => onSelect(id),
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: 80,
        child: Column(
          children: <Widget>[
            Image.asset(path, width: 30),
            SizedBox(height: 10),
            Text(name, style: TextStyle(color: MonexColors.inputLabel)),
          ],
        ),
      ),
    );
  }
}
