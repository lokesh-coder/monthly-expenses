import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/currency_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/ui/common/amount.dart';

class AmountNumpad extends StatefulWidget {
  final Function onSelect;
  final Function close;
  final String selected;
  const AmountNumpad({Key key, this.selected, this.close, this.onSelect})
      : super(key: key);

  @override
  _AmountNumpadState createState() => _AmountNumpadState();
}

class _AmountNumpadState extends State<AmountNumpad> {
  String value = '';

  @override
  void initState() {
    super.initState();
    value = widget.selected == "null" ? '' : widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _display(),
          _numpad(),
          SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: Clrs.green,
            child: Icon(Icons.check),
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
    List rowFour = [CurrencyHelper.separator, '0', 'REMOVE'];

    List<Widget> items =
        (rowOne + rowTwo + rowThree + rowFour).map((c) => _btn(c)).toList();

    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Clrs.labelActive.withOpacity(0.3),
            Colors.transparent,
          ],
          radius: 0.6,
          focal: Alignment.center,
        ),
      ),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 3,
          childAspectRatio: 1.5,
        ),
        children: items,
      ),
    );
  }

  Widget _btn(String label) {
    var style = TextStyle(
      color: Clrs.labelActive,
      fontSize: 25,
    );

    var icon = (x, [col = Clrs.labelActive]) => Icon(x, color: col);

    var child;

    if (label == 'REMOVE')
      child = icon(Icons.backspace);
    else
      child = Text(label, style: style);

    return GestureDetector(
      onTap: () {
        if (label == CurrencyHelper.separator) label = '.';
        if (label == 'REMOVE') {
          if (value.length == 0) return;
          value = value.substring(0, value.length - 1);
        } else {
          if (_isValidEntry(value, label)) value += label;
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: label == 'SELECT' ? Clrs.green : Colors.white,
        ),
        child: Center(child: child),
      ),
    );
  }

  _display() {
    var placeholder = Amount(
      0.00,
      type: AmountDisplayType.PLACEHOLDER,
      size: AmountDisplaySize.XL,
    );
    var actual = Amount(
      num.parse(value == '' ? '0' : value),
      type: AmountDisplayType.INPUT,
      size: AmountDisplaySize.XL,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: value == '' ? placeholder : actual,
    );
  }

  _isValidEntry(String value, String label) {
    final decimalMatch = RegExp(r'\.[0-9]{3,}$');
    return !decimalMatch.hasMatch(value + label);
  }
}
