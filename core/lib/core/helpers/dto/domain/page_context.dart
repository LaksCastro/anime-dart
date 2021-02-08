import 'package:equatable/equatable.dart';

class PageContext<T> extends Equatable {
  final List<T> items;
  final bool hasMore;

  const PageContext(
    this.items, {
    this.hasMore,
  });

  @override
  List<Object> get props => [...items, hasMore];
}
