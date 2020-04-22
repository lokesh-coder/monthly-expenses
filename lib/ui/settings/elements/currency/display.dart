import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class CurrencyDisplay extends StatelessWidget {
  final Map dataCtx;

  const CurrencyDisplay(this.dataCtx, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();
    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: Icons.attach_money,
        title: 'Choose currency',
        displayText: CurrencyHelper.getCurrency(store.currency).currencyName,
      );
    });
  }
}
