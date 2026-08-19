import 'package:flutter/material.dart';
import '../models/history_entry.dart';

/// HistoryPage displays a list of past counter actions.
/// It is designed to be responsive and work within the app's navigation structure.
class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
    required this.history,
    required this.onClear,
  });

  /// The list of history records to display.
  final List<HistoryEntry> history;

  /// Callback to clear the history.
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1. Empty State: Show a friendly message if there's no history.
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_toggle_off,
              size: 80,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No history recorded yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start incrementing to see logs here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    // 2. Data State: Display the list of entries.
    // Note: We don't use a Scaffold here anymore to avoid nested AppBars 
    // and conflicting status bar colors.
    return Column(
      children: [
        // Optional: A header for wide screens where the main AppBar might be missing.
        if (MediaQuery.of(context).size.width > 600)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Activity Log',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('Clear All'),
                  style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
                ),
              ],
            ),
          ),
        
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // We reverse the list to show the newest entries at the top.
            itemCount: history.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              // Accessing from end to start
              final entry = history[history.length - 1 - index];
              
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                leading: _buildLeadingIcon(context, entry),
                title: Text(
                  'Value: ${entry.value}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  _formatTimestamp(entry.timestamp),
                  style: theme.textTheme.bodySmall,
                ),
                trailing: Icon(
                  entry.isIncrement ? Icons.add_circle_outline : Icons.remove_circle_outline,
                  color: entry.isIncrement ? Colors.green : Colors.orange,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds a circular icon showing the sequence number of the entry.
  Widget _buildLeadingIcon(BuildContext context, HistoryEntry entry) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: entry.isIncrement 
            ? theme.colorScheme.primaryContainer 
            : theme.colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          entry.isIncrement ? Icons.trending_up : Icons.trending_down,
          size: 20,
          color: entry.isIncrement 
              ? theme.colorScheme.onPrimaryContainer 
              : theme.colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }

  /// Simple timestamp formatter (HH:mm:ss).
  String _formatTimestamp(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return 'Recorded at $h:$m:$s';
  }
}
