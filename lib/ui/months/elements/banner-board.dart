import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/dimensions.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/m_icons.dart";
import "package:monex/config/typography.dart";
import "package:monex/helpers/date_helper.dart";
import "package:monex/helpers/layout_helper.dart";
import "package:monex/models/enums.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/payments/payments.store.dart";
import "package:monex/stores/sandwiich/sandwich.store.dart";
import "package:monex/ui/common/amount.dart";
import "package:monex/ui/common/fade_transition.dart";
import "package:monex/ui/common/hint.dart";
import "package:monex/ui/months/elements/filter-bar.dart";
import "package:monex/ui/months/elements/percentage.dart";
import "package:monex/ui/settings/settings.dart";

class BannerBoard extends StatelessWidget {
  const BannerBoard();

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    var sandwichStore = sl<SandwichStore>();

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Observer(
            builder: (context) {
              double offset = sandwichStore.topOffset;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Percentage(33),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Amount(
                            paymentsStore.totalAmountOfActiveMonth.abs(),
                            type: _getType(paymentsStore),
                            size: DisplaySize.LG,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                DateHelper.getMonthName(
                                    paymentsStore.activeMonth),
                                style: Style.body.bodyAltClr.bold,
                              ),
                              SizedBox(width: 5),
                              Text(
                                DateHelper.getYear(paymentsStore.activeMonth),
                                style: Style.body.bodyAltClr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Hint(
                          Labels.goToSettings,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                FadeRoute(Settings()),
                              );
                            },
                            color: Colors.white.withOpacity(0.3),
                            icon: Icon(MIcons.settings_3_line, size: 27),
                          ),
                        ),
                        Observer(
                          builder: (context) {
                            var clr = Colors.white.withOpacity(0.3);
                            Widget openIcon = Hint(
                              Labels.goToEditor,
                              child: IconButton(
                                onPressed: () {
                                  paymentsStore.setActivePayment(null);
                                  sandwichStore.changeVisibility(true);
                                },
                                color: clr,
                                icon: Icon(MIcons.add_line, size: 29),
                              ),
                            );

                            Widget closeIcon = Hint(
                              Labels.closeEditor,
                              child: IconButton(
                                onPressed: () {
                                  paymentsStore.setActivePayment(null);
                                  sandwichStore.changeVisibility(false);
                                },
                                color: clr,
                                icon: Icon(MIcons.close_line, size: 29),
                              ),
                            );
                            return sandwichStore.isOpen ? closeIcon : openIcon;
                          },
                        ),
                      ],
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

  _getType(PaymentsStore paymentsStore) {
    if (paymentsStore.totalAmountOfActiveMonth == 0) {
      return AmountDisplayType.SILENT;
    }
    return paymentsStore.totalAmountOfActiveMonth > 0
        ? AmountDisplayType.CREDIT
        : AmountDisplayType.DEBIT;
  }
}
