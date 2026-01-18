class DailyForecast {
  final DateTime date;
  final String description;
  final String iconUrl;
  final double maxTemp;
  final double minTemp;
  final int humidity;
  final int uvIndex;
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
