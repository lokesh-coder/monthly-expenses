import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class Err extends StatelessWidget {
  const Err({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(MIcons.bug_line, color: theme.red, size: 19),
          SizedBox(width: 10),
          Text(Labels.error, style: Style.body),
        ],
      ),
    );
  }
}
