import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/dimensions.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/helpers/layout_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/amount.dart';
import 'package:monex/widgets/filter-bar.dart';
import 'package:monex/widgets/shared/percentage.dart';

class BannerBoard extends StatelessWidget {
  const BannerBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Observer(
            builder: (context) {
              double offset = sl<SandwichStore>().topOffset;
              double bannerH = Dimensions.bannerBarHeight - 1;
              return AnimatedPositioned(
                top: bannerH - (bannerH * offset),
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate,
                child: Container(
                  height: Dimensions.filtersBarHeight,
                  width: LayoutHelper.screenWidth,
                  child: FilterBar(),
                ),
              );
            },
          ),
          Observer(
            builder: (context) {
              return Container(
                height: Dimensions.bannerBarHeight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Clrs.primary,
                child: Row(
                  children: <Widget>[
                    Percentage(value: 33),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateHelper.getYear(paymentsStore.activeMonth),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white30,
                          ),
                        ),
                        Text(
                          DateHelper.getMonthName(paymentsStore.activeMonth),
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white30,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Amount(
                        value: paymentsStore.totalAmountOfActiveMonth.abs(),
                        isCredit: paymentsStore.totalAmountOfActiveMonth >= 0,
                        size: AmountSize.LG,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
