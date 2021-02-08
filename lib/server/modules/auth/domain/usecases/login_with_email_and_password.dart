import '../../../../helpers/dto/domain/access_token.dart';
import '../../../core/domain/entities/usecase.dart';
import '../entities/login_credentials.dart';

abstract class LoginWithEmailAndPassword
    extends UseCase<LoginCredentials, AccessToken> {
  const LoginWithEmailAndPassword()
      : super('app.usecase.loginwithemailandpassword');
}
