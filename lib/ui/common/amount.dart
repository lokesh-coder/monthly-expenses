import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/enums.dart';

class Amount extends StatelessWidget {
  final num value;
  final AmountDisplaySize size;
  final AmountDisplayType type;

  const Amount(this.value,
      {Key key,
      this.size = AmountDisplaySize.SM,
      this.type = AmountDisplayType.CREDIT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = _getColor();

    double fontSize = _getFontSizeMap()[size];

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            CurrencyHelper.getFormattedCurrency(value),
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              letterSpacing: -.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    Color color;
    switch (type) {
      case AmountDisplayType.CREDIT:
        color = Clrs.green;
        break;
      case AmountDisplayType.DEBIT:
        color = Clrs.red;
        break;
      case AmountDisplayType.INPUT:
        color = Clrs.dark;
        break;
      case AmountDisplayType.PLACEHOLDER:
        color = Clrs.label;
        break;
      case AmountDisplayType.SILENT:
        color = Colors.white.withOpacity(0.5);
        break;
      default:
        color = Clrs.primary;
    }
    return color;
  }

  Map<dynamic, double> _getFontSizeMap() {
    return {
      AmountDisplaySize.XS: 18.0,
      AmountDisplaySize.SM: 20.0,
      AmountDisplaySize.MD: 22.0,
      AmountDisplaySize.LG: 25.0,
      AmountDisplaySize.XL: 30.0,
    };
  }
}
