import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/sort_strategies.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/settings/elements/item_tile.dart';

class SortDisplay extends StatelessWidget {
  final Map dataCtx;

  const SortDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();
    final sorting = sl<DataRepo>().obj.get<SortStrategies>('sorting');

    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.filter_3_line,
        title: Labels.sortPayments,
        displayText: sorting.findSortStrategyById(store.sortBy).name,
      );
    });
  }
}
