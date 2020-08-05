import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:provider/provider.dart';

class Empty extends StatelessWidget {
  final PaymentType filter;
  const Empty(this.filter);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    var message = '';

    switch (filter) {
      case PaymentType.DEBIT:
        message = Labels.noDebitsToShow;
        break;
      case PaymentType.CREDIT:
        message = Labels.noCreditsToShow;
        break;
      default:
        message = Labels.noPaymentsToShow;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(MIcons.widgets_24px, color: theme.textSubHeading, size: 35),
        SizedBox(height: 20),
        Text(message, style: Style.body.sm.clr(theme.textSubHeading)),
        FlatButton(
          child: Text(
            Labels.addNewPayment.toUpperCase(),
            style: Style.body.ls.sm.clr(theme.brand),
          ),
          onPressed: () {
            sl<PaymentsStore>().setActivePayment(null);
            sl<SandwichStore>().changeVisibility(true);
          },
        ),
      ],
    );
  }
}
