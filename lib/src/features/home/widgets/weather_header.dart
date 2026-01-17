import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("25°", style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
        Text("Hazy clouds • RealFeel 24°",
            style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
