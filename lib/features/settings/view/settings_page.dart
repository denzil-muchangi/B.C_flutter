import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// SettingsPage allows users to configure the app's behavior and appearance.
/// It uses a StatefulWidget to manage local settings like sound and vibration toggles.
class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.stepSize,
    required this.onStepSizeChanged,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  // These properties are passed down from the parent (CounterApp or CounterPage)
  // because they affect the whole app.
  final int stepSize;
  final ValueChanged<int> onStepSizeChanged;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Local settings that don't need to be global for now.
  bool _vibrationEnabled = true;
  bool _soundEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // LayoutBuilder is the key to responsiveness. 
    // It gives us the 'constraints' (available width/height).
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the screen is wider than 900 logical pixels (like a tablet or desktop),
        // we show a two-column layout. Otherwise, we show a single list.
        if (constraints.maxWidth > 900) {
          return _buildWideLayout(theme);
        }
        return _buildMobileLayout(theme);
      },
    );
  }

  /// Single column layout for Phones.
  Widget _buildMobileLayout(ThemeData theme) {
    return ListView(
      children: _buildSettingsList(theme),
    );
  }

  /// Two-column layout for Tablets and Desktops.
  Widget _buildWideLayout(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Appearance and About
        Expanded(
          flex: 1,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSectionHeader(theme, 'Appearance'),
              ..._buildAppearanceSettings(theme),
              const SizedBox(height: 32),
              _buildSectionHeader(theme, 'About'),
              ..._buildAboutSettings(theme),
            ],
          ),
        ),
        const VerticalDivider(width: 1), // Thin line between columns
        // Right Column: Logic and Feedback
        Expanded(
          flex: 1,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSectionHeader(theme, 'Counter Logic'),
              ..._buildLogicSettings(theme),
              const SizedBox(height: 32),
              _buildSectionHeader(theme, 'Feedback'),
              ..._buildFeedbackSettings(theme),
            ],
          ),
        ),
      ],
    );
  }

  /// Combines all settings groups into a single list for mobile view.
  List<Widget> _buildSettingsList(ThemeData theme) {
    return [
      _buildSectionHeader(theme, 'Appearance'),
      ..._buildAppearanceSettings(theme),
      const Divider(height: 1),
      _buildSectionHeader(theme, 'Counter Logic'),
      ..._buildLogicSettings(theme),
      const Divider(height: 1),
      _buildSectionHeader(theme, 'Feedback'),
      ..._buildFeedbackSettings(theme),
      const Divider(height: 1),
      _buildSectionHeader(theme, 'About'),
      ..._buildAboutSettings(theme),
      const SizedBox(height: 40),
      // A special action button at the bottom.
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings reset to default')),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
            side: BorderSide(color: theme.colorScheme.error),
          ),
          child: const Text('Reset All Settings'),
        ),
      ),
      const SizedBox(height: 20),
    ];
  }

  /// Helper to create consistent looking headers for each category.
  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  /// Appearance Group
  List<Widget> _buildAppearanceSettings(ThemeData theme) {
    return [
      // .adaptive variants automatically switch between Material (Android) 
      // and Cupertino (iOS) styles.
      SwitchListTile.adaptive(
        title: const Text('Dark Mode'),
        subtitle: const Text('Use a darker color palette'),
        value: widget.isDarkMode,
        onChanged: (_) => widget.onThemeToggle(),
        secondary: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
      ),
    ];
  }

  /// Logic Group
  List<Widget> _buildLogicSettings(ThemeData theme) {
    return [
      ListTile(
        title: const Text('Step Size'),
        subtitle: Text('Current increment: ${widget.stepSize}'),
        leading: const Icon(Icons.exposure),
        trailing: DropdownButton<int>(
          underline: const SizedBox(), // Removes the default underline
          value: widget.stepSize,
          items: [1, 5, 10, 25, 50, 100].map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) widget.onStepSizeChanged(val);
          },
        ),
      ),
    ];
  }

  /// Feedback Group
  List<Widget> _buildFeedbackSettings(ThemeData theme) {
    return [
      SwitchListTile.adaptive(
        title: const Text('Vibration'),
        subtitle: const Text('Haptic feedback on interaction'),
        value: _vibrationEnabled,
        onChanged: (val) => setState(() => _vibrationEnabled = val),
        secondary: const Icon(Icons.vibration),
      ),
      SwitchListTile.adaptive(
        title: const Text('Sound Effects'),
        subtitle: const Text('Play sound on increment/decrement'),
        value: _soundEnabled,
        onChanged: (val) => setState(() => _soundEnabled = val),
        secondary: const Icon(Icons.volume_up),
      ),
    ];
  }

  /// About Group
  List<Widget> _buildAboutSettings(ThemeData theme) {
    return [
      ListTile(
        title: const Text('Version'),
        subtitle: const Text('1.2.0 (Build 42)'),
        leading: const Icon(Icons.info_outline),
        onTap: () {
          // showAboutDialog is a built-in Flutter function for legal/version info.
          showAboutDialog(
            context: context,
            applicationName: 'Adaptive Counter Pro',
            applicationVersion: '1.2.0',
            applicationIcon: const FlutterLogo(size: 40),
            children: const [
              Text('A professional, multi-platform counter application built with Flutter.'),
            ],
          );
        },
      ),
      ListTile(
        title: const Text('Licenses'),
        leading: const Icon(Icons.description_outlined),
        onTap: () => showLicensePage(context: context),
      ),
    ];
  }
}
