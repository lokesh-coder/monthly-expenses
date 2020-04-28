import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/dimensions.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/confirm_modal.dart';
import 'package:monex/ui/common/hint.dart';

class ActionButton extends StatelessWidget {
  final Function onSubmit;
  final Function onClose;
  final Function onDelete;

  const ActionButton({this.onSubmit, this.onDelete, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_secondary(), _primary(), _tertiary()],
      ),
    );
  }

  Widget _primary() {
    return Expanded(
      child: Container(
        height: Dimensions.actionBtnHeight,
        child: FloatingActionButton(
          backgroundColor: Clrs.primary,
          child: Icon(MIcons.tick),
          onPressed: onSubmit,
        ),
      ),
    );
  }

  Widget _secondary() {
    if (sl<FormStore>().isNew) return SizedBox(width: 35);
    var icon = Icon(MIcons.delete_bin_line, size: 26, color: Clrs.label);

    return ConfirmModal(
      builder: (context, control) {
        return Hint(
          Labels.deletePayment,
          child: IconButton(
            color: Colors.black26,
            onPressed: () {
              control.title = Labels.deleteConfirm;
              control.yesLabel = Labels.delete;
              control.noLabel = Labels.cancel;
              control.icon = MIcons.delete_bin_2_line;
              control.onYes = () {
                var sandwichStore = sl<SandwichStore>();
                var paymentsStore = sl<PaymentsStore>();

                sandwichStore.changeVisibility(false);
                paymentsStore.deletePayment(paymentsStore.active);
                paymentsStore.setActivePayment(null);
              };
              control.open();
            },
            icon: icon,
          ),
        );
      },
    );
  }

  Widget _tertiary() {
    return Hint(
      Labels.closeEditor,
      child: IconButton(
        icon: Icon(MIcons.arrow_down_s_line, size: 30, color: Clrs.label),
        onPressed: () {
          sl<SandwichStore>().changeVisibility(false);
        },
      ),
    );
  }
}
