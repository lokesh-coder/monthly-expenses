import 'package:flutter/material.dart';
import 'package:monex/widgets/DueDayPicker.dart';

class DayInputFormField extends FormField<DateTime> {
  DayInputFormField({
    Widget title,
    @required BuildContext context,
    FormFieldSetter<DateTime> onSaved,
    Function onSelect,
    FormFieldValidator<DateTime> validator,
    DateTime initialValue,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<DateTime> state) {
            return DueDayPicker(
              selected: initialValue,
              onSelect: (x) {
                state.didChange(x);
                onSelect(x);
              },
            );
          },
        );
}
