import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Percentage extends StatelessWidget {
  final double value;

  const Percentage({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentsStore paymentsStore = sl<PaymentsStore>();

    return Observer(builder: (context) {
      List data = _data(paymentsStore.inOutStatement);
      return CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 3.0,
        percent: _getValue(data[0], data[1]),
        animation: true,
        animationDuration: 200,
        center: new Text(
          "${(_getValue(data[0], data[1]) * 100).round()}%",
          style: TextStyle(fontSize: 12, color: Colors.white38),
        ),
        progressColor: data[2] == PaymentType.CREDIT ? Clrs.green : Clrs.red,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.white12,
      );
    });
  }

  _data(Map data) {
    num total = data['credit'] + data['debit'];
    num scale;
    PaymentType type;

    if (data['activeType'] == PaymentType.ALL) {
      scale = data['credit'] - data['debit'];
      type = scale >= 0 ? PaymentType.CREDIT : PaymentType.DEBIT;
    }
    if (data['activeType'] == PaymentType.CREDIT) {
      scale = data['credit'];
      type = PaymentType.CREDIT;
    }
    if (data['activeType'] == PaymentType.DEBIT) {
      scale = data['debit'];
      type = PaymentType.DEBIT;
    }
    return [scale.abs(), total, type];
  }

  double _getValue(num value, num total) {
    if (total == 0) return 0.0;
    return (value / total);
  }
}
