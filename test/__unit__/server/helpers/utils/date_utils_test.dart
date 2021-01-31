import 'package:anime_dart/server/helpers/utils/date_utils.dart';
import 'package:anime_dart/server/helpers/utils/list_utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromSeconds() method', () {
    test('simple operation', () {
      final base = DateTime.now();

      final minute1 = Duration(minutes: 60);

      expect(fromSeconds(minute1.inSeconds, base), equals(base.add(minute1)));
    });
  });
  group('fromMilliseconds() method', () {
    test('simple operation', () {
      final base = DateTime.now();

      final minute1 = Duration(minutes: 60);

      expect(
        fromMilliseconds(minute1.inMilliseconds, base),
        equals(
          base.add(minute1),
        ),
      );
    });
  });
}
