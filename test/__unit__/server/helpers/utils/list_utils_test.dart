import 'package:anime_dart/server/helpers/utils/list_utils.dart';
import 'package:test/test.dart';

void main() {
  group('hasIntersection() method', () {
    test('simple operation', () {
      final a1 = [1, 2, 3, 4];
      final b1 = [9, 7, 4];

      final a2 = [1, 3, 6, 9];
      final b2 = [0, 3, 1];

      final a3 = [0, 0, 0, 0];
      final b3 = [0, 0, 0, 0];

      final a4 = [0, 0, 0, 0];
      final b4 = [1, 1, 1, 1];

      final a5 = [0, 3, 0, 0];
      final b5 = [2, 1, 1, 2];

      final a6 = [3, 5, 2, 6];
      final b6 = [9, 2, 4, 6];

      expect(hasIntersection(a1, b1), true);
      expect(hasIntersection(a2, b2), true);
      expect(hasIntersection(a3, b3), true);
      expect(hasIntersection(a4, b4), false);
      expect(hasIntersection(a5, b5), false);
      expect(hasIntersection(a6, b6), true);
    });
    test('empty context', () {
      final a1 = [1, 2, 3, 4];
      final b1 = [];

      final a2 = [];
      final b2 = [0, 3, 1];

      final a3 = [0];
      final b3 = [];

      final a4 = [];
      final b4 = [];

      expect(hasIntersection(a1, b1), false);
      expect(hasIntersection(a2, b2), false);
      expect(hasIntersection(a3, b3), false);
      expect(hasIntersection(a4, b4), false);
    });
  });
}
