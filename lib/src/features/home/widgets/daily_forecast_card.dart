import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key});

  Widget _buildForecastItem(String day, IconData icon, String tempRange) {
    return Card(
      color: const Color.fromARGB(255, 49, 52, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(day),
            const SizedBox(height: 8),
            Icon(icon),
            const SizedBox(height: 8),
            Text(tempRange),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: const [
                  Text(
                    textAlign: TextAlign.left,
                    "6-Day Forecast",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildForecastItem("Sun", Icons.wb_sunny, "26° / 18°"),
                    _buildForecastItem("Mon", Icons.cloudy_snowing, "26° / 18°"),
                    _buildForecastItem("Tue", Icons.cloud, "26° / 18°"),
                    _buildForecastItem("Wed", Icons.sunny_snowing, "26° / 18°"),
                    _buildForecastItem("Thu", Icons.wb_sunny, "26° / 18°"),
                    _buildForecastItem("Fri", Icons.cloud_sync, "26° / 18°"),
                    _buildForecastItem("Sat", Icons.wb_sunny, "26° / 18°"),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
