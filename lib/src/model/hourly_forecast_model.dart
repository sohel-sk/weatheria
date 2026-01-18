class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String description;
  final String iconUrl;
  final bool isDaytime;
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
