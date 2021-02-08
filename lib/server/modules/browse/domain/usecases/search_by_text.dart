import '../../../core/domain/entities/usecase.dart';

abstract class SearchByText<I, O> extends UseCase<I, O> {
  const SearchByText() : super('app.usecase.searchbytext');
}
