import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../core/domain/repositories/env_provider.dart';

/// [Presenter], [UI], [Client] context
///
/// This can be any client:
/// - _Server trying to auth throught of a CLI_
/// - _Web App_
/// - _Mobile App_
///
/// [EnvProvider] is the enviroment vars providedr
/// Must be a implementation of [EnvProvider] interface
/// Works as dependency injection
class OAuthContext extends Equatable {
  final Map<String, String> params;
  final EnvProvider env;

  const OAuthContext({
    this.params,
    @required this.env,
  });

  @override
  List<Object> get props => [params, env];
}
