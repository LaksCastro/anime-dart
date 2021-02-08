import '../../../core/domain/entities/usecase.dart';
import '../entities/plugin/plugin.dart';

abstract class SearchPluginsByText extends UseCase<String, List<Plugin>> {
  const SearchPluginsByText(String name) : super(name);
}
