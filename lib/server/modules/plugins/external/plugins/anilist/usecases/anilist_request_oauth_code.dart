import 'package:dartz/dartz.dart';

import '../../../../../../helpers/errors/app_exception.dart';
import '../../../../../auth/domain/entities/oauth_context.dart';
import '../../../../../auth/domain/entities/oauth_request.dart';
import '../../../../../auth/domain/usecases/request_oauth_code.dart';
import '../internal/anilist_secret.dart';

class AniListRequestOAuthCode extends RequestOAuthCode {
  static const _oauthHost = 'anilist.co';
  static const _authorizationPath = '/api/v2/oauth/authorize';

  const AniListRequestOAuthCode();

  /// This method generates the endpoint
  ///
  /// that must be displayed in a [WebView] or opened in any user-agent
  ///
  /// to allow user click in  [accept] or [decline] button
  ///
  /// He will be redirected to, in current release,
  ///
  /// to [https://lakscastro.github.io/anime-dart]
  ///
  /// The redirect url contains: [https://host/?token_type=Bearer&expires_in=...&access_token=...]
  ///
  /// The client must continue the flow sending this redirect url to
  ///
  /// [AniListRequestOAuthToken] usecase
  @override
  Future<Either<AppException, OAuthRequest>> call(
    OAuthContext context,
  ) async {
    final clientId = context.env[AniListSecret.clientId];

    final queryParams = <String, String>{
      'client_id': clientId,
      'response_type': 'token',
    };

    final authorizeEndpoint =
        Uri.https(_oauthHost, _authorizationPath, queryParams);

    final authorizationRequest = OAuthRequest(
      url: authorizeEndpoint.toString(),
      context: context,
    );

    return Right(authorizationRequest);
  }
}
