import 'weather_model.dart';
import 'daily_forecast_model.dart';
import 'hourly_forecast_model.dart';

class WeatherBundle {
  final WeatherModel current;
  final List<DailyForecast> daily;
  final List<HourlyForecast> hourly;

  WeatherBundle({
    required this.current,
    required this.daily,
    required this.hourly,
  });
}
