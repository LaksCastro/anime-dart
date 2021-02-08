import '../../../core/domain/entities/usecase.dart';
import '../entities/oauth_context.dart';
import '../entities/oauth_request.dart';

abstract class RequestOAuthCode extends UseCase<OAuthContext, OAuthRequest> {
  const RequestOAuthCode() : super('app.usecase.requestoauthcode');

  static const codeChallengeCharset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHYJKLMNOPQRSTUVWXYZ0123456789~_-.';
}
