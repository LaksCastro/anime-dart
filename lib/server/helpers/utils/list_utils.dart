bool hasIntersection<T>(Iterable<T> a, Iterable<T> b) {
  return a.any((a) => b.any((b) => b == a));
}
