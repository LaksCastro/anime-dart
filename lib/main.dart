import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'setup.dart';

void main() async {
  await setup();

  runApp(ModularApp(module: AppModule()));
}
