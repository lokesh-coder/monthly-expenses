import 'package:flutter/material.dart';
import 'package:monex/ui/months/elements/payments.dart';

class PaymentsCarousal extends StatelessWidget {
  final dynamic data;
  final int index;
  final PageController ctrl;

  const PaymentsCarousal({this.index, this.data, this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: Payments(data))]);
  }
}
