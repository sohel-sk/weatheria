import 'package:flutter/material.dart';
import 'package:weatheria/src/features/home/presentation/home_screen.dart';
import 'package:weatheria/src/core/theme.dart';

void main() {
  runApp(const WeatheriaApp());
}

class WeatheriaApp extends StatelessWidget {
  const WeatheriaApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatheria',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
