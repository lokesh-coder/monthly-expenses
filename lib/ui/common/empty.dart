import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

class Empty extends StatelessWidget {
  final PaymentType filter;
  const Empty(this.filter);

  @override
  Widget build(BuildContext context) {
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
        Icon(MIcons.bubble_chart_line, color: Clrs.label, size: 35),
        SizedBox(height: 20),
        Text(message, style: Style.body.sm.clr(Clrs.label)),
        FlatButton(
          child: Text(
            Labels.addNewPayment.toUpperCase(),
            style: Style.body.secClr.ls.sm,
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
