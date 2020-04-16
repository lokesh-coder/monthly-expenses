import 'package:flutter/material.dart';
import 'package:monex/helpers/layout_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/header.dart';
import 'package:monex/ui/core/sandwich_container.dart';
import 'package:monex/ui/editor/editor.dart';
import 'package:monex/ui/months/months.dart';
import 'package:monex/widgets/banner-board.dart';
import 'package:monex/widgets/drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl<PaymentsStore>().fetchPayments();
    return AppShell(
      scaffoldKey: LayoutHelper.mainPageKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: AppDrawer(),
      ),
      header: Header(
        title: 'Montly expenses',
        leading: IconButton(
            onPressed: () {
              LayoutHelper.mainPageKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu)),
        action: IconButton(
            onPressed: () {
              sl<PaymentsStore>().setActivePayment(null);
              sl<SandwichStore>().changeVisibility(true);
            },
            icon: Icon(Icons.add)),
      ),
      onBackBtnPress: () {
        var store = sl<SandwichStore>();
        if (store.isOpen) {
          store.changeVisibility(false);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: SandwichContainer(
        bottomChild: Editor(),
        middleChild: Months(),
        topChild: BannerBoard(),
      ),
    );
  }
}
