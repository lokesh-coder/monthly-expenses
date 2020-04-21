import 'package:flutter/material.dart';

class Ribbon extends StatelessWidget {
  final String text;

  const Ribbon(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Circular',
        ),
      ),
    );
  }
}
