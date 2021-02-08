/// Create a future Date from [now] by default
///
/// Used generally to create a [DateTime] expiration context
///
/// Like a [token] or [user action]
///
/// **[seconds]  - Seconds in future**
///
/// **[baseDate] - Date to add the seconds, DateTime.now() by default**
DateTime fromSeconds(int seconds, [DateTime baseDate]) {
  baseDate ??= DateTime.now().toUtc();

  final duration = Duration(seconds: seconds);

  return baseDate.add(duration);
}

/// Create a future Date from [now] by default
///
/// Used generally to create a [DateTime] expiration context
///
/// Like a [token] or [user action]
///
/// **[milliseconds]  - milliseconds in future**
///
/// **[baseDate] - Date to add the milliseconds, DateTime.now() by default**
DateTime fromMilliseconds(int milliseconds, [DateTime baseDate]) {
  final seconds = milliseconds ~/ 1000;

  return fromSeconds(seconds, baseDate);
}
