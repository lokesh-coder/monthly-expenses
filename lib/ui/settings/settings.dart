import 'package:flutter/material.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/expander.dart';
import 'package:monex/ui/common/header.dart';
import 'package:monex/ui/settings/elements/delete_all/edit.dart';

import 'elements/currency/display.dart';
import 'elements/currency/edit.dart';
import 'elements/delete_all/display.dart';
import 'elements/month_range/display.dart';
import 'elements/month_range/edit.dart';
import 'elements/order/display.dart';
import 'elements/order/edit.dart';
import 'elements/sort/display.dart';
import 'elements/sort/edit.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      header: Header(
        leading: Container(),
        title: 'Settings',
        action: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // FlatButton(
          //     onPressed: () => sl<PaymentsStore>().seed(),
          //     child: Text('load data')),
          Expander(
            headBuilder: (_, dataCtx) => MonthRangeDisplay(dataCtx),
            bodyBuilder: (_, __) => MonthRangeEdit(),
          ),
          Expander(
            headBuilder: (_, dataCtx) => SortDisplay(dataCtx),
            bodyBuilder: (_, __) => SortEdit(),
          ),
          Expander(
            headBuilder: (_, dataCtx) => OrderDisplay(dataCtx),
            bodyBuilder: (_, __) => OrderEdit(),
          ),
          Expander(
            headBuilder: (_, dataCtx) => CurrencyDisplay(dataCtx),
            bodyBuilder: (_, __) => CurrencyEdit(),
          ),
          Expander(
            headBuilder: (_, dataCtx) => DeleteAllDisplay(dataCtx),
            bodyBuilder: (_, __) => DeleteAllEdit(),
          ),
        ],
      ),
    );
  }
}
