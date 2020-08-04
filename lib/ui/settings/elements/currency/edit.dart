import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/ui/common/fade_transition.dart';
import 'package:monthlyexp/ui/screens/currency.dart';
import 'package:provider/provider.dart';

class CurrencyEdit extends StatelessWidget {
  const CurrencyEdit();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, FadeRoute(CurrencyScreen()));
        },
        child: Text(
          Labels.changeCurrency,
          style: Style.body.clr(Colors.white),
        ),
        elevation: 0,
        padding: EdgeInsets.all(10),
        color: theme.violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: theme.violet, width: 2),
        ),
      ),
    );
  }
}
