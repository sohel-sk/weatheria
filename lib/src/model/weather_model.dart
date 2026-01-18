import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel {
  @HiveField(0)
  final String description;
  @HiveField(1)
  final String iconUrl;
  @HiveField(2)
  final double temperature;
  @HiveField(3)
  final double feelsLike;
  @HiveField(4)
  final int humidity;
  @HiveField(5)
  final int uvIndex;
  @HiveField(6)
  final double pressure;
  @HiveField(7)
  final double windSpeed;
  @HiveField(8)
  final String windDirection;
  @HiveField(9)
  final int visibility;
  @HiveField(10)
  final bool isDaytime;

  WeatherModel({
    required this.description,
    required this.iconUrl,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.uvIndex,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.isDaytime,
  });
}
