import 'package:flutter/material.dart';
import 'package:monex/config/app.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/amount.dart';

class AmountNumpad extends StatefulWidget {
  final Function onSelect;
  final Function close;
  final String selected;
  const AmountNumpad({this.selected, this.close, this.onSelect});

  @override
  _AmountNumpadState createState() => _AmountNumpadState();
}

class _AmountNumpadState extends State<AmountNumpad> {
  var store = sl<SettingsStore>();
  var locale;
  String value = '';

  @override
  void initState() {
    super.initState();
    value = widget.selected == "null" ? '' : widget.selected;
    locale = store.currency.split('=')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          _display(),
          _numpad(),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Clrs.primary,
            child: Icon(MIcons.tick),
            onPressed: () {
              if (value == null) value = '';
              widget.onSelect(num.parse(value));
            },
          ),
        ],
      ),
    );
  }

  Widget _numpad() {
    List rowOne = ['1', '2', '3'];
    List rowTwo = ['4', '5', '6'];
    List rowThree = ['7', '8', '9'];
    List rowFour = [_separator, '0', 'REMOVE'];

    List<Widget> items =
        (rowOne + rowTwo + rowThree + rowFour).map((c) => _btn(c)).toList();

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      children: items,
    );
  }

  Widget _btn(String label) {
    var child;

    if (label == 'REMOVE') {
      var icon = (x, [col = Clrs.labelActive]) => Icon(x, color: col);
      child = icon(MIcons.delete_back_2_line);
    } else {
      var style = Style.numeric.lg.bodyClr;
      child = Text(label, style: style);
    }

    return GestureDetector(
      onTap: () {
        if (label == _separator) label = '.';
        if (label == 'REMOVE') {
          if (value.length == 0) return;
          value = value.substring(0, value.length - 1);
        } else {
          var finalAmount = value + label;
          if (CurrencyHelper.isValidAmountPattern(
              _normalizeAmount(finalAmount))) value += label;
        }

        setState(() {});
      },
      child: Container(
        decoration:
            BoxDecoration(color: label == 'SELECT' ? Clrs.green : Colors.white),
        child: Center(child: child),
      ),
    );
  }

  _display() {
    Widget displayValue;
    if (value == '') {
      var placeholderText = 0.toStringAsFixed(AppConfig.maxDecimalsInAmount);
      var formattedText = CurrencyHelper.getAmount(placeholderText, locale);
      displayValue = Amount(
        formattedText,
        format: false,
        type: AmountDisplayType.PLACEHOLDER,
        size: DisplaySize.LG,
      );
    } else {
      displayValue = Amount(
        value.replaceAll('.', _separator),
        format: false,
        type: AmountDisplayType.INPUT,
        size: DisplaySize.LG,
      );
    }

    return Container(child: displayValue);
  }

  _normalizeAmount(String value) {
    if (value == '.') return '0';
    return value;
  }

  get _separator {
    return CurrencyHelper.separator(locale);
  }
}
