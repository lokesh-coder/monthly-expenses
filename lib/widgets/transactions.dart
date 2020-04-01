import 'package:flutter/material.dart';
import 'package:monex/widgets/filter-bar.dart';
import 'package:monex/widgets/ledger.dart';
import 'package:provider/provider.dart';

import 'modules/sandwich/model.dart';

class Transactions extends StatelessWidget {
  final dynamic data;
  final int index;
  final PageController ctrl;

  const Transactions({Key key, this.index, this.data, this.ctrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sandwich = Provider.of<SandwichModel>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FilterBar(),
          Ledger(),
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
      ),
    );
  }
}
