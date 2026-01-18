import 'package:flutter/material.dart';
import 'package:weatheria/src/features/search/presentation/location_select.dart';
import 'package:weatheria/src/features/home/widgets/weather_header.dart';
import '../widgets/current_condition_card.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/daily_forecast_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nagpur, Maharashtra"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationSearch()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationSearch()),
              );
            },
          ),
          IconButton(
            onPressed: () {
              //
            },
          icon: const Icon(Icons.refresh),
          ),
          
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          WeatherHeader(),
          SizedBox(height: 16),
          CurrentConditionsCard(),
          SizedBox(height: 16),
          HourlyForecast(),
          SizedBox(height: 16),
          DailyForecast(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
