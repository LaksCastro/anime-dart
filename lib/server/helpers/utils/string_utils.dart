import 'package:diacritic/diacritic.dart';

import 'random_utils.dart';

String shuffleString(String target) {
  final chars = target.split('');

  for (var i = 0; i < chars.length; i++) {
    final temp = chars[i];

    final randomI = randomInt(max: chars.length, min: 0);

    chars[i] = chars[randomI];
    chars[randomI] = temp;
  }

  return chars.join();
}

String normalizeString(String target) {
  return removeDiacritics(target)
      .trim()
      .toLowerCase()
      .replaceAll(RegExp('  *'), ' ');
}

bool hasMatch(String target, String text) {
  text = normalizeString(text).replaceAll(' ', '');
  target = normalizeString(target).replaceAll(' ', '');

  final query = text.split('');

  for (var i = 0, m = 0; i < query.length; i++, m++) {
    final id = target.indexOf(query[i]);

    if (id == -1) return false;

    if (m == query.length - 1) return true;

    target = target.substring(id + 1);
  }

  return true;
}
