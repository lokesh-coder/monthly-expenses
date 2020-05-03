import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class CurrencyDisplay extends StatelessWidget {
  final Map dataCtx;

  const CurrencyDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final SettingsStore store = sl<SettingsStore>();
    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.money_dollar_circle_line,
        title: Labels.chooseCurrency,
        displayText: CurrencyHelper.getCurrency(store.currency).currencyName,
      );
    });
  }
}
