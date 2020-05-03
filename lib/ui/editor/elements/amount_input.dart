import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/amount.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/amount_numpad.dart';

class AmountInput extends StatelessWidget {
  const AmountInput();

  @override
  Widget build(BuildContext context) {
    final formStore = sl<FormStore>();

    return BottomModal(
      hasPadding: false,
      builder: (context, control) {
        return GestureDetector(
          onTap: () => _numpad(control, formStore),
          child: Observer(builder: (context) {
            return _display(formStore.amount);
          }),
        );
      },
    );
  }

  Widget _display(num amount) {
    num _amount = 0.00;
    AmountDisplayType type = AmountDisplayType.PLACEHOLDER;

    if (amount != null) {
      _amount = amount;
      type = AmountDisplayType.INPUT;
    }

    return Amount(_amount, type: type, size: DisplaySize.XL);
  }

  void _numpad(BottomModalControl control, FormStore formStore) {
    final Widget numpad = AmountNumpad(
      close: control.close,
      onSelect: (x) {
        formStore.changeAmount(x);
        control.close();
      },
      selected: formStore.amount.toString(),
    );
    control.showHeader = false;
    control.open(Labels.categories, numpad);
  }
}
