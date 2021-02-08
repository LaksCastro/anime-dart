import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'library_controller.dart';
import 'library_page.dart';

class LibraryModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind<LibraryController>(
          (_) => LibraryController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [];

  @override
  Widget get view => LibraryPage();
}
