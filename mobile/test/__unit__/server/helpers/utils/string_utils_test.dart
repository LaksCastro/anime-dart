import 'package:anime_dart/server/helpers/utils/string_utils.dart';

import 'package:test/test.dart';

void main() {
  group('shuffleString() method', () {
    test('long string', () {
      for (var i = 0; i < 100; i++) {
        final longString =
            '''Maecenas ex neque, pharetra sit amet lacus a, accumsan lacinia ex. Curabitur pulvinar vehicula est, nec suscipit tellus lacinia congue. Aenean est dui, eleifend eu urna sit amet, placerat lacinia tortor.''';

        final result = shuffleString(longString);

        expect(result.length, longString.length);
        expect(result.compareTo(longString) != 0, true);
        expect(result != longString, true);
      }
    });
  });
  group('normalizeString() method', () {
    test('with accent', () {
      for (var i = 0; i < 100; i++) {
        final withAccent = 'á óíóí';

        final normalized = normalizeString(withAccent);

        expect(normalized, 'a oioi');
      }
    });
    test('double space and accent', () {
      for (var i = 0; i < 100; i++) {
        final withAccent = 'á     óíóí';

        final normalized = normalizeString(withAccent);

        expect(normalized, 'a oioi');
      }
    });
    test('double, left and right space + accent', () {
      for (var i = 0; i < 100; i++) {
        final withAccent = '     á     óíóí     ';

        final normalized = normalizeString(withAccent);

        expect(normalized, 'a oioi');
      }
    });
    test('double, left and right space + accent + uppercase', () {
      for (var i = 0; i < 100; i++) {
        final withAccent = '    Á     ÓíóÍ     ';

        final normalized = normalizeString(withAccent);

        expect(normalized, 'a oioi');
      }
    });
  });
  group('hasMatch() method', () {
    test('several search cases', () {
      final target1 = 'A normal string with letters';
      final target2 = 'Other random string';
      final target3 = 'Something is wrong, check for me';

      final search1 = 'nwl';
      final search2 = 'normal letters';
      final search3 = 'oth str';
      final search4 = 'dom sng';
      final search5 = 'atts';
      final search6 = 'th      wgc rm';

      expect(hasMatch(target1, search1), isTrue);
      expect(hasMatch(target2, search1), isFalse);
      expect(hasMatch(target3, search1), isFalse);

      expect(hasMatch(target1, search2), isTrue);
      expect(hasMatch(target2, search2), isFalse);
      expect(hasMatch(target3, search2), isFalse);

      expect(hasMatch(target1, search3), isFalse);
      expect(hasMatch(target2, search3), isTrue);
      expect(hasMatch(target3, search3), isFalse);

      expect(hasMatch(target1, search4), isFalse);
      expect(hasMatch(target2, search4), isTrue);
      expect(hasMatch(target3, search4), isFalse);

      expect(hasMatch(target1, search5), isTrue);
      expect(hasMatch(target2, search5), isFalse);
      expect(hasMatch(target3, search5), isFalse);

      expect(hasMatch(target1, search6), isFalse);
      expect(hasMatch(target2, search6), isFalse);
      expect(hasMatch(target3, search6), isTrue);
    });
  });
}
