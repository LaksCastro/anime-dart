import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_content_controller.dart';
import 'home_content_page.dart';

class HomeContentModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind<HomeContentController>(
          (_) => HomeContentController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => HomeContentPage()),
      ];

  @override
  Widget get view => HomeContentPage();
}
