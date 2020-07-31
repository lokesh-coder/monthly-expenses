import 'package:flutter/material.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/ui/common/fade_transition.dart';
import 'package:monthlyexp/ui/screens/currency.dart';

class CurrencyEdit extends StatelessWidget {
  const CurrencyEdit();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(CurrencyScreen()));
        },
        child: Text(
          Labels.changeCurrency,
          style: Style.body.secClr,
        ),
        elevation: 0,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Clrs.secondary, width: 2),
        ),
      ),
    );
  }
}
