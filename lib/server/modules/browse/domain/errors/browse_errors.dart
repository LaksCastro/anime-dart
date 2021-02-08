import '../../../../helpers/errors/app_exception.dart';

/// Indicate that a plugin/source don't support the target [UseCase]
class UnsupportedUseCaseException implements AppException {}

/// Indicate that a plugin/source don't support the target [MediaType]
class UnsupportedMediaTypeException implements AppException {}
