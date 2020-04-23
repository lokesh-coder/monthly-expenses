import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/ui/settings/elements/item_tile.dart';

class DeleteAllDisplay extends StatelessWidget {
  final Map dataCtx;

  const DeleteAllDisplay(this.dataCtx, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = sl<PaymentsStore>();
    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: Icons.delete_sweep,
        title: 'Delete all records',
        displayText: 'There are ${store.payments.length} records',
      );
    });
  }
}
