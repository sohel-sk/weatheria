import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "25°",
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
        //Text("Hazy clouds • RealFeel 24°",
        //  style: TextStyle(color: Colors.grey)),
        SizedBox(height: 12, width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.cloud_sync, size: 48),
            SizedBox(height: 8),
            Text("Hazy clouds", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text("RealFeel 24°", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
