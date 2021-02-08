DateTime fromSeconds(int seconds, [DateTime baseDate]) {
  baseDate ??= DateTime.now().toUtc();

  final duration = Duration(seconds: seconds);

  return baseDate.add(duration);
}

DateTime fromMilliseconds(int milliseconds, [DateTime baseDate]) {
  final seconds = milliseconds ~/ 1000;

  return fromSeconds(seconds, baseDate);
}
