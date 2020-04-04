import 'package:flutter/material.dart';
import 'package:monex/widgets/filter-bar.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:monex/widgets/payments.dart';
import 'package:provider/provider.dart';

class PaymentsViewContainer extends StatelessWidget {
  final dynamic data;
  final int index;
  final PageController ctrl;

  const PaymentsViewContainer({Key key, this.index, this.data, this.ctrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sandwich = Provider.of<SandwichModel>(context, listen: false);
    return Column(
      children: <Widget>[
        // FilterBar(),
        Payments(),
        Text(
          data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          onPressed: () {
            sandwich.slideUp();
          },
          child: Text('move top'),
        ),
      ],
    );
  }
}
