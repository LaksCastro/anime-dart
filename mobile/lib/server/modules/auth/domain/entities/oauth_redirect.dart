import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'oauth_request.dart';

/// Representation of a [Authorization Request] **redirect response**
///
/// Not the [Authorization Request] itself, but the redirect
///
/// [Details described here at 1.1 Protocol Flow at step B)](https://tools.ietf.org/html/rfc7636#section-1.1)
class OAuthRedirect<T extends Object> extends Equatable {
  /// Holds the original/previous [Authorization Request]
  final OAuthRequest originalRequest;

  /// The redirect url, with the [Authorization Code] and [State]
  final String redirectUrl;

  /// Dependecy injection for an Http Client
  ///
  /// Allow [real implementation] or [mock] for tests purpose
  final Dio httpClient;

  const OAuthRedirect({
    @required this.originalRequest,
    @required this.redirectUrl,
    @required this.httpClient,
  });

  @override
  List<Object> get props => [originalRequest, redirectUrl];
}
