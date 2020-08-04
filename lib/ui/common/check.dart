import 'package:flutter/material.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class Check extends StatelessWidget {
  final double size = 26;

  const Check();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Container(
      height: size,
      width: size,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: theme.brand,
          child: Icon(MIcons.tick, size: 33),
          elevation: 0,
          onPressed: null,
        ),
      ),
    );
  }
}
