import 'package:flutter/material.dart';
import '../features/counter/view/counter_page.dart';
import '../features/splash/view/splash_page.dart';
import 'theme/theme.dart';

/// CounterApp is the root widget of the application.
/// It uses a StatefulWidget to manage global app states like theme and splash visibility.
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // Local state for the app theme (Light, Dark, or System).
  ThemeMode _themeMode = ThemeMode.system;
  
  // Controls whether to show the splash screen or the main counter.
  bool _showSplash = true;

  /// Helper method to toggle between light and dark themes.
  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the configuration hub for your app (routing, themes, etc.).
    return MaterialApp(
      title: 'Adaptive Counter',
      debugShowCheckedModeBanner: false,
      
      // We define both Light and Dark themes. Flutter switches between them 
      // based on the _themeMode variable.
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,

      // Logic to switch between SplashPage and the main CounterPage.
      home: _showSplash
          ? SplashPage(
              onComplete: () => setState(() => _showSplash = false),
            )
          : CounterPage(
              onThemeToggle: toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
            ),
    );
  }
}
