import 'package:flutter/material.dart';
import 'package:food_app/Views/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool is0n) {
    themeMode = is0n ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Mythemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(secondary: Color(0xFF84AB5C)),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(secondary: Color(0xFF84AB5C)),
      primarySwatch: Colors.green,
      primaryColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white));
}
