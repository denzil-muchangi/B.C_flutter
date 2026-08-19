/// Represents a single record in the counter history.
class HistoryEntry {
  const HistoryEntry({
    required this.value,
    required this.timestamp,
    required this.isIncrement,
  });

  /// The resulting value of the counter after this entry.
  final int value;

  /// The exact time when this change was recorded.
  final DateTime timestamp;

  /// Whether this entry was an increment or decrement.
  final bool isIncrement;
}
