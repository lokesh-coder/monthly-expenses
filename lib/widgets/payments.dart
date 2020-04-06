import 'package:flutter/material.dart';
import 'package:monex/data/categories.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/models/payments.model.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:provider/provider.dart';

class Payments extends StatelessWidget {
  final Map data;
  const Payments(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sandwich = Provider.of<SandwichModel>(context, listen: false);

    var style = TextStyle(
      color: Color(0xff7E93B2),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Consumer<PaymentsModel>(
        builder: (context, paymentsModel, child) {
          String monthKeyName =
              DateUtil().getUniqueMonthFormat(data['dateTime']);
          List payments = paymentsModel.paymentsByMonth[monthKeyName];
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
                    width: 40,
                  ),
                  onTap: () {
                    paymentsModel.setActivePayment(data.id);
                    sandwich.slideUp();
                  },
                  title: Text(
                    data.label,
                    style: style,
                  ),
                  subtitle: Text(
                    category[1],
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(data.amount.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
