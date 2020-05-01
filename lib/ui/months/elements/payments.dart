import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/category.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/amount.dart';
import "package:monex/config/extension.dart";
import 'package:monex/ui/common/empty.dart';
import 'package:monex/ui/common/loader.dart';

class Payments extends StatelessWidget {
  final Map data;
  const Payments(this.data);

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    String monthKeyName = DateHelper.getMonthYear(data['dateTime']);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Observer(
        builder: (context) {
          if (paymentsStore.isLoading) {
            return Center(child: Loader());
          }
          List payments = paymentsStore.paymentsByMonth[monthKeyName];
          if (payments == null || payments.isEmpty) {
            return Center(child: Empty(paymentsStore.filterBy));
          }
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

    var dt = DateHelper.msToDt(data.date);
    var date = DateHelper.format(dt, DateHelper.dateWeekdayP);

    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Image.asset(
          category.path,
          width: 30,
          cacheWidth: 30,
        ),
        onTap: () {
          paymentsStore.setActivePayment(data.id);
          sl<SandwichStore>().changeVisibility(true);
        },
        title: Text(data.label.capitalize(), style: Style.heading),
        subtitle: Text(
          '${category.name}  ·  $date'.toUpperCase(),
          style: Style.label,
        ),
        trailing: Amount(
          data.amount,
          size: DisplaySize.BASE,
          type: data.isCredit
              ? AmountDisplayType.CREDIT
              : AmountDisplayType.DEBIT,
        ),
      ),
    );
  }
}
