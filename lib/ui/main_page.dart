import "package:flutter/material.dart";
import "package:monex/helpers/layout_helper.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/payments/payments.store.dart";
import "package:monex/stores/sandwiich/sandwich.store.dart";
import "package:monex/ui/common/app-shell.dart";
import "package:monex/ui/core/sandwich_container.dart";
import "package:monex/ui/editor/editor.dart";
import "package:monex/ui/months/elements/banner-board.dart";
import "package:monex/ui/months/months.dart";

class MainPage extends StatelessWidget {
  const MainPage();

  @override
  Widget build(BuildContext context) {
    sl<PaymentsStore>().fetchPayments();
    return AppShell(
      scaffoldKey: LayoutHelper.mainPageKey,
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
