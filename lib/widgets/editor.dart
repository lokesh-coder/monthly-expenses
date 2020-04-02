import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/widgets/form-header.dart';
import 'package:monex/widgets/payment-form.dart';
import 'package:provider/provider.dart';

import 'modules/sandwich/model.dart';

class Editor extends StatelessWidget {
  final VoidCallback onClose;

  const Editor({Key key, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sandwich = Provider.of<SandwichModel>(context, listen: false);
    return Container(
      color: MonexColors.light.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormHeader(),
          Expanded(
            child: PaymentForm(),
          ),
        ],
      ),
    );
  }
}
