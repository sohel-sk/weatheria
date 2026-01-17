import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: const [
                    Text("8 PM"),
                    SizedBox(height: 8),
                    Icon(Icons.nights_stay),
                    SizedBox(height: 8),
                    Text("22°"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
