import '../../../core/domain/entities/usecase.dart';
import '../entities/oauth_redirect.dart';
import '../entities/oauth_success.dart';

abstract class RequestOAuthToken extends UseCase<OAuthRedirect, OAuthSuccess> {
  const RequestOAuthToken() : super('app.usecase.requestoauthtoken');
}
