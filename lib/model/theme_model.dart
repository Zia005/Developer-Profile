import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark();
var lightTheme= ThemeData.light();
enum ThemeType { light, dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.dark;
  // bool light = true;

  toggleTheme() {
    if (_themeType == ThemeType.dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.light;
      // light = false;
    }
    else if (_themeType == ThemeType.light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.dark;
      // light = true;
    }
    return notifyListeners();
  }
}