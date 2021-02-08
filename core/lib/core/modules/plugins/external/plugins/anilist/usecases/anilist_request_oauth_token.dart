import 'package:app_utils/utils/date_utils.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../helpers/dto/domain/access_token.dart';
import '../../../../../../helpers/errors/app_exception.dart';
import '../../../../../auth/domain/entities/oauth_redirect.dart';
import '../../../../../auth/domain/entities/oauth_success.dart';
import '../../../../../auth/domain/errors/auth_errors.dart';
import '../../../../../auth/domain/usecases/request_oauth_token.dart';

class AniListRequestOAuthToken extends RequestOAuthToken {
  const AniListRequestOAuthToken();

  @override
  Future<Either<AppException, OAuthSuccess>> call(
    OAuthRedirect redirect,
  ) async {
    final redirectUrl = Uri.parse(redirect.redirectUrl);
    final query = redirectUrl.queryParameters;

    const accessTokenKey = 'access_token',
        tokenTypeKey = 'token_type',
        expiresInKey = 'token_type',
        errorKey = 'error';

    if (!redirectUrl.hasQuery) {
      return Left(InvalidOAuthRequest());
    }

    if (query.containsKey(errorKey)) {
      if (RegExp(r'denied').hasMatch(query[errorKey])) {
        return Left(OAuthAccessDenied());
      }

      return Left(InvalidOAuthRequest());
    }

    if (!query.containsKey(tokenTypeKey) ||
        !query.containsKey(accessTokenKey)) {
      return Left(InvalidOAuthRequest());
    }

    if (query[tokenTypeKey] != 'Bearer') {
      return Left(ForbiddenUnknownRequest());
    }

    final accessToken = query[accessTokenKey];
    final tokenType = query[tokenTypeKey];

    final expiresIn = int.tryParse(query[expiresInKey]);
    final expiresInDate = expiresIn != null ? fromSeconds(expiresIn) : null;

    return Right(
      OAuthSuccess(
        AccessToken(
          accessToken: accessToken,
          expiresIn: expiresInDate,
          tokenType: tokenType,
        ),
      ),
    );
  }
}
