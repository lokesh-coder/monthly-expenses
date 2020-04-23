import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';

class DeleteAllEdit extends StatelessWidget {
  const DeleteAllEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getItem(),
    );
  }

  Widget _getItem() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        onPressed: () {
          sl<PaymentsStore>().dropDb();
        },
        child: Text(
          Labels.deleteForever,
          style: TextStyle(
            // color: Clrs.red,
            fontSize: 16,
          ),
        ),
        elevation: 0,
        textColor: Clrs.red,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
          side: BorderSide(
            color: Clrs.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
