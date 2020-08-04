import 'package:flutter/material.dart';

class Font {
  static String get numeric => 'Manrope';
  static String get base => 'Worksans';
}

class FontSize {
  static double scale = 1;

  static double get xs => 11 * scale;
  static double get sm => 14 * scale;
  static double get base => 16 * scale;
  static double get md => 18 * scale;
  static double get lg => 25 * scale;
  static double get xl => 30 * scale;
}

class Style {
  static TextStyle get numeric => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: Font.numeric,
        letterSpacing: -.5,
      );

  static TextStyle get heading => TextStyle(
        fontSize: FontSize.base,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      );
  static TextStyle get body => TextStyle(
        fontSize: FontSize.base,
        fontFamily: Font.base,
        letterSpacing: -0.5,
      );
  static TextStyle get label => TextStyle(
        fontSize: FontSize.xs,
        fontWeight: FontWeight.w600,
      );
}

extension styles on TextStyle {
  TextStyle clr(Color clr) => copyWith(color: clr);
  TextStyle fs(double fontSize) => copyWith(fontSize: fontSize);
  TextStyle get lg => copyWith(fontSize: FontSize.lg);
  TextStyle get xs => copyWith(fontSize: FontSize.xs);
  TextStyle get sm => copyWith(fontSize: FontSize.sm);
  TextStyle get md => copyWith(fontSize: FontSize.md);
  TextStyle get base => copyWith(fontSize: FontSize.base);
  TextStyle get light => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get ls => copyWith(letterSpacing: -0.5);
}
