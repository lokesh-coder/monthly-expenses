import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class MonthRangeDisplay extends StatelessWidget {
  final Map dataCtx;

  const MonthRangeDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();

    return Observer(builder: (context) {
      var totalMonths = store.monthsViewRange.toInt();
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.calendar_line,
        title: Labels.monthRange,
        displayText: '$totalMonths month${totalMonths > 1 ? 's' : ''}',
      );
    });
  }
}
