import 'package:diacritic/diacritic.dart';

import 'random_utils.dart';

/// Simple [algorithm] to [Shuffle] chars of a [String]
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

/// This function will return the same String in param with
/// this changes:
///
/// 1. **[Remove diactrics]** (áéí => aei)
/// 2. Call **[.trim()]** method
/// 3. Call **[.toLowerCase()]** method
/// 4. Remove all **[duplicated spaces]** by **[single space]**
String normalizeString(String target) {
  return removeDiacritics(target)
      .trim()
      .toLowerCase()
      .replaceAll(RegExp('  *'), ' ');
}

/// This function will return **true** if a String [target]
/// contains a substring [text]
///
/// The only difference between native **[.contains()]** method:
/// is that this method not require that substring to be strict
///
/// Example:
/// ```
/// hasMatch('abcdef', 'adf') // true
/// 'abcdef'.contains('adf') // false
/// ```
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
