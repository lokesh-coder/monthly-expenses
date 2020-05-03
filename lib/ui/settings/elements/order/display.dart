import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/sort_strategies.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class OrderDisplay extends StatelessWidget {
  final Map dataCtx;

  const OrderDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final store = sl<SettingsStore>();
    final sorting = sl<DataRepo>().obj.get<SortStrategies>('sorting');

    return Observer(builder: (context) {
      final ss = sorting.findSortStrategyById(store.sortBy);
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.line_height,
        title: Labels.displayOrder,
        displayText: sorting.getOrderLabel(ss.id, store.orderBy),
      );
    });
  }
}
