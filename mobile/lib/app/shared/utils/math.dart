import 'dart:math' as math;

import 'package:vector_math/vector_math.dart';

class MathUtils {
  static double calculateDiscount(double originalPrice, double salePrice) {
    assert(originalPrice >= 0 && salePrice >= 0);

    return ((-(salePrice) + originalPrice) / originalPrice) * 100;
  }

  static num Function(num xA) interpolate(
    List<num> xInterval,
    List<num> yInterval,
  ) {
    final x0 = xInterval[0];
    final x1 = xInterval[1];

    final y0 = yInterval[0];
    final y1 = yInterval[1];

    num getValueOfInterpolationAt(num xA) {
      if (xA > x1) {
        xA = x1;
      } else if (xA < x0) {
        xA = x0;
      }

      final yA = y0 + (y1 - y0) * ((xA - x0) / (x1 - x0));

      return yA;
    }

    return getValueOfInterpolationAt;
  }

  static double normalizeDegrees(double degrees) {
    return degrees >= 360 ? degrees % 360 : degrees;
  }

  static double toRadian(double angle) {
    final normalAngle = angle % 360;

    return normalAngle * (180 / math.pi);
  }

  static double toDegrees(double radius, double angle) {
    final normalAngle = angle % (2 * math.pi);

    return normalAngle * (math.pi / 180);
  }

  static Vector2 getPointPositionOfCircle(double radius, double angle) {
    return Vector2(
      radius * math.sin(angle),
      radius * math.cos(angle),
    );
  }

  static bool isEven(num number) {
    return number % 2 == 0;
  }

  static num max(List<num> numbers) {
    assert(numbers.isNotEmpty);

    return sortNumbers(numbers.toSet(), (a, b) => b - a).first;
  }

  static num min(List<num> numbers) {
    assert(numbers.isNotEmpty);

    return sortNumbers(numbers.toSet(), (a, b) => a - b).first;
  }

  static List<num> sortNumbers(
    Iterable<num> numbers,
    int Function(num, num) compare,
  ) {
    return [...numbers]..sort(compare);
  }

  static num getValueInRange(num value, {num max, num min}) {
    max ??= value;
    min ??= value;

    return value > max
        ? max
        : value < min
            ? min
            : value;
  }

  static double normalizeValue(double current, double max, double min) {
    final normalized = current <= max && current >= min;

    if (normalized) {
      return current;
    }

    return current >= max
        ? current % max + min
        : normalizeValue(min - current, max, min);
  }

  static num abs(num value) {
    return value < 0 ? -value : value;
  }
}
