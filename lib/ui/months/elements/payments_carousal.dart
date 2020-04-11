import 'package:flutter/material.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/months/elements/payments.dart';

class PaymentsCarousal extends StatelessWidget {
  final dynamic data;
  final int index;
  final PageController ctrl;

  const PaymentsCarousal({Key key, this.index, this.data, this.ctrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: Payments(data)),
        Text(
          data['monthName'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          onPressed: () {
            sl<PaymentsStore>().setActivePayment(null);
            sl<SandwichStore>().changeVisibility(true);
          },
          child: Text('move top'),
        ),
      ],
    );
  }
}
