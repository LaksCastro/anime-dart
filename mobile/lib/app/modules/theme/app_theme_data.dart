import 'package:flutter/material.dart';

import 'theme.dart';

class AppThemeData {
  static AppBarTheme _appBarTheme(AppColorScheme colorScheme) {
    final isDark = colorScheme.config.isDark;

    return AppBarTheme().copyWith(
      color:
          isDark ? colorScheme.background[2] : colorScheme.brand.primaryColor,
      brightness: Brightness.dark,
    );
  }

  static ThemeData get(AppColorScheme colorScheme) {
    return colorScheme.config.isDark
        ? AppThemeData.dark(colorScheme)
        : AppThemeData.light(colorScheme);
  }

  static ThemeData light(AppColorScheme colorScheme) {
    return ThemeData.light().copyWith(
      disabledColor: colorScheme.text[0],
      primaryColorDark: colorScheme.brand.primaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.brand.primaryColor,
      ),
      accentColor: colorScheme.background[1],
      primaryColor: colorScheme.brand.primaryColor,
      backgroundColor: colorScheme.background[0],
      scaffoldBackgroundColor: colorScheme.background[0],
      buttonColor: colorScheme.brand.primaryColor,
      appBarTheme: _appBarTheme(colorScheme),
      accentColorBrightness: Brightness.light,
      colorScheme: ColorScheme.light().copyWith(
        background: colorScheme.background[0],
        brightness: Brightness.light,
        surface: colorScheme.background[1],
        onBackground: colorScheme.text[0],
      ),
      cardColor: colorScheme.background[2],
      bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
        backgroundColor: colorScheme.background[1],
        unselectedItemColor: colorScheme.text[0],
      ),
    );
  }

  static ThemeData dark(AppColorScheme colorScheme) {
    return ThemeData.dark().copyWith(
      disabledColor: colorScheme.text[0],
      primaryColorDark: colorScheme.brand.primaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.brand.primaryColor,
      ),
      accentColor: colorScheme.background[1],
      primaryColor: colorScheme.brand.primaryColor,
      backgroundColor: colorScheme.background[0],
      scaffoldBackgroundColor: colorScheme.background[0],
      buttonColor: colorScheme.brand.primaryColor,
      appBarTheme: _appBarTheme(colorScheme),
      cardColor: colorScheme.background[2],
      accentColorBrightness: Brightness.dark,
      colorScheme: ColorScheme.dark().copyWith(
        background: colorScheme.background[0],
        brightness: Brightness.light,
        surface: colorScheme.background[1],
        onBackground: colorScheme.text[0],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
        backgroundColor: colorScheme.background[1],
        unselectedItemColor: colorScheme.text[0],
      ),
    );
  }
}
