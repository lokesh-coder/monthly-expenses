import 'package:flutter/material.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/typography.dart';

class Hint extends StatelessWidget {
  final String message;
  final Widget child;

  const Hint(this.message, {this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        color: Clrs.dark,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: Style.body.bodyAltClr.sm,
      message: message,
      child: child,
    );
  }
}
