import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class Button extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final num size;
  final double radius;
  final Color color;
  final Color splashColor;
  final Color highlightColor;
  final bool hasShape;

  const Button({
    this.child,
    this.size,
    this.onPressed,
    this.color = Colors.transparent,
    this.splashColor,
    this.highlightColor,
    this.radius = 35,
    this.hasShape = true,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeChanger>(context).theme;
    return Container(
      height: size,
      width: size,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        hoverElevation: 0,
        focusElevation: 0,
        elevation: 0,
        highlightElevation: 0,
        color: color,
        highlightColor: highlightColor,
        splashColor: splashColor,
        shape: hasShape
            ? SuperellipseShape(borderRadius: BorderRadius.circular(radius))
            : null,
        onPressed: onPressed,
        colorBrightness: Brightness.dark,
        child: Container(
          height: size,
          width: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
