import 'package:flutter/cupertino.dart';
import '../service/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemeP = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemeP.setDarkTheme(value);
    notifyListeners();
  }
}
