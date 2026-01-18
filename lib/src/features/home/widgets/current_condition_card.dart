import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/src/viewmodels/weatheria_view_model.dart';

class CurrentConditionsCard extends StatelessWidget {
  const CurrentConditionsCard({super.key});

  Widget _item(String label, String value, IconData icon) {
    return SizedBox.expand(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: const Color.fromARGB(255, 49, 52, 56),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, color: Colors.white),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
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
    final weather = vm.weatherData;

    // 🔒 SAFE GUARD — prevents rebuild crashes
    if (weather == null ) {
      return const SizedBox();
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.75,
          ),
          children: [
            _item(
              'AQI',
              '114', // e.g. "Good", "Moderate"
              Icons.safety_check_rounded,
            ),
            _item(
              'UV Index',
              weather.uvIndex.toString(),
              Icons.wb_sunny,
            ),
            _item(
              'Wind',
              '${weather.windSpeed} km/h',
              Icons.air,
            ),
            _item(
              'Pressure',
              '${weather.pressure.round()} hPa',
              Icons.speed,
            ),
            _item(
              'Humidity',
              '${weather.humidity}%',
              Icons.water_drop,
            ),
            _item(
              'Dew Point',
              '12°',
              Icons.water_drop,
            ),
          ],
        ),
      ),
    );
  }
}
