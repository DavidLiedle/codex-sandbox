import 'package:flutter/material.dart';

/// Simple horizontal progress indicator for the stepper.
class StepProgressIndicator extends StatelessWidget {
  /// Current step index.
  final int step;

  /// Total number of steps.
  final int total;

  /// Creates a [StepProgressIndicator].
  const StepProgressIndicator({
    super.key,
    required this.step,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: (step + 1) / total);
  }
}
