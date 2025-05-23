/// Model representing a single grounding step entry.
class GroundingEntry {
  /// The sense associated with this entry.
  final String sense;

  /// List of user provided observations for the sense.
  final List<String> items;

  /// Creates a new [GroundingEntry].
  const GroundingEntry({required this.sense, required this.items});
}
