import 'package:flutter/material.dart';
import 'package:monthlyexp/config/themes.dart';

class ThemeChanger with ChangeNotifier {
  AppTheme _theme;

  ThemeChanger(this._theme);

  AppTheme get theme {
    return _theme;
  }

  void setTheme(AppTheme theme) {
    _theme = theme;
    notifyListeners();
  }
}
