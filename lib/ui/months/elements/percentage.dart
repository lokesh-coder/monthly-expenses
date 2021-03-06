import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class Percentage extends StatelessWidget {
  final double value;

  const Percentage(this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final PaymentsStore paymentsStore = sl<PaymentsStore>();

    return Observer(builder: (context) {
      final List data = _data(paymentsStore.inOutStatement);
      final String displayValue =
          '${(_getValue(data[0], data[1]) * 100).round()}%';

      return CircularPercentIndicator(
        radius: Dimensions.percentageDisplayRad,
        lineWidth: Dimensions.percentageDisplayStroke,
        percent: _getValue(data[0], data[1]),
        animation: true,
        animationDuration: 200,
        center:
            Text(displayValue, style: Style.body.xs.clr(theme.textSubHeading)),
        progressColor: data[2] == PaymentType.CREDIT ? theme.green : theme.red,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: theme.textPrimarySubHeading.withOpacity(0.3),
      );
    });
  }

  List _data(Map data) {
    final num total = data['credit'] + data['debit'];
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
    if (total == 0) {
      return 0.0;
    }
    return value / total;
  }
}
