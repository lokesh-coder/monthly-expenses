import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/ui/editor/elements/base_input.dart';

class AmountInput extends StatelessWidget {
  final Function(num) onSaved;
  final Function validator;
  final num value;

  const AmountInput({Key key, this.value, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: BaseInput(
              isPrimary: true,
              onSaved: (String x) => onSaved(num.parse(x)),
              placeholder: '0.0',
              validator: (String x) => x.isEmpty ? 'Amount is mandatory' : null,
              value: value == null ? '' : value.toString(),
              inputType: InputType.CURRENCY,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text('₹',
                style: TextStyle(
                  fontSize: 25,
                  color: Clrs.inputValue.withOpacity(0.5),
                )),
          )
        ],
      ),
    );
  }
}
