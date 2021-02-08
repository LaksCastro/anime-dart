import 'package:app_utils/utils/random_utils.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../helpers/errors/app_exception.dart';
import '../../../../../auth/domain/entities/oauth_context.dart';
import '../../../../../auth/domain/entities/oauth_request.dart';
import '../../../../../auth/domain/usecases/request_oauth_code.dart';
import '../internal/mal_secret.dart';

class MyAnimeListRequestOAuthCode extends RequestOAuthCode {
  static const _oauthHost = 'myanimelist.net';
  static const _authorizationPath = '/v1/oauth2/authorize';

  static final _requests = <String, OAuthRequest>{};

  const MyAnimeListRequestOAuthCode();

  /// ### Generate the Authentication Endpoint
  /// This method generates the endpoint
  /// that must be displayed in a [WebView] or opened in any user-agent
  /// to allow user click in  [accept] or [decline] button
  ///
  /// He will be redirected to, in current release,
  /// \[https://lakscastro.github.io/anime-dart]
  ///
  /// The redirect uri contains: [https://host/?code=...&state=...]
  ///
  /// The client must continue the flow sending this redirect url to
  /// [MyAnimeListRequestOAuthToken] usecase
  ///
  /// ### Important security note
  ///
  /// Today, [01/31/2021], MyAnimeList currently API only supports [code_challenge_method=plain]
  ///
  /// So, the [code_verifier] and [code_challenge] **are the same.**
  ///
  /// That is, **DO NOT LOGIN/AUTHORIZE ANYTHING IN A [HTTP] CONNECTION**
  ///
  /// For more info, see
  /// - https://medium.com/identity-beyond-borders/what-the-heck-is-pkce-40662e801a76
  /// - https://myanimelist.net/apiconfig/references/authorization
  @override
  Future<Either<AppException, OAuthRequest>> call(
    OAuthContext context,
  ) async {
    final clientId = context.env[MyAnimeListSecret.clientId];

    final charset = RequestOAuthCode.codeChallengeCharset;

    final codeChallenge = secureString(charset: charset, length: 128);
    final state = secureString(charset: charset, length: 64);

    final queryParams = <String, String>{
      'client_id': clientId,
      'response_type': 'code',
      'code_challenge': codeChallenge,
      'state': state,
    };

    final authorizeEndpoint =
        Uri.https(_oauthHost, _authorizationPath, queryParams);

    _requests[state] = OAuthRequest(
      url: authorizeEndpoint.toString(),
      codeChallenge: codeChallenge,
      state: state,
      context: context,
    );

    _removeRequestIdAfterExpiration(state);

    return Right(_requests[state]);
  }

  void _removeRequestIdAfterExpiration(String requestId) async {
    await Future.delayed(Duration(minutes: 5));

    if (_requests.containsKey(requestId)) _requests.remove(requestId);
  }

  static Future<bool> validateRequest(String requestId) async {
    final valid = _requests.containsKey(requestId);

    _requests.remove(requestId);

    return valid;
  }
}
