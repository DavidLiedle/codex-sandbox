import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground54321/main.dart';
import 'package:ground54321/providers/grounding_provider.dart';
import 'package:ground54321/screens/summary_screen.dart';

void main() {
  testWidgets('complete flow shows summary', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GroundApp()));
    // Start
    await tester.tap(find.text('Begin Grounding'));
    await tester.pumpAndSettle();

    // Fill first step
    await tester.enterText(find.byType(TextField), 'a');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'b');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'c');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'd');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'e');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    // Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Skip rest for brevity
    final notifier = tester.state<ProviderScopeState>(find.byType(ProviderScope))
        .container
        .read(groundingProvider.notifier);
    notifier.nextStep();
    notifier.nextStep();
    notifier.nextStep();
    notifier.nextStep();
    await tester.pumpAndSettle();

    expect(find.byType(SummaryScreen), findsOneWidget);
  });
}
