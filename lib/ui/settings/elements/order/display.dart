import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/sort_strategies.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class OrderDisplay extends StatelessWidget {
  final Map dataCtx;

  const OrderDisplay(this.dataCtx, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();
    var sorting = sl<DataRepo>().obj.get<SortStrategies>('sorting');

    return Observer(builder: (context) {
      var ss = sorting.findSortStrategyById(store.sortBy);
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: Icons.swap_vert,
        title: 'Payments display order',
        displayText: sorting.getOrderLabel(ss.id, store.orderBy),
      );
    });
  }
}