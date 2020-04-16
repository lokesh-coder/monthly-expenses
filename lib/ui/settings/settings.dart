import 'package:flutter/material.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/expander.dart';
import 'package:monex/ui/common/header.dart';

import 'elements/month_range/display.dart';
import 'elements/month_range/edit.dart';

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
        children: [
          Expander(
            headBuilder: (_, dataCtx) => MonthRangeDisplay(dataCtx),
            bodyBuilder: (_, __) => MonthRangeEdit(),
          ),
        ],
      ),
    );
  }
}
