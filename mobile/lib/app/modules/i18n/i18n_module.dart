import 'package:flutter_modular/flutter_modular.dart';

import 'i18n_page.dart';

class I18nModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter<I18nPage>(
          '/',
          child: (_, __) => I18nPage(),
        ),
      ];
}
