import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';

abstract class NetworkException implements AppException {
  const factory NetworkException.requestCancelled() = RequestCancelled;

  const factory NetworkException.unauthorizedRequest() = UnauthorizedRequest;

  const factory NetworkException.badRequest() = BadRequest;

  const factory NetworkException.notFound() = NotFound;

  const factory NetworkException.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkException.notAcceptable() = NotAcceptable;

  const factory NetworkException.requestTimeout() = RequestTimeout;

  const factory NetworkException.sendTimeout() = SendTimeout;

  const factory NetworkException.conflict() = Conflict;

  const factory NetworkException.internalServerError() = InternalServerError;

  const factory NetworkException.notImplemented() = NotImplemented;

  const factory NetworkException.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkException.noInternetConnection() = NoInternetConnection;

  const factory NetworkException.formatException() = FormatException;

  const factory NetworkException.unableToProcess() = UnableToProcess;

  const factory NetworkException.defaultError(String error) = DefaultError;

  const factory NetworkException.unexpectedError() = UnexpectedError;

  static NetworkException requestException(dynamic e) {
    if (e is! Exception) {
      if (e.toString().contains("is not a subtype of")) {
        return NetworkException.unableToProcess();
      }

      return NetworkException.unexpectedError();
    }

    if (e is SocketException) {
      return NetworkException.noInternetConnection();
    }

    if (e is DioError) {
      final mapError = <DioErrorType, AppException Function()>{
        DioErrorType.CONNECT_TIMEOUT: () => NetworkException.requestTimeout(),
        DioErrorType.RECEIVE_TIMEOUT: () => NetworkException.sendTimeout(),
        DioErrorType.SEND_TIMEOUT: () => NetworkException.sendTimeout(),
        DioErrorType.CANCEL: () => NetworkException.requestCancelled(),
        DioErrorType.DEFAULT: () => NetworkException.defaultError(
              e.error.toString(),
            ),
        DioErrorType.RESPONSE: () {
          final mapStatusCode = <int, NetworkException Function()>{
            400: () => NetworkException.unauthorizedRequest(),
            401: () => NetworkException.unauthorizedRequest(),
            403: () => NetworkException.unauthorizedRequest(),
            404: () => NetworkException.notFound(),
            408: () => NetworkException.requestTimeout(),
            409: () => NetworkException.conflict(),
            500: () => NetworkException.internalServerError(),
            503: () => NetworkException.serviceUnavailable(),
          };

          final defaultError = NetworkException.defaultError(
            "Received invalid status code: ${e.response.statusCode}",
          );

          return mapStatusCode[e.response.statusCode]() ?? defaultError;
        },
      };

      return mapError[e.type].call();
    }

    return NetworkException.unexpectedError();
  }

  static String errorMessage(NetworkException exception) {
    final mapErrorMessage = <Type, String>{
      NotImplemented: 'Not Implemented',
      RequestCancelled: 'Request Cancelled',
      InternalServerError: 'Internal Server Error',
      NotFound: 'Not Found',
      ServiceUnavailable: 'Service Unavailable',
      MethodNotAllowed: 'Method Not Allowed',
      BadRequest: 'Bad Request',
      UnauthorizedRequest: 'Unauthorized Request',
      UnexpectedError: 'Unexpected Error',
      RequestTimeout: 'Request Timeout',
      NoInternetConnection: 'No Internet Connection',
      Conflict: 'Conflict',
      SendTimeout: 'Send Timeout',
      UnableToProcess: 'Unable To Process',
      DefaultError: 'Default Error',
      FormatException: 'Format Exception',
      NotAcceptable: 'Not Acceptable',
    };

    return mapErrorMessage[exception.runtimeType];
  }
}

class RequestCancelled implements NetworkException {
  const RequestCancelled();
}

class UnauthorizedRequest implements NetworkException {
  const UnauthorizedRequest();
}

class BadRequest implements NetworkException {
  const BadRequest();
}

class NotFound implements NetworkException {
  const NotFound();
}

class MethodNotAllowed implements NetworkException {
  const MethodNotAllowed();
}

class NotAcceptable implements NetworkException {
  const NotAcceptable();
}

class ServiceUnavailable implements NetworkException {
  const ServiceUnavailable();
}

class RequestTimeout implements NetworkException {
  const RequestTimeout();
}

class SendTimeout implements NetworkException {
  const SendTimeout();
}

class Conflict implements NetworkException {
  const Conflict();
}

class InternalServerError implements NetworkException {
  const InternalServerError();
}

class NotImplemented implements NetworkException {
  const NotImplemented();
}

class NoInternetConnection implements NetworkException {
  const NoInternetConnection();
}

class FormatException implements NetworkException {
  const FormatException();
}

class UnableToProcess implements NetworkException {
  const UnableToProcess();
}

class DefaultError implements NetworkException {
  final String error;

  const DefaultError(this.error);
}

class UnexpectedError implements NetworkException {
  const UnexpectedError();
}
