import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'oauth_context.dart';

class OAuthRequest extends Equatable {
  final String codeChallenge;
  final String state;
  final String url;
  final OAuthContext context;

  const OAuthRequest({
    this.codeChallenge,
    this.state,
    @required this.url,
    @required this.context,
  });

  @override
  List<Object> get props => [codeChallenge, state, url];
}
