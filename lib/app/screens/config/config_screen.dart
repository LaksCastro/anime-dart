import 'package:anime_dart/app/screens/config/providers/store_provider.dart';
import 'package:anime_dart/app/screens/config/widgets/data_manager_section.dart';
import 'package:anime_dart/app/screens/config/widgets/in_development.dart';
import 'package:anime_dart/app/screens/config/widgets/theme_section.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/theme_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen({Key key}) : super(key: key);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    print(_themeStore.appTheme);
    return StoreProvider(
      themeStore: _themeStore,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Container(
          child: ListView(
            children: [
              SizedBox(height: 20),
              ThemeSection(),
              SizedBox(height: 20),
              // DataManagerSection(),
              SizedBox(height: 30),
              InDevelopment(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
