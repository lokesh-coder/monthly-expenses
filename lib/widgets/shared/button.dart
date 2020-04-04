import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const Button({Key key, this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: MonexColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 15,
          letterSpacing: -0.5,
          color: Colors.white70,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
