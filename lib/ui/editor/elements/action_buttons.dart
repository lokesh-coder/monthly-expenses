import 'package:flutter/material.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/form/form.store.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/ui/common/button.dart';
import 'package:monthlyexp/ui/common/confirm_modal.dart';
import 'package:monthlyexp/ui/common/hint.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  final Function onSubmit;
  final Function onClose;
  final Function onDelete;

  const ActionButton({this.onSubmit, this.onDelete, this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _secondary(theme),
          _primary(theme),
          _tertiary(theme)
        ],
      ),
    );
  }

  Widget _primary(AppTheme theme) {
    return Expanded(
      child: Center(
        child: Button(
          size: Dimensions.actionBtnSize,
          color: theme.brand,
          highlightColor: theme.green,
          onPressed: onSubmit,
          child: Icon(MIcons.tick, color: Colors.white70, size: 30),
        ),
      ),
    );
  }

  Widget _secondary(AppTheme theme) {
    if (sl<FormStore>().isNew) {
      return SizedBox(width: 35);
    }
    final icon =
        Icon(MIcons.delete_bin_line, size: 26, color: theme.textSubHeading);

    return ConfirmModal(
      builder: (context, control) {
        return Hint(
          Labels.deletePayment,
          child: IconButton(
            color: Colors.black26,
            onPressed: () {
              control
                ..title = Labels.deleteConfirm
                ..yesLabel = Labels.delete
                ..noLabel = Labels.cancel
                ..icon = MIcons.delete_bin_2_line
                ..onYes = () {
                  final sandwichStore = sl<SandwichStore>();
                  final paymentsStore = sl<PaymentsStore>();

                  sandwichStore.changeVisibility(false);
                  paymentsStore
                    ..deletePayment(paymentsStore.active)
                    ..setActivePayment(null);
                };
              control.open();
            },
            icon: icon,
          ),
        );
      },
    );
  }

  Widget _tertiary(AppTheme theme) {
    return Hint(
      Labels.closeEditor,
      child: IconButton(
        icon: Icon(MIcons.arrow_down_s_line,
            size: 30, color: theme.textSubHeading),
        onPressed: () {
          sl<SandwichStore>().changeVisibility(false);
        },
      ),
    );
  }
}
