import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../helpers/dto/domain/access_token.dart';
import '../../../../../../helpers/errors/app_exception.dart';
import '../../../../../../helpers/errors/network_exception.dart';
import '../../../../../../helpers/utils/date_utils.dart';
import '../../../../../auth/domain/entities/oauth_redirect.dart';
import '../../../../../auth/domain/entities/oauth_success.dart';
import '../../../../../auth/domain/errors/auth_errors.dart';
import '../../../../../auth/domain/usecases/request_oauth_token.dart';
import '../internal/mal_secret.dart';
import 'mal_request_oauth_code.dart';

class MyAnimeListRequestOAuthToken extends RequestOAuthToken {
  static const _oauthHost = 'myanimelist.net';
  static const _tokenPath = '/v1/oauth2/token';

  const MyAnimeListRequestOAuthToken();

  /// ### Retrieve Access Token
  /// To get access token, follow the [OAuth Flow] with [PKCE]
  /// (MyAnimeList supports PKCE)
  ///
  /// This [UseCase] has responsability to retrieve [Access Token] after
  /// user granted permissions
  /// (if not granted, this will return a [OAuthAccessDenied] error)
  @override
  Future<Either<AppException, OAuthSuccess>> call(
    OAuthRedirect redirect,
  ) async {
    final redirectUrl = Uri.parse(redirect.redirectUrl);
    final query = redirectUrl.queryParameters;
    final env = redirect.originalRequest.context.env;

    const codeKey = 'code', stateKey = 'state', errorKey = 'error';

    if (!redirectUrl.hasQuery) {
      return Left(InvalidOAuthRequest());
    }

    if (query.containsKey(errorKey)) {
      if (RegExp(r'denied').hasMatch(query[errorKey])) {
        return Left(OAuthAccessDenied());
      }

      return Left(InvalidOAuthRequest());
    }

    if (!query.containsKey(codeKey) || !query.containsKey(stateKey)) {
      return Left(InvalidOAuthRequest());
    }

    final requestId = query[stateKey];

    if (!await MyAnimeListRequestOAuthCode.validateRequest(requestId)) {
      return Left(ForbiddenUnknownRequest());
    }

    final code = query[codeKey];
    final codeVerifier = redirect.originalRequest.codeChallenge;

    final tokenEndpoint = Uri.https(_oauthHost, _tokenPath).toString();

    /// Why [formData? See step 4 here](https://myanimelist.net/blog.php?eid=835707)
    final formData = FormData.fromMap(<String, String>{
      'client_id': env[MyAnimeListSecret.clientId],
      'code_verifier': codeVerifier,
      'code': code,
      'grant_type': 'authorization_code',
    });

    try {
      final result = await redirect.httpClient.post(
        tokenEndpoint,
        data: formData,
      );

      final data = result.data;

      String accessToken = data['access_token'];
      String tokenType = data['token_type'];
      String refreshToken = data['refresh_token'];

      final expiresIn = int.tryParse(data['expires_in']);
      final expiresInDate = expiresIn != null ? fromSeconds(expiresIn) : null;

      return Right(
        OAuthSuccess(
          AccessToken(
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiresIn: expiresInDate,
            tokenType: tokenType,
          ),
        ),
      );
    } on Exception catch (e) {
      if (e is DioError) {
        if (e.response.statusCode == 400) {
          return Left(InvalidOAuthRequest());
        }
      }

      return Left(NetworkException.requestException(e));
    }
  }
}
