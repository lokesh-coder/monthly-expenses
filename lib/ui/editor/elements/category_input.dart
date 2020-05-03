import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/models/category.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/category_picker.dart';
import 'package:monex/ui/editor/elements/icon_card.dart';

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
