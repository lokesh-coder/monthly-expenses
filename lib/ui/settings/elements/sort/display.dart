import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/m_icons.dart";
import "package:monex/data/data_repository.dart";
import "package:monex/data/local/object/files/sort_strategies.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/settings/settings.store.dart";
import "package:monex/ui/settings/elements/item_tile.dart";

class SortDisplay extends StatelessWidget {
  final Map dataCtx;

  const SortDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    var store = sl<SettingsStore>();
    var sorting = sl<DataRepo>().obj.get<SortStrategies>("sorting");

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
