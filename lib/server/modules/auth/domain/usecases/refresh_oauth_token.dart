import '../../../../helpers/dto/domain/access_token.dart';
import '../../../core/domain/entities/usecase.dart';

abstract class RefreshOAuthToken extends UseCase<String, AccessToken> {
  const RefreshOAuthToken() : super('app.usecase.refreshoauthtoken');
}
