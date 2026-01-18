class WeatherModel {
  final String description;
  final String iconUrl;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int uvIndex;
  final double pressure;
  final double windSpeed;
  final String windDirection;
  final int visibility;
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
