import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _display(),
            Wrap(
              runSpacing: 0,
              spacing: 0,
              children: _numpad(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _numpad() {
    List rowOne = ['1', '2', '3', 'CLOSE'];
    List rowTwo = ['4', '5', '6', 'CLEAR'];
    List rowThree = ['7', '8', '9', '00'];
    List rowFour = ['.', '0', 'REMOVE', 'SELECT'];

    List items = rowOne + rowTwo + rowThree + rowFour;
    return items.map((c) => _btn(c)).toList();
  }

  Widget _btn(String label) {
    var style = TextStyle(
      color: Clrs.dark,
      fontSize: 22,
    );

    var child;

    if (label == 'CLEAR')
      child = Icon(Icons.delete_outline);
    else if (label == 'SELECT')
      child = Icon(Icons.check);
    else if (label == 'CLOSE')
      child = Icon(Icons.close);
    else if (label == 'REMOVE')
      child = Icon(Icons.backspace);
    else
      child = Text(label, style: style);

    return GestureDetector(
      onTap: () {
        if (label == 'CLEAR') {
          value = '';
        } else if (label == 'SELECT') {
          if (value == null) value = '';
          widget.onSelect(num.parse(value));
          return;
        } else if (label == 'CLOSE') {
          widget.close();
          return;
        } else if (label == 'REMOVE') {
          if (value.length == 0) return;
          value = value.substring(0, value.length - 1);
        } else
          value += label;

        setState(() {});
      },
      child: FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 17),
          child: Center(child: child),
        ),
      ),
    );
  }

  _display() {
    var placeholder = Text(
      "0.00",
      style: TextStyle(
        color: Clrs.label,
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
    );
    var actual = Text(
      value,
      style: TextStyle(
        color: Clrs.primary,
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: value == '' ? placeholder : actual,
    );
  }
}
