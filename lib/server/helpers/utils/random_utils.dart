import 'dart:math';

final random = Random();

final randomSecure = Random.secure();

double randomDouble({
  bool secure = false,
  double max = 1.0,
  double min = 0.0,
}) {
  return min + _randomValue(secure, max, min);
}

int randomInt({
  bool secure = false,
  int max = 100,
  int min = 0,
}) {
  return min + _randomValue(secure, max.toDouble(), min.toDouble()).toInt();
}

String secureRandomString({int length = 128, String charset}) {
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
