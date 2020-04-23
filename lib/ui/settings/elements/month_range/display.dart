import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class MonthRangeDisplay extends StatelessWidget {
  final Map dataCtx;

  const MonthRangeDisplay(this.dataCtx, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();

    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: Icons.date_range,
        title: Labels.monthRange,
        displayText: '${store.monthsViewRange.toInt()} month(s)',
      );
    });
  }
}
