import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';
import '../../history/models/history_entry.dart';
import '../../history/view/history_page.dart';
import '../../settings/view/settings_page.dart';

/// CounterPage is the main functional area of the app.
/// It uses a StatefulWidget because it manages the counter value, 
/// the history list, and the current navigation index.
class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // --- APP STATE ---
  int _counter = 0;
  int _stepSize = 1;
  int _selectedIndex = 0; // Tracks which tab (Counter, History, Settings) is active.
  
  /// Stores the detailed log of counter changes.
  final List<HistoryEntry> _history = [];

  // --- LOGIC METHODS ---
  
  /// Increments the counter and logs the new value to history.
  void _increment() {
    setState(() {
      _counter += _stepSize;
      _history.add(HistoryEntry(
        value: _counter,
        timestamp: DateTime.now(),
        isIncrement: true,
      ));
    });
  }

  /// Decrements the counter and logs the new value to history.
  void _decrement() {
    setState(() {
      _counter -= _stepSize;
      _history.add(HistoryEntry(
        value: _counter,
        timestamp: DateTime.now(),
        isIncrement: false,
      ));
    });
  }

  /// Resets everything to initial state.
  void _reset() {
    setState(() {
      _counter = 0;
      _history.clear();
    });
  }

  /// Updates the active tab index.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder detects screen width to decide between Mobile and Wide layouts.
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideLayout();
        }
        return _buildMobileLayout();
      },
    );
  }

  /// Helper to return the correct widget based on the selected tab.
  Widget _getContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildCounterMain();
      case 1:
        return HistoryPage(
          history: _history,
          onClear: () => setState(() => _history.clear()),
        );
      case 2:
        return SettingsPage(
          stepSize: _stepSize,
          onStepSizeChanged: (val) => setState(() => _stepSize = val),
          isDarkMode: widget.isDarkMode,
          onThemeToggle: widget.onThemeToggle,
        );
      default:
        return const Center(child: Text('Coming Soon'));
    }
  }

  /// The main UI for the counter tab.
  Widget _buildCounterMain() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterDisplay(count: _counter),
            const SizedBox(height: 24),
            Text(
              'Step size: $_stepSize',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// UI for Small Screens (Phones).
  /// Uses a Scaffold with a BottomNavigationBar.
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Counter'
            : _selectedIndex == 1
                ? 'History'
                : 'Settings'),
        actions: [
          // Only show reset button when on the Counter tab.
          if (_selectedIndex == 0)
            IconButton(
              onPressed: _reset,
              icon: const Icon(Icons.refresh),
              tooltip: 'Reset',
            ),
          // Clear history button for the History tab.
          if (_selectedIndex == 1 && _history.isNotEmpty)
            IconButton(
              onPressed: () => setState(() => _history.clear()),
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear History',
            ),
        ],
      ),
      body: _getContent(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Counter',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _selectedIndex == 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: _increment,
                  child: const Icon(Icons.add),
                  heroTag: 'inc', // Hero tags must be unique if multiple FABs exist.
                ),
                const SizedBox(height: 16),
                FloatingActionButton.small(
                  onPressed: _decrement,
                  child: const Icon(Icons.remove),
                  heroTag: 'dec',
                ),
              ],
            )
          : null,
    );
  }

  /// UI for Large Screens (Tablets, Desktop).
  /// Uses a Row with a NavigationRail on the left.
  Widget _buildWideLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Vertical navigation menu.
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 900,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.calculate_outlined),
                selectedIcon: Icon(Icons.calculate),
                label: Text('Counter'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: Text('History'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main content area.
          Expanded(
            child: Scaffold(
              appBar: _selectedIndex == 0
                  ? AppBar(
                      title: const Text('Counter Pro'),
                      actions: [
                        IconButton(
                          onPressed: _reset,
                          icon: const Icon(Icons.refresh),
                          tooltip: 'Reset',
                        ),
                      ],
                    )
                  : null,
              body: _getContent(),
              // Horizontal FABs look better on wide screens.
              floatingActionButton: _selectedIndex == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: _decrement,
                          label: const Text('Decrease'),
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 16),
                        FloatingActionButton.extended(
                          onPressed: _increment,
                          label: const Text('Increase'),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
