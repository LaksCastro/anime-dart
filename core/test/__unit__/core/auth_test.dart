import 'package:app_core/core/helpers/errors/app_exception.dart';
import 'package:app_core/core/modules/auth/domain/entities/oauth_context.dart';
import 'package:app_core/core/modules/auth/domain/usecases/request_oauth_code.dart';
import 'package:app_core/core/modules/browse/domain/errors/browse_errors.dart';
import 'package:app_core/core/modules/core/domain/repositories/env_provider.dart';
import 'package:app_core/core/modules/plugins/domain/entities/plugin/plugin.dart';
import 'package:app_core/core/modules/plugins/external/datasources/local_plugin_repository.dart';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:test/test.dart';

class PureDartDotEnv extends EnvProvider {
  @override
  String operator [](String key) => dotenv.env[key];

  @override
  Future<void> initialize() async {
    await dotenv.load();
  }
}

void main() {
  test('Authentication temporary test', () async {
    final results = await LocalSearchPluginRepository()
        .searchByText('app.plugin.anilist.info');

    void _onError(AppException l) {}

    void _onSuccess(List<Plugin> r) async {
      final myAnimeListPlugin = r.first;

      final requestAuthCodeUseCase =
          await myAnimeListPlugin.authController<RequestOAuthCode>();

      requestAuthCodeUseCase.fold((l) {
        if (l is UnsupportedUseCaseException) {
          print('Unsupported Use Case');
        }
      }, (requestAuthCode) async {
        await PureDartDotEnv().initialize();

        final result = await requestAuthCode(OAuthContext(
          env: PureDartDotEnv(),
          params: {
            'this': 'context',
            'is': 'to help',
            'any': 'client',
            'to': 'show',
            'redirects': 'ok'
          },
        ));

        result.fold((l) {
          print('error here');
          print(l);
        }, (oauthRequest) {
          print('Nao sei como, mas funcionou');
          print(oauthRequest.url);
        });
      });
    }

    results.fold(_onError, _onSuccess);
  });
}
