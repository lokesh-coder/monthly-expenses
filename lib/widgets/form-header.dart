import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('title'),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: MonexColors.title.withOpacity(0.3),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.close),
              color: MonexColors.title.withOpacity(0.3),
              onPressed: () {
                sl<SandwichStore>().changeVisibility(false);
              }),
        ],
      ),
    );
  }
}
