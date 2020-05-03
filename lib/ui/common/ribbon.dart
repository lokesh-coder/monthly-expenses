import 'package:flutter/material.dart';
import 'package:monex/config/typography.dart';

class Ribbon extends StatelessWidget {
  final String text;

  const Ribbon(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).hideCurrentSnackBar();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Style.body.clr(Colors.white),
        ),
      ),
    );
  }
}
