import 'package:flutter/material.dart';
import 'package:monthlyexp/helpers/layout_helper.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/core/sandwich_container.dart';
import 'package:monthlyexp/ui/editor/editor.dart';
import 'package:monthlyexp/ui/months/elements/banner-board.dart';
import 'package:monthlyexp/ui/months/months.dart';

class MainPage extends StatelessWidget {
  const MainPage();

  @override
  Widget build(BuildContext context) {
    sl<PaymentsStore>().fetchPayments();
    return AppShell(
      scaffoldKey: LayoutHelper.mainPageKey,
      onBackBtnPress: () {
        final store = sl<SandwichStore>();
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
