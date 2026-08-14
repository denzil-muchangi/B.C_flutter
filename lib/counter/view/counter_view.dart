import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() => _counter--);
  void _reset() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop/Tablet Layout
        if (constraints.maxWidth > 600) {
          return _buildWideLayout();
        }
        // Mobile Layout
        return _buildMobileLayout();
      },
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        centerTitle: true,
      ),
      body: CounterDisplay(count: _counter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: _decrement,
            label: const Text('Decrease'),
            icon: const Icon(Icons.remove),
            heroTag: 'dec',
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: _increment,
            label: const Text('Increase'),
            icon: const Icon(Icons.add),
            heroTag: 'inc',
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail for Desktop/Tablet Feel
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 900,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.calculate),
                label: Text('Counter'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                label: Text('History'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: 0,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: const Text('Counter Pro'),
                  actions: [
                    IconButton(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset',
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CounterDisplay(count: _counter),
                          const SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _decrement,
                                icon: const Icon(Icons.remove),
                                label: const Text('Decrease'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                              ),
                              const SizedBox(width: 24),
                              ElevatedButton.icon(
                                onPressed: _increment,
                                icon: const Icon(Icons.add),
                                label: const Text('Increase'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
