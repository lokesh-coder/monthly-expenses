import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/models/category.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/base_input.dart';
import 'package:monex/ui/editor/elements/category_picker.dart';

class CategoryInput extends StatefulWidget {
  final Function(String) onSaved;
  final Function validator;
  final String value;
  final bool isCredit;

  const CategoryInput(
      {Key key, this.value, this.onSaved, this.validator, this.isCredit})
      : super(key: key);

  @override
  _CategoryInputState createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  String currVal;

  @override
  void initState() {
    super.initState();
    currVal = widget.value;
  }

  @override
  didUpdateWidget(x) {
    super.didUpdateWidget(x);
    setState(() {
      currVal = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _boxDecoration(),
      child: BottomModal(
        builder: (context, control) {
          return BaseInput(
            placeholder: 'type short name',
            validator: (String x) => null,
            value: _catMeta(currVal).name,
            inputType: InputType.NONE,
            label: 'category',
            onSaved: (id) => widget.onSaved(_catMeta(currVal).id),
            onTap: () => _picker(control),
          );
        },
      ),
    );
  }

  void _picker(BottomModalControl control) {
    Widget picker = CategoryPicker(
      isCredit: widget.isCredit,
      onSelect: (id) {
        setState(() {
          currVal = id;
        });
        control.close();
      },
      selected: _catMeta(currVal).id,
    );
    control.open('Categoriess', picker);
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border(right: BorderSide(color: Clrs.inputBorder)),
    );
  }

  Category _catMeta(String catID) {
    var categoriesObj = sl<DataRepo>().obj.get<Catagories>('categories');
    var category = catID == null
        ? categoriesObj.defaultCategory
        : categoriesObj.findCategoryById(catID);
    return category;
  }
}
