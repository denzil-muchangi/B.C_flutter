import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.stepSize,
    required this.onStepSizeChanged,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  final int stepSize;
  final ValueChanged<int> onStepSizeChanged;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable or disable dark theme'),
            value: isDarkMode,
            onChanged: (_) => onThemeToggle(),
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Counter Logic',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          ListTile(
            title: const Text('Step Size'),
            subtitle: Text('Current step: $stepSize'),
            leading: const Icon(Icons.exposure),
            trailing: DropdownButton<int>(
              value: stepSize,
              items: [1, 5, 10, 50, 100].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) onStepSizeChanged(val);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Adaptive Counter Pro v1.0'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Adaptive Counter Pro',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(),
              );
            },
          ),
        ],
      ),
    );
  }
}
