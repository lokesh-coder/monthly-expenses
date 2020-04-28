import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';

class Amount extends StatelessWidget {
  final dynamic value;
  final DisplaySize size;
  final AmountDisplayType type;
  final bool format;

  const Amount(
    this.value, {
    Key key,
    this.format = true,
    this.size = DisplaySize.SM,
    this.type = AmountDisplayType.CREDIT,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();

    Color color = _colorMap()[type];
    double fontSize = _fontSizeMap()[size];

    String Function(String) displayText = (currency) => format
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
