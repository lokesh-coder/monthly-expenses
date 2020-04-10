import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

enum AmountSize { SM, MD, LG }

class Amount extends StatelessWidget {
  final bool isCredit;
  final num value;
  final AmountSize size;

  const Amount({Key key, this.value, this.isCredit, this.size = AmountSize.SM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isCredit ? MonexColors.green : MonexColors.red;
    double fontSize = _getFontSizeMap()[size];
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          text: value.toString(),
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Circular',
            fontWeight: FontWeight.w800,
            color: color,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' ₹',
              style: TextStyle(
                fontSize: fontSize - 3,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<dynamic, double> _getFontSizeMap() {
    return {
      AmountSize.SM: 20.0,
      AmountSize.MD: 22.0,
      AmountSize.LG: 25.0,
    };
  }
}
