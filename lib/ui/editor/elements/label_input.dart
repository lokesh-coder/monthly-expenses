import 'package:flutter/material.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/ui/editor/elements/base_input.dart';

class LabelInput extends StatelessWidget {
  final Function(String) onSaved;
  final Function validator;
  final String value;

  const LabelInput({Key key, this.value, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      onSaved: onSaved,
      placeholder: 'type short name',
      validator: (String x) => x.isEmpty ? 'please provide a name' : null,
      value: value,
      inputType: InputType.TEXT,
      label: 'label',
    );
  }
}
