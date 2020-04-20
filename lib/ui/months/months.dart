import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/dimensions.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/core/pager.dart';
import 'package:monex/ui/months/elements/months_carousal.dart';
import 'package:monex/ui/months/elements/payments_carousal.dart';

class Months extends StatelessWidget {
  const Months({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settingsStore = sl<SettingsStore>();

    return Observer(builder: (context) {
      var totalMonths =
          () => DateHelper.getMonthRange(settingsStore.monthsViewRange);
      if (settingsStore.monthsViewRange == 0) {
        return SizedBox.shrink();
      }
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Pager(
              builder: (int index, dynamic data, PageController ctrl) {
                return PaymentsCarousal(
                  index: index,
                  data: data,
                  ctrl: ctrl,
                );
              },
              data: totalMonths(),
              initialPage: settingsStore.monthsViewRange,
              visibleItems: 1,
              onPageChange: (curr) {},
            ),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: GestureDetector(
              onPanUpdate: (d) {
                sl<SandwichStore>().changeVisibility(true);
              },
              child: Container(
                height: 7,
                width: 40,
                color: Clrs.label,
              ),
            ),
          ),
          Container(
            height: Dimensions.monthsBarHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Clrs.inputBorder),
                top: BorderSide(color: Clrs.inputBorder),
              ),
            ),
            child: Pager.master(
              builder: (int index, dynamic data, PageController ctrl) {
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
