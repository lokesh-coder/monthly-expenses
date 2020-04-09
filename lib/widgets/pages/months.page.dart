import 'package:flutter/material.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/paymens/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/widgets/banner-board.dart';
import 'package:monex/widgets/containers/month-view.container.dart';
import 'package:monex/widgets/drawer.dart';
import 'package:monex/widgets/editor.dart';
import 'package:monex/widgets/modules/sandwich/sandwich.dart';
import 'package:monex/widgets/shared/app-shell.dart';
import 'package:monex/widgets/shared/header.dart';

class MonthsPage extends StatelessWidget {
  const MonthsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl<PaymentsStore>().fetchPayments();
    return AppShell(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: AppDrawer(),
      ),
      header: Header(
        title:
            Text('monthly expences', style: TextStyle(color: Colors.white70)),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        action: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ),
      onBackBtnPress: () {
        var store = sl<SandwichStore>();
        if (store.isOpen) {
          store.changeVisibility(false);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Sandwich(
        safeHeight: MediaQuery.of(context).padding.top,
        translateOffset: 80.0,
        dynamicContent: 40.0,
        visibleContentHeight: 60.0,
        bottomChild: Editor(),
        middleChild: MonthViewContainer(),
        topChild: BannerBoard(0, [], PageController()),
      ),
    );
  }
}
