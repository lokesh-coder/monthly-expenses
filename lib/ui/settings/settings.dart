import 'package:flutter/material.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/expander.dart';
import 'package:monex/ui/common/header.dart';

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
        title: 'Settings',
        action: IconButton(icon: Icon(Icons.close), onPressed: () {}),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
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
        ],
      ),
    );
  }
}
