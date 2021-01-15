import 'package:anime_dart/app/shared/interfaces/state_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MockCounterController should not fire listeners', () {
    final mockCounterController = MockCounterController();

    mockCounterController.addListener(() {
      throw Exception('Should not call the listener');
    });

    mockCounterController.increment();

    expect(mockCounterController.state, 1);
  });

  test('MockCounterController should fire listeners', () {
    final mockCounterController = MockCounterController();

    var called = false;

    mockCounterController.addListener(() {
      called = true;
    });

    mockCounterController.incrementAsAction();

    expect(called, true);
  });
}

class MockCounterController extends StateController {
  int state = 0;

  void increment() {
    state++;
  }

  void incrementAsAction() {
    setState(() => state++);
  }
}
