/// Generic function to verify if two [Iterables]
/// has at least one item in commom
///
/// **True** if has intersection, otherwise, false
bool hasIntersection<T>(Iterable<T> a, Iterable<T> b) {
  return a.any((a) => b.any((b) => b == a));
}
