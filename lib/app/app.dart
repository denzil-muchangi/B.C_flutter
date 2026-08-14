import 'package:flutter/material.dart';
import '../counter/view/counter_view.dart';
import 'theme/theme.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Counter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const CounterView(),
    );
  }
}
