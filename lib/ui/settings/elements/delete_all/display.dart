import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/ui/settings/elements/item_tile.dart';

class DeleteAllDisplay extends StatelessWidget {
  final Map dataCtx;

  const DeleteAllDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final PaymentsStore store = sl<PaymentsStore>();
    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.delete_bin_2_line,
        title: Labels.deleteAll,
        displayText: '${Labels.totalRecords} ${store.payments.length}',
      );
    });
  }
}
