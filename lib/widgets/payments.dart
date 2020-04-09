import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/data/categories.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/stores/paymens/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

class Payments extends StatelessWidget {
  final Map data;
  const Payments(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Color(0xff7E93B2),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    var paymentsStore = sl<PaymentsStore>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Observer(
        builder: (context) {
          String monthKeyName =
              DateUtil().getUniqueMonthFormat(data['dateTime']);
          List payments = paymentsStore.paymentsByMonth[monthKeyName];
          return ListView.separated(
            itemCount: payments == null ? 0 : payments.length,
            separatorBuilder: (_, __) {
              return Divider(
                height: 1,
              );
            },
            itemBuilder: (_, index) {
              Payment data = payments[index];
              List category =
                  CatagoriesList().findCategoryById(data.categoryID);
              return Card(
                elevation: 0,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  leading: Image.asset(
                    category[0],
                    width: 35,
                  ),
                  onTap: () {
                    paymentsStore.setActivePayment(data.id);
                    sl<SandwichStore>().changeVisibility(true);
                  },
                  title: Text(
                    data.label,
                    style: style,
                  ),
                  subtitle: Text(
                    category[1].toString().toUpperCase(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    data.amount.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: data.isCredit
                            ? MonexColors.green
                            : MonexColors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
