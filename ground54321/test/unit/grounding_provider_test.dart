import 'package:flutter_test/flutter_test.dart';
import 'package:ground54321/providers/grounding_provider.dart';

void main() {
  test('adding items updates state', () {
    final notifier = GroundingNotifier();
    notifier.addItem('item1');
    expect(notifier.state.first.items, ['item1']);
    expect(notifier.stepIndex, 0);
  });

  test('nextStep advances index', () {
    final notifier = GroundingNotifier();
    notifier.nextStep();
    expect(notifier.stepIndex, 1);
  });

  test('reset clears state', () {
    final notifier = GroundingNotifier();
    notifier.addItem('a');
    notifier.nextStep();
    notifier.reset();
    expect(notifier.stepIndex, 0);
    expect(notifier.state, isEmpty);
  });
}
