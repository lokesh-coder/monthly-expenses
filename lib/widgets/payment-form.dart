import 'package:flutter/material.dart';
import 'package:monex/widgets/shared/button.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text('form'),
          ),
          Button(
            label: 'add entry',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
