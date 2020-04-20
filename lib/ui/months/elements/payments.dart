import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/category.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/amount.dart';

class Payments extends StatelessWidget {
  final Map data;
  const Payments(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    String monthKeyName = DateHelper.getMonthYear(data['dateTime']);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Observer(
        builder: (context) {
          List payments = paymentsStore.paymentsByMonth[monthKeyName];
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: payments == null ? 0 : payments.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (_, index) => _payment(payments[index], paymentsStore),
          );
        },
      ),
    );
  }

  _payment(Payment data, PaymentsStore paymentsStore) {
    Category category = sl<DataRepo>()
        .obj
        .get<Catagories>('categories')
        .findCategoryById(data.categoryID);

    var style = TextStyle(
      color: Clrs.dark.withOpacity(0.8),
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.6,
    );

    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Image.asset(
          category.path,
          width: 30,
        ),
        onTap: () {
          paymentsStore.setActivePayment(data.id);
          sl<SandwichStore>().changeVisibility(true);
        },
        title: Text(data.label, style: style),
        subtitle: Text(
          category.name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Clrs.label,
          ),
        ),
        trailing: Amount(
          data.amount,
          type: data.isCredit
              ? AmountDisplayType.CREDIT
              : AmountDisplayType.DEBIT,
        ),
      ),
    );
  }
}
