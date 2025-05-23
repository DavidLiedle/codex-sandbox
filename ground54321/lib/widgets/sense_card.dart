import 'package:flutter/material.dart';

/// Card widget prompting user for sense input.
class SenseCard extends StatelessWidget {
  /// Current sense description.
  final String sense;

  /// Number of remaining observations to collect.
  final int remaining;

  /// Callback when user submits an observation.
  final ValueChanged<String> onSubmit;

  /// Creates a [SenseCard].
  const SenseCard({
    super.key,
    required this.sense,
    required this.remaining,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$sense (${remaining} left)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  onSubmit(value.trim());
                  controller.clear();
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Describe...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
