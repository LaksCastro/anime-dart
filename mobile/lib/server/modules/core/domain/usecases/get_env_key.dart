import '../entities/usecase.dart';
import '../repositories/env_provider.dart';

abstract class GetEnvKey extends UseCase<EnvProvider, String> {
  const GetEnvKey() : super('app.usecases.getenvkey');
}
