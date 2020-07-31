import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/categories.dart';
import 'package:monthlyexp/models/category.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/form/form.store.dart';
import 'package:monthlyexp/ui/common/bottom_modal.dart';
import 'package:monthlyexp/ui/editor/elements/category_picker.dart';
import 'package:monthlyexp/ui/editor/elements/icon_card.dart';

class CategoryInput extends StatelessWidget {
  const CategoryInput();

  @override
  Widget build(BuildContext context) {
    final formStore = sl<FormStore>();

    return BottomModal(
      builder: (context, control) {
        return Observer(
          builder: (context) {
            return IconCard(
              child: _imageIcon(formStore),
              name: _catMeta(formStore.categoryID).name.toUpperCase(),
              onTap: () => _picker(control, formStore),
              storeKey: () => formStore.categoryID,
            );
          },
        );
      },
    );
  }

  void _picker(BottomModalControl control, FormStore formStore) {
    final Widget picker = CategoryPicker(
      isCredit: formStore.isCredit,
      onSelect: (id) {
        formStore.changeCategoryID(id);
        control.close();
      },
      selected: _catMeta(formStore.categoryID).id,
    );
    final String type = formStore.isCredit ? 'Credit' : 'Debit';
    control.open([Labels.categories, type].join('  ·  '), picker);
  }

  Category _catMeta(String catID) {
    final categoriesObj = sl<DataRepo>().obj.get<Catagories>('categories');
    final category = categoriesObj.findCategoryById(catID);
    return category;
  }

  Image _imageIcon(FormStore formStore) {
    return Image.asset(
      _catMeta(formStore.categoryID).path,
      alignment: Alignment.center,
    );
  }
}
