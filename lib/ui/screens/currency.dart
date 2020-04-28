import 'package:flutter/material.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/currency.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/check.dart';
import 'package:monex/ui/common/header.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen();

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();
    return AppShell(
      header: Header(
        title: Labels.chooseCurrency,
        leading: Container(),
      ),
      child: Container(child: _getItem(store, context)),
    );
  }

  Widget _getItem(SettingsStore store, BuildContext context) {
    var currencies = CurrencyHelper.all();

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: currencies.length,
      itemBuilder: (ctx, index) {
        var x = currencies[index];
        var checked = store.currency == _getCurrencyTag(x) ? Check() : null;
        return ListTile(
          title: Text(x.currencyName, style: Style.body),
          leading: Text(x.currencySymbol, style: Style.body.secClr),
          trailing: checked,
          onTap: () {
            store.changeCurrency(x.locale, x.currencyCode);
            Navigator.of(context).pop();
          },
        );
      },
      separatorBuilder: (ctx, index) => Divider(height: 0),
    );
  }

  String _getCurrencyTag(Currency currency) {
    return '${currency.locale}=${currency.currencyCode}';
  }
}
