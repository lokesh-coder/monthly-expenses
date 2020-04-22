import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/ui/common/fade_transition.dart';
import 'package:monex/ui/settings/elements/currency/page.dart';

class CurrencyEdit extends StatelessWidget {
  const CurrencyEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: CurrencyPage()),
          );
        },
        child: Text(
          'Change currency',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        elevation: 0,
        textColor: Clrs.secondary,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
          side: BorderSide(
            color: Clrs.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
