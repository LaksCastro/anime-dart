import 'dart:math';

/// Native `Random()` class instance
final random = Random();

/// Native `Random.secure()` class instance
final randomSecure = Random.secure();

/// Generate a random double between [min] (inclusive) and [max] (exclusive)
/// Set [secure] to true for cryptographic purposes
double randomDouble({
  bool secure = false,
  double max = 1.0,
  double min = 0.0,
}) {
  return min + _randomValue(secure, max, min);
}

/// Generate a random int between [min] (inclusive) and [max] (exclusive)
/// Set [secure] to true for cryptographic purposes
int randomInt({
  bool secure = false,
  int max = 100,
  int min = 0,
}) {
  return min + _randomValue(secure, max.toDouble(), min.toDouble()).toInt();
}

/// Generate a random String of length [length] from charset config [charset]
String secureString({int length = 128, String charset}) {
  final defaultCharset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHYJKLMNOPQRSTUVWXYZ0123456789~_-.';

  charset ??= defaultCharset;

  var string = '';

  while (string.length < length) {
    string += charset[_secureIntBetween(0, charset.length)];
  }

  return string;
}

Random _getRandom(bool secure) => secure ? randomSecure : random;

double _randomValue(bool secure, double max, double min) {
  final context = _getRandom(secure);

  final randomFactor = context.nextDouble();

  final diff = max - min;

  assert(diff >= 0);

  final value = diff * randomFactor;

  return value;
}

int _secureIntBetween(int min, int max) => randomInt(
      secure: true,
      min: min,
      max: max,
    );
