import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'releases_controller.dart';
import 'releases_page.dart';

class ReleasesModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind<ReleasesController>(
          (_) => ReleasesController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter<ReleasesPage>('/', child: (_, __) => ReleasesPage()),
      ];

  @override
  Widget get view => ReleasesPage();
}
