import 'package:flutter/material.dart';

import 'theme_controller.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeController themeController;
  final Widget child;

  ThemeProvider({
    Key key,
    this.child,
    this.themeController,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) => true;

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }
}
