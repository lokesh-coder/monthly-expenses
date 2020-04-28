import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

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
      textStyle: TextStyle(color: Colors.white54),
      message: message,
      child: child,
    );
  }
}
