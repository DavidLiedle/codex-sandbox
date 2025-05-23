import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/grounding_entry.dart';

/// Possible grounding senses in order.
const senses = [
  'SEE',
  'FEEL',
  'HEAR',
  'SMELL',
  'TASTE',
];

/// Required item counts for each sense.
const senseCounts = [5, 4, 3, 2, 1];

/// Provider managing the current grounding process state.
class GroundingNotifier extends StateNotifier<List<GroundingEntry>> {
  GroundingNotifier() : super([]);

  /// Current step index (0-4).
  int stepIndex = 0;

  /// Adds an item for the current sense.
  void addItem(String item) {
    final sense = senses[stepIndex];
    if (state.length <= stepIndex) {
      state = [
        ...state,
        GroundingEntry(sense: sense, items: [item])
      ];
    } else {
      final entry = state[stepIndex];
      state = [
        ...state.sublist(0, stepIndex),
        GroundingEntry(
          sense: entry.sense,
          items: [...entry.items, item],
        ),
        ...state.sublist(stepIndex + 1),
      ];
    }
  }

  /// Advances to the next sense step.
  void nextStep() {
    if (stepIndex < senses.length - 1) {
      stepIndex++;
    }
  }

  /// Resets the entire flow.
  void reset() {
    stepIndex = 0;
    state = [];
  }
}

/// Riverpod provider for [GroundingNotifier].
final groundingProvider =
    StateNotifierProvider<GroundingNotifier, List<GroundingEntry>>(
        (ref) => GroundingNotifier());
