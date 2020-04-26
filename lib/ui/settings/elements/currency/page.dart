import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/currency.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/check.dart';
import 'package:monex/ui/common/header.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();
    return AppShell(
      header: Header(
        title: Labels.chooseCurrency,
        action: IconButton(
          icon: Icon(MIcons.close_circle_line),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leading: Container(),
      ),
      child: Container(
        child: _getItem(store, context),
      ),
    );
  }

  Widget _getItem(SettingsStore store, BuildContext context) {
    var currcncies = CurrencyHelper.all();
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: currcncies.length,
      itemBuilder: (ctx, index) {
        var x = currcncies[index];
        var checked = store.currency == _getCurrencyTag(x) ? Check() : null;
        return ListTile(
          title: Text(x.currencyName),
          leading: Text(
            x.currencySymbol,
            style: TextStyle(
              fontSize: 18,
              color: Clrs.secondary,
            ),
          ),
          trailing: checked,
          onTap: () {
            store.changeCurrency(x.locale, x.currencyCode);
            Navigator.of(context).pop();
          },
        );
      },
      separatorBuilder: (ctx, index) => Divider(
        height: 0,
      ),
    );
  }

  String _getCurrencyTag(Currency currency) {
    return '${currency.locale}=${currency.currencyCode}';
  }
}
