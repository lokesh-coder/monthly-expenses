import 'package:flutter/material.dart';
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
      child: SingleChildScrollView(
        child: Consumer<PaymentsModel>(
          builder: (context, paymentsModel, child) {
            print('==> ${paymentsModel.payments}');
            return Column(
              children: <Widget>[
                Card(
                  elevation: 0,
                  // color: MonexColors.card,
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    leading: Image.asset(
                      'assets/icons/icons8-beetroot-and-carrot-100.png',
                      width: 40,
                    ),
                    onTap: () {
                      _paymentsModel.fetchPayments();
                    },
                    title: Text(
                      'Vegetables',
                      style: style,
                    ),
                    subtitle: Text(
                      'GROCERIES',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      '14000',
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {
                      _paymentsModel.seed();
                    },
                    leading: Image.asset(
                      'assets/icons/icons8-check-for-payment-100.png',
                      width: 40,
                    ),
                    title: Text(
                      'HDFC personal loan',
                      style: style,
                    ),
                    subtitle: Text(
                      'BANKING',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      '14000',
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {},
                    leading: Image.asset(
                      'assets/icons/icons8-cinema-100.png',
                      width: 40,
                    ),
                    subtitle: Text(
                      'ENTERTAINMENT',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    title: Text(
                      'Netflix subscription',
                      style: style,
                    ),
                    trailing: Text('14000'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
