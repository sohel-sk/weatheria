import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                        
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text("Mon"),
                            const SizedBox(height: 8),
                            const Icon(Icons.wb_sunny),
                            const SizedBox(height: 8),
                            const Text("26° / 18°"),
                          ],
                        ),
                      )
                    ),
                
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
