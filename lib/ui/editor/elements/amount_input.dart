import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/amount_numpad.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formStore = sl<FormStore>();

    return BottomModal(
      builder: (context, control) {
        return GestureDetector(
          onTap: () {
            _numpad(control, formStore);
          },
          child: Observer(builder: (context) {
            return Container(
              child: _display(formStore),
            );
          }),
        );
      },
    );
  }

  _display(FormStore formStore) {
    if (formStore.amount == null) {
      return Text(
        '0.00',
        style: TextStyle(
          fontSize: 40,
          color: Clrs.label.withOpacity(0.5),
        ),
      );
    }

    return Text(
      formStore.amount.toString(),
      style: TextStyle(
        fontSize: 40,
        color: Color(0xff4F4B71),
      ),
    );
  }

  _numpad(BottomModalControl control, FormStore formStore) {
    Widget numpad = AmountNumpad(
      close: control.close,
      onSelect: (x) {
        formStore.changeAmount(x);
        control.close();
      },
      selected: formStore.amount.toString(),
    );
    control.showHeader = false;
    control.open('Categoriess', numpad);
  }
}
