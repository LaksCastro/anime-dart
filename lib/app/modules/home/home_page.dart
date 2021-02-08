import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../shared/controllers/value/value_controller.dart';
import '../../shared/state/state.dart';
import '../library/library_module.dart';
import '../releases/releases_module.dart';
import '../theme/theme.dart';
import 'home_content/home_content_module.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final tabs = <Widget>[
    HomeContentModule(),
    ReleasesModule(),
    LibraryModule(),
  ];

  final _valueController = Modular.get<ValueController<int>>();
  ThemeController get _themeController =>
      ThemeProvider.of(context).themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateBuilder(
        controller: _valueController,
        builder: (_, __) => tabs[_valueController.value],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(
          Icons.add,
          color: _themeController.colorScheme.text.button,
        ),
      ),
      bottomNavigationBar: StateBuilder<ValueController<int>>(
        controller: _valueController,
        builder: (_, __) => BottomNavigationBar(
          currentIndex: _valueController.value,
          showUnselectedLabels: false,
          onTap: _valueController.set,
          items: [
            BottomNavigationBarItem(
              icon: Icon(OMIcons.home),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot_outlined),
              activeIcon: Icon(Icons.whatshot),
              label: 'Releases',
            ),
            BottomNavigationBarItem(
              icon: Icon(OMIcons.folder),
              activeIcon: Icon(Icons.folder),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
