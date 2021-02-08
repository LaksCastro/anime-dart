import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../../domain/repositories/env_provider.dart';

class FlutterDotEnv extends EnvProvider {
  const FlutterDotEnv();

  @override
  String operator [](String key) => dotenv.env[key];

  @override
  Future<void> initialize() async {
    await dotenv.load();
  }
}
