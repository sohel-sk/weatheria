import 'package:hive/hive.dart';

part 'daily_forecast_model.g.dart';

@HiveType(typeId: 3)
class DailyForecast {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String iconUrl;
  @HiveField(3)
  final double maxTemp;
  @HiveField(4)
  final double minTemp;
  @HiveField(5)
  final int humidity;
  @HiveField(6)
  final int uvIndex;
  @HiveField(7)
  final int rainProbability;

  DailyForecast({
    required this.date,
    required this.description,
    required this.iconUrl,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.uvIndex,
    required this.rainProbability,
  });
}
