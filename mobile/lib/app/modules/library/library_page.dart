import 'package:flutter/material.dart' hide ColorScheme;
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/theme.dart';
import 'library_controller.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends ModularState<LibraryPage, LibraryController> {
  final _colorScheme = Modular.get<ThemeController>().colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorScheme.background[0],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(5, (index) {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    color: _colorScheme.background[index],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          5,
                          (i) => Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Testando este texto',
                              style: TextStyle(
                                color: _colorScheme.text[i],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
