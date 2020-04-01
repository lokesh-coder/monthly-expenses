import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:provider/provider.dart';

import 'modules/sandwich/model.dart';

class Editor extends StatelessWidget {
  final VoidCallback onClose;

  const Editor({Key key, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sandwich = Provider.of<SandwichModel>(context, listen: false);
    return Container(
      color: MonexColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: FlatButton(
              onPressed: () {
                sandwich.slideDown();
              },
              child: Text('close'),
            ),
          )
        ],
      ),
    );
  }
}
