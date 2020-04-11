import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    return Container(
      color: Color(0xff6156A4),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Observer(builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    opacity:
                        paymentsStore.filterBy == PaymentType.ALL ? 1 : 0.4,
                    child: GestureDetector(
                      onTap: () {
                        paymentsStore.changeFilter(PaymentType.ALL);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.lens,
                            size: 13,
                            color: Clrs.yellow,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'ALL',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Opacity(
                    opacity:
                        paymentsStore.filterBy == PaymentType.CREDIT ? 1 : 0.4,
                    child: GestureDetector(
                      onTap: () {
                        paymentsStore.changeFilter(PaymentType.CREDIT);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.lens,
                            size: 13,
                            color: Clrs.green,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'CREDIT',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Opacity(
                    opacity:
                        paymentsStore.filterBy == PaymentType.DEBIT ? 1 : 0.4,
                    child: GestureDetector(
                      onTap: () {
                        paymentsStore.changeFilter(PaymentType.DEBIT);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.lens,
                            size: 13,
                            color: Clrs.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'DEBIT',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
