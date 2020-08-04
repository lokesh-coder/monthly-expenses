import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/currency_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:provider/provider.dart';

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
    final theme = Provider.of<ThemeChanger>(context).theme;

    final Color color = _colorMap(theme)[type];
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

  Map<dynamic, Color> _colorMap(AppTheme theme) {
    return {
      AmountDisplayType.CREDIT: theme.green,
      AmountDisplayType.DEBIT: theme.red,
      AmountDisplayType.INPUT: theme.textHeading,
      AmountDisplayType.PLACEHOLDER:
          theme.textPrimarySubHeading.withOpacity(0.3),
      AmountDisplayType.SILENT: theme.textPrimarySubHeading.withOpacity(0.3),
    };
  }
}
