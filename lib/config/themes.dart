import 'package:flutter/material.dart';

abstract class AppTheme {
  final Color red = Color(0xffE37986);
  final Color green = Color(0xff33B284);
  final Color yellow = Color(0xffE5BA4C);
  final Color blue = Color(0xff7384C1);
  final Color violet = Color(0xffB48EAD);
  final Color teak = Color(0xff81A1C1);

  String name;

  Color brand = Color(0xffD08770);

  Color bg;
  Color textHeading;
  Color textSubHeading;

  Color bgPrimary;
  Color textPrimaryHeading;
  Color textPrimarySubHeading;

  Color bgSecondary;
  Color textSecondaryHeading;
  Color textSecondarySubHeading;
}

class LightTheme extends AppTheme {
  @override
  final String name = 'light';

  @override
  final Color bg = Colors.white;

  @override
  final Color textHeading = Color(0xff434C5E);

  @override
  final Color textSubHeading = Color(0xff98a3b8);

  @override
  final Color bgPrimary = Color(0xfff3f6f8);

  @override
  final Color textPrimaryHeading = Color(0xff434C5E);

  @override
  final Color textPrimarySubHeading = Color(0xff98a3b8);

  @override
  final Color bgSecondary = Color(0xffeff2f6);

  @override
  final Color textSecondaryHeading = Color(0xff434C5E);

  @override
  final Color textSecondarySubHeading = Color(0xff98a3b8);
}

class DarkTheme extends AppTheme {
  @override
  final String name = 'dark';

  @override
  final Color bg = Color(0xff4C566A);

  @override
  final Color textHeading = Color(0xffD8DEE9);

  @override
  final Color textSubHeading = Color(0xff949cac);

  @override
  final Color bgPrimary = Color(0xff2E3440);

  @override
  final Color textPrimaryHeading = Color(0xffD8DEE9);

  @override
  final Color textPrimarySubHeading = Color(0xff949cac);

  @override
  final Color bgSecondary = Color(0xff3B4252);

  @override
  final Color textSecondaryHeading = Color(0xffD8DEE9);

  @override
  final Color textSecondarySubHeading = Color(0xff949cac);
}
