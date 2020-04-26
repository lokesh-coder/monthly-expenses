import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/dimensions.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    return Container(
      height: Dimensions.filtersBarHeight,
      color: Clrs.primary,
      child: Observer(builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _item(
              paymentsStore,
              Labels.all.toUpperCase(),
              PaymentType.ALL,
              Clrs.yellow,
            ),
            _item(
              paymentsStore,
              Labels.credit.toUpperCase(),
              PaymentType.CREDIT,
              Clrs.green,
            ),
            _item(
              paymentsStore,
              Labels.debit.toUpperCase(),
              PaymentType.DEBIT,
              Clrs.red,
            ),
          ],
        );
      }),
    );
  }

  _item(
    PaymentsStore paymentsStore,
    String name,
    PaymentType type,
    Color color,
  ) {
    return Opacity(
      opacity: paymentsStore.filterBy == type ? 1 : 0.4,
      child: GestureDetector(
        onTap: () => paymentsStore.changeFilter(type),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.lens,
                size: 13,
                color: color,
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
