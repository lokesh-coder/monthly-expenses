import 'package:flutter/material.dart';
import 'package:monex/widgets/CategoryPicker.dart';

class CategoryInputFormField extends FormField<String> {
  CategoryInputFormField({
    Widget title,
    @required BuildContext context,
    FormFieldSetter<String> onSaved,
    Function onSelect,
    FormFieldValidator<String> validator,
    String initialValue = '',
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> state) {
              return CategoryPicker(
                selected: initialValue,
                onSelect: (x) {
                  state.didChange(x);
                  onSelect(x);
                },
              );
            });
}
