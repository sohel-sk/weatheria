import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/weatheria_view_model.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();
    final weather = vm.weatherData;

    if (weather == null) {
      return const SizedBox(); // avoids flicker during loading
    }

    final iconUrl = "${weather.iconUrl}_64.png";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weather.temperature.round()}°',
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🌤 API ICON
            Image.network(
              iconUrl,
              width: 48,
              height: 48,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.wb_cloudy, size: 48),
            ),
            const SizedBox(height: 8),
            Text(
              weather.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'RealFeel ${weather.feelsLike.round()}°',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
