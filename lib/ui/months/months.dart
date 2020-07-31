import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/core/pager.dart';
import 'package:monthlyexp/ui/months/elements/months_carousal.dart';
import 'package:monthlyexp/ui/months/elements/payments_carousal.dart';

class Months extends StatelessWidget {
  const Months();

  @override
  Widget build(BuildContext context) {
    final settingsStore = sl<SettingsStore>();

    return Observer(builder: (context) {
      final range = settingsStore.monthsViewRange;
      List totalMonths() => DateHelper.getAllMonthsInRange(range);

      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Pager(
              builder: (int index, Map data, PageController ctrl) {
                return PaymentsCarousal(index: index, data: data, ctrl: ctrl);
              },
              data: totalMonths(),
              initialPage: range,
              visibleItems: 1,
              onPageChange: (curr) {},
            ),
          ),
          GestureDetector(
            onPanUpdate: (d) {
              sl<PaymentsStore>().setActivePayment(null);
              sl<SandwichStore>().changeVisibility(true);
            },
            child: Container(
              height: 20,
              width: 40,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Clrs.label.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: Dimensions.monthsBarHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Clrs.border),
                top: BorderSide(color: Clrs.border),
              ),
            ),
            child: Pager.master(
              builder: (int index, Map data, PageController ctrl) {
                return MonthsCarousal(index, data, ctrl);
              },
              data: totalMonths(),
              initialPage: settingsStore.monthsViewRange,
              visibleItems: 4,
              onPageChange: (curr) {
                sl<PaymentsStore>().setActiveMonth(curr['dateTime']);
              },
            ),
          )
        ],
      );
    });
  }
}
