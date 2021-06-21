import 'package:flutter/material.dart';

class AppThemeColors {
  static ThemeData data(BuildContext context) {
    return ThemeData(
      secondaryHeaderColor: Color.fromRGBO(127, 114, 193, 1).withOpacity(1),
      canvasColor: Colors.grey[800].withOpacity(0.4),
      brightness: Brightness.light,
      fontFamily: 'Raleway',
      accentColor: Color.fromRGBO(150, 150, 230, 1),
      backgroundColor: Color.fromRGBO(60, 60, 80, 1),
      scaffoldBackgroundColor: Color.fromRGBO(235, 235, 245, 1),
      dialogBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
      cardColor: Color.fromRGBO(255, 255, 255, 1),
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(130, 130, 210, 1),
      ),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Raleway',
            bodyColor: Color.fromRGBO(100, 100, 150, 1),
          ),
      colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: Color.fromRGBO(150, 150, 230, 1),
          secondaryVariant: Color.fromRGBO(170, 170, 250, 1),
          onSecondary: Colors.white),
    );
  }
}

class AppDarkThemeColors {
  static ThemeData data(BuildContext context) {
    final layoutColor = Color.fromRGBO(35, 35, 60, 1);

    return ThemeData(
      secondaryHeaderColor: Color.fromRGBO(87, 74, 153, 1).withOpacity(0.8),
      canvasColor: Colors.grey[800].withOpacity(0.3),
      brightness: Brightness.dark,
      fontFamily: 'Raleway',
      accentColor: Color.fromRGBO(150, 150, 230, 1),
      backgroundColor: Color.fromRGBO(60, 60, 80, 1),
      scaffoldBackgroundColor: Color.fromRGBO(10, 10, 20, 1),
      dialogBackgroundColor: Color.fromRGBO(20, 20, 30, 1),
      cardColor: Color.fromRGBO(20, 20, 40, 1),
      bottomAppBarTheme: BottomAppBarTheme(
        color: layoutColor,
      ),
      appBarTheme: AppBarTheme(
        color: layoutColor,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Raleway',
            bodyColor: Color.fromRGBO(200, 200, 250, 1),
          ),
      colorScheme: ColorScheme.dark().copyWith(
          secondary: Color.fromRGBO(30, 30, 50, 1),
          secondaryVariant: Color.fromRGBO(45, 45, 65, 1),
          onSecondary: Colors.white),
    );
  }
}
