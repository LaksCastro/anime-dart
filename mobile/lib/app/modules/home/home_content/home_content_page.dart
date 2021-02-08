import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/state/builders/state_builder.dart';
import '../../theme/app_color_scheme.dart';
import '../../theme/theme_controller.dart';
import '../../theme/transition_barrier.dart';
import '../home_controller.dart';
import 'home_content_controller.dart';

class HomeContentPage extends StatefulWidget {
  HomeContentPage({Key key}) : super(key: key);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState
    extends ModularState<HomeContentPage, HomeContentController> {
  final _homeController = Modular.get<HomeController>();
  final _themeController = Modular.get<ThemeController>();

  void _changeTheme({
    ThemeMode theme,
    Color colorBase,
    bool isMonochrome,
  }) async {
    final isDark = (theme ?? _themeController.theme) == ThemeMode.dark ||
        _themeController.isSystemDarkMode;

    final nextColorScheme = AppColorScheme(
      SchemeConfig.fromColor(
        colorBase ?? _themeController.colorBase,
        isDark: isDark,
        isMonochrome: isMonochrome ?? _themeController.isMonochrome,
      ),
    );

    final barrierColor = nextColorScheme.background[isDark ? 1 : 0];

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      child: TransitionBarrier(
        backgroundTask: () async {
          await _themeController.setTheme(
            colorBase: colorBase,
            isMonochrome: isMonochrome,
            theme: theme,
          );

          await Future.delayed(Duration(seconds: 1));
        },
        barrierColor: barrierColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Dark Theme '),
              onPressed: () {
                _changeTheme(theme: ThemeMode.dark);
              },
            ),
            ElevatedButton(
              child: Text('Light Theme '),
              onPressed: () {
                _changeTheme(theme: ThemeMode.light);
              },
            ),
            ElevatedButton(
              child: Text('System Theme '),
              onPressed: () {
                _changeTheme(theme: ThemeMode.system);
              },
            ),
            ElevatedButton(
              child: Text('Reset Default'),
              onPressed: () {
                _themeController.resetDefault();
              },
            ),
            ElevatedButton(
              child: Text('Yellow Color Scheme'),
              onPressed: () {
                _changeTheme(colorBase: Colors.yellow);
              },
            ),
            ElevatedButton(
              child: Text('Red Color Scheme'),
              onPressed: () {
                _changeTheme(colorBase: Colors.red);
              },
            ),
            ElevatedButton(
              child: Text('Purple Color Scheme'),
              onPressed: () {
                _changeTheme(colorBase: Colors.purple);
              },
            ),
            ElevatedButton(
              child: Text('Green Color Scheme'),
              onPressed: () {
                _changeTheme(colorBase: Colors.green);
              },
            ),
            ElevatedButton(
              child: Text('Cyan Color Scheme'),
              onPressed: () {
                _changeTheme(colorBase: Colors.cyan);
              },
            ),
            ElevatedButton(
              child: Text('Change language'),
              onPressed: () {
                Modular.navigator.pushNamed('/i18n');
              },
            ),
            Center(
              child: StateBuilder(
                controller: _homeController,
                builder: (context, child) {
                  return Text(
                    FlutterI18n.plural(
                      context,
                      'ui.clicked',
                      _homeController.count,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
