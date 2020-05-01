import "dart:ui";

import "package:flutter/material.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/typography.dart";
import "package:monex/data/data_repository.dart";
import "package:monex/data/local/object/files/categories.dart";
import "package:monex/models/category.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/ui/common/button.dart";

class CategoryPicker extends StatelessWidget {
  final Function onSelect;
  final String selected;
  final bool isCredit;
  const CategoryPicker({this.selected, this.onSelect, this.isCredit});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        padding: EdgeInsets.all(0),
        physics: BouncingScrollPhysics(),
        crossAxisCount: 4,
        shrinkWrap: true,
        children: _categories(),
      ),
    );
  }

  List<Widget> _categories() {
    var type = isCredit ? "CREDIT" : "DEBIT";
    var categoriesObj = sl<DataRepo>().obj.get<Catagories>("categories");
    var categories = categoriesObj.filterBy(type).map((c) => _category(c));
    return categories.toList();
  }

  Widget _category(Category cat) {
    Color bgColor = selected == cat.id ? Clrs.light : Colors.transparent;

    return Button(
      color: bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(cat.path, height: 35),
          SizedBox(height: 10),
          Text(cat.name, style: Style.label.sm.normal),
        ],
      ),
      onPressed: () => onSelect(cat.id),
    );
  }
}
