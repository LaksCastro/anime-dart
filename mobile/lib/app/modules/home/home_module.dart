import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/controllers/value/value_controller.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<HomeController>(
          (_) => HomeController(),
        ),
        Bind<ValueController<int>>(
          (_) => ValueController<int>(0),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter<HomePage>(
          '/',
          child: (_, __) => HomePage(),
        ),
      ];
}
