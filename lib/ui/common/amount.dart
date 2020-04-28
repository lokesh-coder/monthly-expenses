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
    Color color = _getColor();

    double fontSize = _getFontSizeMap()[size];

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Observer(builder: (context) {
            var currency = store.currency;
            return Text(
              format
                  ? CurrencyHelper.getFormattedCurrency(value, currency)
                  : value.toString(),
              style: Style.numeric.clr(color).fs(fontSize),
            );
          }),
        ],
      ),
    );
  }

  Color _getColor() {
    Color color;
    switch (type) {
      case AmountDisplayType.CREDIT:
        color = Clrs.green;
        break;
      case AmountDisplayType.DEBIT:
        color = Clrs.red;
        break;
      case AmountDisplayType.INPUT:
        color = Clrs.dark;
        break;
      case AmountDisplayType.PLACEHOLDER:
        color = Clrs.label;
        break;
      case AmountDisplayType.SILENT:
        color = Colors.white.withOpacity(0.5);
        break;
      default:
        color = Clrs.primary;
    }
    return color;
  }

  Map<dynamic, double> _getFontSizeMap() {
    return {
      DisplaySize.XS: FontSize.xs,
      DisplaySize.SM: FontSize.sm,
      DisplaySize.BASE: FontSize.base,
      DisplaySize.MD: FontSize.md,
      DisplaySize.LG: FontSize.lg,
    };
  }
}
