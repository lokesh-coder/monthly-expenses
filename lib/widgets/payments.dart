import 'package:flutter/material.dart';
import 'package:monex/data/categories.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/models/payments.model.dart';
import 'package:provider/provider.dart';

class Payments extends StatelessWidget {
  const Payments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentsModel _paymentsModel =
        Provider.of<PaymentsModel>(context, listen: false);

    var style = TextStyle(
      color: Color(0xff7E93B2),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Container(
      // color: Color(0xffF2F3F7),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Consumer<PaymentsModel>(
        builder: (context, paymentsModel, child) {
          List payments = paymentsModel.payments;
          return ListView.separated(
            itemCount: payments.length,
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
                // color: MonexColors.card,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  leading: Image.asset(
                    category[0],
                    width: 40,
                  ),
                  onTap: () {
                    _paymentsModel.fetchPayments();
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
