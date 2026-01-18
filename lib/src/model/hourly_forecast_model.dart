import 'package:hive/hive.dart';

part 'hourly_forecast_model.g.dart';

@HiveType(typeId: 2)
class HourlyForecast {
  @HiveField(0)
  final DateTime time;
  @HiveField(1)
  final double temperature;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String iconUrl;
  @HiveField(4)
  final bool isDaytime;
  @HiveField(5)
  final int rainProbability;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.description,
    required this.iconUrl,
    required this.isDaytime,
    required this.rainProbability,
  });
}
