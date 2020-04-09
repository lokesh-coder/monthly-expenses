import 'package:flutter/material.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/paymens/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/widgets/payments.dart';

class PaymentsViewContainer extends StatelessWidget {
  final dynamic data;
  final int index;
  final PageController ctrl;

  const PaymentsViewContainer({Key key, this.index, this.data, this.ctrl})
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
