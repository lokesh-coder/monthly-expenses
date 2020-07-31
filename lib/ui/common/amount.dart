import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/currency_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';

class Amount extends StatelessWidget {
  final dynamic value;
  final DisplaySize size;
  final AmountDisplayType type;
  final bool format;

  const Amount(
    this.value, {
    this.format = true,
    this.size = DisplaySize.SM,
    this.type = AmountDisplayType.CREDIT,
  });

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();

    final Color color = _colorMap()[type];
    final double fontSize = _fontSizeMap()[size];

    String displayText(currency) => format
        ? CurrencyHelper.getFormattedCurrency(value, currency)
        : value.toString();

    return Observer(
      builder: (context) {
        return Text(
          displayText(store.currency),
          style: Style.numeric.clr(color).fs(fontSize),
        );
      },
    );
  }

  Map<dynamic, double> _fontSizeMap() {
    return {
      DisplaySize.XS: FontSize.xs,
      DisplaySize.SM: FontSize.sm,
      DisplaySize.BASE: FontSize.base,
      DisplaySize.MD: FontSize.md,
      DisplaySize.LG: FontSize.lg,
      DisplaySize.XL: FontSize.xl,
    };
  }

  Map<dynamic, Color> _colorMap() {
    return {
      AmountDisplayType.CREDIT: Clrs.green,
      AmountDisplayType.DEBIT: Clrs.red,
      AmountDisplayType.INPUT: Clrs.dark,
      AmountDisplayType.PLACEHOLDER: Clrs.label,
      AmountDisplayType.SILENT: Colors.white.withOpacity(0.5),
    };
  }
}
