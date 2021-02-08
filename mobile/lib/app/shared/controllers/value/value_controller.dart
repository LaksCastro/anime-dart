import '../../state/state.dart';

class ValueController<T extends Object> extends StateController {
  T value;

  ValueController(this.value);

  @action
  void set(T newValue) => setState(() => value = newValue);
}
