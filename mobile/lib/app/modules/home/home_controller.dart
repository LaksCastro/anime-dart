import '../../shared/state/state.dart';

class HomeController extends StateController {
  int count = 0;

  bool get isZero => count == 0;

  @override
  void dispose() {
    super.dispose();
  }

  @action
  void increment() => setState(() => ++count);
}
