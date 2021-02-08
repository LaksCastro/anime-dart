import 'package:app_utils/utils.dart';

import 'package:test/test.dart';

void main() {
  final precision = 5000;

  group('randomInt() method', () {
    test('positive numbers', () {
      final min = 0, max = 5;

      final results = <int>[
        for (var i = 0; i < precision; i++) randomInt(min: min, max: max)
      ];

      for (final result in results) {
        expect(result, greaterThanOrEqualTo(min));
        expect(result, lessThan(max));
      }
    });
    test('negative numbers', () {
      final min = -10, max = 0;

      final results = <int>[
        for (var i = 0; i < precision; i++) randomInt(min: min, max: max)
      ];

      for (final result in results) {
        expect(result, greaterThanOrEqualTo(min));
        expect(result, lessThan(max));
      }
    });
    test('zero range', () {
      final value = -10;

      final results = <int>[
        for (var i = 0; i < precision; i++) randomInt(min: value, max: value),
      ];

      for (final result in results) {
        expect(result, equals(value));
      }
    });
    test('max and min values', () {
      final min = 0, max = 2;

      final results = <int>[
        for (var i = 0; i < precision; i++) randomInt(min: min, max: max),
      ];

      for (final result in results) {
        expect(result, greaterThanOrEqualTo(min));
        expect(result, lessThan(max));
        expect(result == 1 || result == 0, isTrue);
      }

      expect(results.any((result) => result == min), isTrue);
    });
    test('invalid range', () {
      final min = -10, max = -20;

      List<int> getResults() => <int>[
            for (var i = 0; i < precision; i++) randomInt(min: min, max: max),
          ];

      expect(getResults, throwsA(isA<AssertionError>()));
    });
  });
  group('randomDouble() method', () {
    test('positive numbers', () {
      final min = 0.0, max = 5.0;

      final results = <double>[
        for (var i = 0; i < precision; i++) randomDouble(min: min, max: max)
      ];

      for (final result in results) {
        expect(result, greaterThanOrEqualTo(min));
        expect(result, lessThan(max));
      }

      expect(results.any((result) => result % 1 != 0), isTrue);
    });

    test('negative numbers', () {
      final min = -10.0, max = 0.0;

      final results = <double>[
        for (var i = 0; i < precision; i++) randomDouble(min: min, max: max)
      ];

      for (final result in results) {
        expect(result, greaterThanOrEqualTo(min));
        expect(result, lessThan(max));
      }

      expect(results.any((result) => result % 1 != 0.0), isTrue);
    });
    test('zero range', () {
      final value = -10.5;

      final results = <double>[
        for (var i = 0; i < precision; i++) randomDouble(min: value, max: value)
      ];

      for (final result in results) {
        expect(result, equals(value));
      }
    });
    test('invalid range', () {
      final min = -10.0, max = -15.0;

      List<double> getResults() => <double>[
            for (var i = 0; i < precision; i++)
              randomDouble(min: min, max: max),
          ];

      expect(getResults, throwsA(isA<AssertionError>()));
    });
    test('max and min values', () {
      final min = 0.0, max = 2.0;

      final results = <double>[
        for (var i = 0; i < precision; i++) randomDouble(min: min, max: max),
      ];

      for (final result in results) {
        expect(result, lessThan(max));
      }
    });
  });
  group('secureString() method', () {
    test('basic usage', () {
      expect(secureString(length: 0).length, 0);
      expect(secureString(length: 10).length, 10);
      expect(secureString(length: 1).length, 1);

      final regExp1 = RegExp('^[a-z]{5}\$');
      final regExp2 = RegExp('^[a-e]{5}\$');

      expect(
        secureString(length: 5, charset: 'abcdefghijklmnopqrstuvwxyz').length,
        5,
      );

      expect(
        regExp1.hasMatch(
          secureString(length: 5, charset: 'abcdefghijklmnopqrstuvwxyz'),
        ),
        isTrue,
      );
      expect(
        regExp2.hasMatch(
          secureString(length: 5, charset: 'abcde'),
        ),
        isTrue,
      );
    });
  });
}
