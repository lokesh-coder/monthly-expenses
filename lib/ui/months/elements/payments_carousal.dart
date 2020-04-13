import 'package:flutter/material.dart';
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
      ],
    );
  }
}
