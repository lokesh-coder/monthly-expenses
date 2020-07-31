import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/settings/elements/item_tile.dart';

class MonthRangeDisplay extends StatelessWidget {
  final Map dataCtx;

  const MonthRangeDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();

    return Observer(builder: (context) {
      final totalMonths = store.monthsViewRange.toInt();
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.calendar_line,
        title: Labels.monthRange,
        displayText: '$totalMonths month${totalMonths > 1 ? 's' : ''}',
      );
    });
  }
}
