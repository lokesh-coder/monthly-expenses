import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/currency_helper.dart';
import 'package:monthlyexp/models/currency.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/check.dart';
import 'package:monthlyexp/ui/common/header.dart';
import 'package:provider/provider.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final store = sl<SettingsStore>();
    return AppShell(
      header: Header(
        title: Labels.chooseCurrency,
        leading: Container(),
      ),
      child: Container(child: _getItem(store, theme, context)),
    );
  }

  Widget _getItem(SettingsStore store, AppTheme theme, BuildContext context) {
    final currencies = CurrencyHelper.all();

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: currencies.length,
      itemBuilder: (ctx, index) {
        final x = currencies[index];
        final checked = store.currency == _getCurrencyTag(x) ? Check() : null;
        return ListTile(
          title: Text(x.currencyName, style: Style.body.clr(theme.textHeading)),
          leading: Text(x.currencySymbol, style: Style.body.clr(theme.violet)),
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
