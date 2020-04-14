import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/confirm_modal.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final Function onSubmit;
  final Function onClose;
  final Function onDelete;
  final double btnHeight = 60;

  const ActionButton(
      {Key key, this.label, this.onSubmit, this.onDelete, this.onClose})
      : super(key: key);

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
        height: btnHeight,
        child: FloatingActionButton(
          backgroundColor: Clrs.primary,
          child: Icon(Icons.check),
          onPressed: onSubmit,
        ),
      ),
    );
  }

  Widget _secondary() {
    if (sl<FormStore>().isNew) return SizedBox(width: 35);
    var icon = Icon(Icons.delete_outline, size: 35);

    return ConfirmModal(builder: (context, control) {
      return IconButton(
        color: Colors.black26,
        onPressed: () {
          control.title = 'Are you sure?';
          control.yesLabel = 'Delete';
          control.noLabel = 'cancel';
          control.icon = Icons.delete;
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
      );
    });
  }

  Widget _tertiary() {
    return IconButton(
        icon: Icon(Icons.keyboard_arrow_down, size: 30),
        onPressed: () {
          sl<SandwichStore>().changeVisibility(false);
        });
  }
}
