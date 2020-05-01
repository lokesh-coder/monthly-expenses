import "package:flutter/material.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/typography.dart";
import "package:monex/ui/common/fade_transition.dart";
import "package:monex/ui/screens/currency.dart";

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
