import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/widgets/I18nText.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'i18n_controller.dart';

class I18nPage extends StatefulWidget {
  I18nPage({Key key}) : super(key: key);

  @override
  _I18nPageState createState() => _I18nPageState();
}

class _I18nPageState extends State<I18nPage> {
  final _i18nController = Modular.get<I18nController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ok'),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('PT-BR'),
              onPressed: () {
                _i18nController.setLocale(
                  context,
                  Locale('pt', 'br'),
                );
              },
            ),
            ElevatedButton(
              child: Text('EN-US'),
              onPressed: () {
                _i18nController.setLocale(
                  context,
                  Locale('en', 'us'),
                );
              },
            ),
            ElevatedButton(
              child: Text('RU-RU'),
              onPressed: () {
                _i18nController.setLocale(
                  context,
                  Locale('ru', 'ru'),
                );
              },
            ),
            ElevatedButton(
              child: Text('KO-KR'),
              onPressed: () {
                _i18nController.setLocale(
                  context,
                  Locale('ko', 'kr'),
                );
              },
            ),
            I18nText('ui.continue'),
          ],
        ),
      ),
    );
  }
}
