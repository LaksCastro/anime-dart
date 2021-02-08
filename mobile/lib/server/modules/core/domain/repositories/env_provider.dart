import '../entities/repository.dart';

abstract class EnvProvider extends Repository {
  const EnvProvider() : super('app.repositories.envprovider');

  String operator [](String key);

  Future<void> initialize();
}
