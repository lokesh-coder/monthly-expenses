import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/categories.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/models/category.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/models/payment.model.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/ui/common/amount.dart';
import 'package:monthlyexp/config/extension.dart';
import 'package:monthlyexp/ui/common/empty.dart';
import 'package:monthlyexp/ui/common/loader.dart';

class Payments extends StatelessWidget {
  final Map data;
  const Payments(this.data);

  @override
  Widget build(BuildContext context) {
    final paymentsStore = sl<PaymentsStore>();
    final String monthKeyName = DateHelper.getMonthYear(data['dateTime']);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Observer(
        builder: (context) {
          if (paymentsStore.isLoading) {
            return Center(child: Loader());
          }
          final List payments = paymentsStore.paymentsByMonth[monthKeyName];
          if (payments == null || payments.isEmpty) {
            return Center(child: Empty(paymentsStore.filterBy));
          }
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: payments == null ? 0 : payments.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (_, index) => _Payment(payments[index], onTap: _onTap),
          );
        },
      ),
    );
  }

  void _onTap(String paymentID) {
    sl<PaymentsStore>().setActivePayment(paymentID);
    sl<SandwichStore>().changeVisibility(true);
  }
}

class _Payment extends StatelessWidget {
  final Payment data;
  final Function onTap;
  const _Payment(this.data, {this.onTap});

  @override
  Widget build(BuildContext context) {
    final dt = DateHelper.msToDt(data.date);
    final date = DateHelper.format(dt, DateHelper.dateWeekdayP);

    final Category category = sl<DataRepo>()
        .obj
        .get<Catagories>('categories')
        .findCategoryById(data.categoryID);

    return ListTile(
      key: ValueKey(data.label),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Image.asset(category.path, width: 30),
      onTap: () => onTap(data.id),
      title: Text(data.label.capitalize(), style: Style.heading),
      subtitle: Text(
        [category.name, date].join('  ·  ').toUpperCase(),
        style: Style.label,
      ),
      trailing: Amount(
        data.amount,
        size: DisplaySize.BASE,
        type:
            data.isCredit ? AmountDisplayType.CREDIT : AmountDisplayType.DEBIT,
      ),
    );
  }
}
