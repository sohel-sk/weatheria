import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../viewmodels/weatheria_view_model.dart';
import '../../../model/hourly_forecast_model.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key});

  Widget _buildHourItem(HourlyForecast forecast) {
    final timeLabel = DateFormat.j().format(forecast.time);
    final iconUrl = "${forecast.iconUrl}_48.png";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeLabel,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          /// 🌤 API ICON
          Image.network(
            iconUrl,
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.wb_cloudy),
          ),

          const SizedBox(height: 8),
          Text(
            '${forecast.temperature.round()}°',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();
    final hourly = vm.hourly;

    if (hourly.isEmpty) {
      return const SizedBox(); // avoids flicker during loading
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourly.take(6).length,
            itemBuilder: (_, i) {
              return _buildHourItem(hourly[i]);
            },
          ),
        ),
      ),
    );
  }
}
