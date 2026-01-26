import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../viewmodels/weatheria_view_model.dart';
import '../../../model/daily_forecast_model.dart';

class DailyForecastCard extends StatelessWidget {
  const DailyForecastCard({super.key});

  Widget _buildForecastItem(DailyForecast forecast) {
    final dayName = DateFormat.E().format(forecast.date);

    final iconUrl = "${forecast.iconUrl}_48.png";

    return SizedBox(
      width: 90,
      child: Card(
        color: const Color.fromARGB(255, 49, 52, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(dayName, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),

              /// 🌤 API ICON
              Image.network(
                iconUrl,
                width: 36,
                height: 36,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.wb_cloudy, color: Colors.white),
              ),

              const SizedBox(height: 8),
              Text(
                '${forecast.maxTemp.round()}° / ${forecast.minTemp.round()}°',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();
    final daily = vm.daily;

    if (daily.isEmpty) {
      return const SizedBox();
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "6-Day Forecast",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: daily.take(6).map(_buildForecastItem).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
