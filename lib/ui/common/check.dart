import 'package:flutter/material.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/m_icons.dart';

class Check extends StatelessWidget {
  final double size = 26;

  const Check();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Clrs.primary,
          child: Icon(MIcons.tick, size: 33),
          elevation: 0,
          onPressed: null,
        ),
      ),
    );
  }
}
