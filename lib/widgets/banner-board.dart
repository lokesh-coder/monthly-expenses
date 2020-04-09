import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/stores/paymens/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/widgets/filter-bar.dart';
import 'package:monex/widgets/shared/amount.dart';
import 'package:monex/widgets/shared/percentage.dart';

class BannerBoard extends StatelessWidget {
  final int index;
  final dynamic data;
  final PageController ctrl;

  const BannerBoard(this.index, this.data, this.ctrl, {Key key})
      : super(key: key);

  getTotal(List<Payment> payments) {
    if (payments == null) return 0.0;
    return payments
        .map((x) => x.isCredit ? x.amount : -(x.amount))
        .reduce((v, e) => v + e);
  }

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    List<Payment> monthlyPayments =
        paymentsStore.getPaymentsForMonth(paymentsStore.activeMonth);

    String monthName = DateUtil().getMonthName(paymentsStore.activeMonth);
    String year = DateUtil().getYear(paymentsStore.activeMonth);

    double remainingAmount = getTotal(monthlyPayments);

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Observer(builder: (context) {
            double offset = sl<SandwichStore>().topOffset;
            return AnimatedPositioned(
              top: 60 - (60 * offset),
              duration: Duration(milliseconds: 200),
              curve: Curves.decelerate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Color(0xff6156A4),
                child: FilterBar(),
              ),
            );
          }),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Color(0xff6156A4),
            child: Row(
              children: <Widget>[
                Percentage(value: 33),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      year,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white30,
                      ),
                    ),
                    Text(
                      monthName,
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
                    value: remainingAmount.abs(),
                    isCredit: remainingAmount >= 0,
                    size: AmountSize.LG,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
