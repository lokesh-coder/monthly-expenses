import 'package:flutter/material.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class Loader extends StatelessWidget {
  const Loader();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Icon(
      MIcons.loader_fill,
      color: theme.brand,
      size: 30,
    );
  }
}
