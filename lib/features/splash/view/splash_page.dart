import 'package:flutter/material.dart';

/// SplashPage is the initial screen shown to the user.
/// It uses a StatefulWidget because it needs to manage an animation controller
/// and a timer for the transition.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onComplete});

  /// A callback that is triggered when the splash animation and delay are finished.
  final VoidCallback onComplete;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  // AnimationController handles the timing and progression of the animation.
  late AnimationController _controller;
  // Animation defines the curve and range of the value change.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the controller with a duration.
    _controller = AnimationController(
      vsync: this, // vsync prevents animations from consuming resources when the screen is off.
      duration: const Duration(milliseconds: 1500),
    );

    // 2. Define the animation curve (smooth start and end).
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // 3. Start the animation.
    _controller.forward().then((_) {
      // 4. Once animation finishes, wait a brief moment then notify the parent app.
      Future.delayed(const Duration(milliseconds: 500), widget.onComplete);
    });
  }

  @override
  void dispose() {
    // CRITICAL: Always dispose of controllers to prevent memory leaks.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          // FadeTransition uses the animation value (0.0 to 1.0) to set opacity.
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular container for the app icon.
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.calculate,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Counter Pro',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 8),
              // A small progress indicator to show the app is "loading".
              const SizedBox(
                width: 40,
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
