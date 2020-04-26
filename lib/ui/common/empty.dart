import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

class Empty extends StatelessWidget {
  const Empty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(MIcons.bubble_chart_line, color: Clrs.label, size: 35),
        SizedBox(height: 20),
        Text(
          Labels.noPaymentsFound,
          style: TextStyle(fontSize: 15, color: Clrs.label),
        ),
        FlatButton(
          child: Text(
            Labels.addNewPayment.toUpperCase(),
            style: TextStyle(
                color: Clrs.secondary, fontSize: 13, letterSpacing: -.5),
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
