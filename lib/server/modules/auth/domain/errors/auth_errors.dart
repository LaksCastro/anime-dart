import '../../../../helpers/errors/app_exception.dart';

/// User denied [OAuth] request
class OAuthAccessDenied implements AppException {}

/// Login with [email] and [password] failed with
///
/// status code [401] or related indicating that
///
/// email or password is invalid
class InvalidCredentials implements AppException {}

/// Generally throwed when you try call [RequestOAuthToken] usecase
///
/// before [RequestOAuthCode] usecase
///
/// See more about [OAuth flow here](https://myanimelist.net/blog.php?eid=835707)
class InvalidOAuthRequest implements AppException {}

/// This indicates an OAuth redirect of unknown origin
///
/// That is, the redirect uri has a [Request Id]
///
/// that doesn't match with any current in memory cached [Request Id].
///
/// So, it can be a authorization code interception attacks, so
///
/// this redirect must be ignored.
///
/// Try [to init a new OAuth flow](https://myanimelist.net/blog.php?eid=835707)
class ForbiddenUnknownRequest implements AppException {}

/// Something is wrong with [code] or [code_verifier]
///
/// Typically this indicates that [token] is no longer valid
///
/// So, try use [refresh_token] to generate a new token
///
/// If error persist rerun OAuth flow
class InvalidOAuthCredentials implements AppException {}
