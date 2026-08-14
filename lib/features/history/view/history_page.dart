import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
    required this.history,
    required this.onClear,
  });

  final List<int> history;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No history yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed: onClear,
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final val = history[history.length - 1 - index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text('${history.length - index}'),
            ),
            title: Text(
              'Counter value: $val',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Recorded at ${DateTime.now().hour}:${DateTime.now().minute}'),
            trailing: Icon(
              val >= 0 ? Icons.trending_up : Icons.trending_down,
              color: val >= 0 ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
