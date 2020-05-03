import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/m_icons.dart';

class Loader extends StatelessWidget {
  const Loader();

  @override
  Widget build(BuildContext context) {
    return Icon(
      MIcons.loader_fill,
      color: Clrs.secondary,
      size: 30,
    );
  }
}
