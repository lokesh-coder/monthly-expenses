import 'package:flutter/material.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class Hint extends StatelessWidget {
  final String message;
  final Widget child;

  const Hint(this.message, {this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Tooltip(
      decoration: BoxDecoration(
        color: theme.textHeading,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: Style.body.sm.clr(theme.textSubHeading),
      message: message,
      child: child,
    );
  }
}
