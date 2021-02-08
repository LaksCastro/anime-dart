import 'package:equatable/equatable.dart';

import '../../../../helpers/dto/domain/access_token.dart';

class OAuthSuccess extends Equatable {
  final AccessToken accessToken;

  const OAuthSuccess(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}
