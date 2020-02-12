import 'package:daisy/theme/dark.dart';
import 'package:daisy/theme/light.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData theme = darkTheme;

  String _name = 'dark';
  var _themes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
  };

  void setTheme(String themeName) {
    if (!_themes.containsKey(themeName)) {
      throw 'Unsupported theme $themeName';
    }

    if (_name == themeName) {
      return;
    }

    _name = themeName;
    theme = _themes[_name];
    notifyListeners();
  }
}
