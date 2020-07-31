import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/helpers/layout_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/ui/common/amount.dart';
import 'package:monthlyexp/ui/common/fade_transition.dart';
import 'package:monthlyexp/ui/common/hint.dart';
import 'package:monthlyexp/ui/months/elements/filter-bar.dart';
import 'package:monthlyexp/ui/months/elements/percentage.dart';
import 'package:monthlyexp/ui/settings/settings.dart';

class BannerBoard extends StatelessWidget {
  const BannerBoard();

  @override
  Widget build(BuildContext context) {
    final paymentsStore = sl<PaymentsStore>();
    final sandwichStore = sl<SandwichStore>();

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _FilterSection(),
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
                        children: [
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
                            final clr = Colors.white.withOpacity(0.3);
                            if (sandwichStore.isOpen) {
                              return Hint(
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
                            }

                            return Hint(
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

  AmountDisplayType _getType(PaymentsStore paymentsStore) {
    if (paymentsStore.totalAmountOfActiveMonth == 0) {
      return AmountDisplayType.SILENT;
    }
    return paymentsStore.totalAmountOfActiveMonth > 0
        ? AmountDisplayType.CREDIT
        : AmountDisplayType.DEBIT;
  }
}

class _FilterSection extends StatefulWidget {
  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<_FilterSection>
    with SingleTickerProviderStateMixin {
  final SandwichStore sandwichStore = sl<SandwichStore>();
  AnimationController controller;
  ReactionDisposer disposer;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    disposer = reaction((_) => sandwichStore.isOpen, (isOpen) {
      isOpen ? controller.forward() : controller.reverse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: Container(
          height: Dimensions.filtersBarHeight,
          width: LayoutHelper.screenWidth,
          child: FilterBar(),
        ),
        builder: (ctx, child) {
          final double bannerH = Dimensions.bannerBarHeight - 1;
          return Positioned(
            top: bannerH - (bannerH * controller.value),
            child: child,
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    disposer();
  }
}
