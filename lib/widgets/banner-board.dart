import 'package:flutter/material.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/models/payments.model.dart';
import 'package:monex/widgets/filter-bar.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:monex/widgets/shared/amount.dart';
import 'package:monex/widgets/shared/percentage.dart';
import 'package:provider/provider.dart';

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
    PaymentsModel paymentsModel =
        Provider.of<PaymentsModel>(context, listen: true);
    List<Payment> monthlyPayments =
        paymentsModel.getPaymentsForMonth(paymentsModel.activeMonth);

    String monthName = DateUtil().getMonthName(paymentsModel.activeMonth);
    String year = DateUtil().getYear(paymentsModel.activeMonth);

    double remainingAmount = getTotal(monthlyPayments);

    return Container(
      child: Selector(
        selector: (ctx, SandwichModel model) => model.yDistance,
        builder: (ctx, val, child) {
          return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              AnimatedPositioned(
                top: 60 - (60 * val),
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  color: Color(0xff6156A4),
                  child: FilterBar(),
                ),
              ),
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
          );
        },
      ),
    );
  }
}
