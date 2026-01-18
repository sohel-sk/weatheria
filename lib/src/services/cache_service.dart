import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/model/weather_model.dart';

class CacheService {
  static const String boxName = "weatherBox";

  Future<Box> _box() async => await Hive.openBox(boxName);

  Future<void> saveAll({
    required WeatherModel weather,
    required List<HourlyForecast> hourly,
    required List<DailyForecast> daily,
  }) async {
    final box = await _box();

    box.put("weather", weather);
    box.put("hourly", hourly);
    box.put("daily", daily);
    box.put("timestamp", DateTime.now().toIso8601String());
  }

  Future<Map<String, dynamic>> loadAll() async {
    final box = await _box();

    if (!box.containsKey("weather")) return {};

    return {
      "weather": box.get("weather"),
      "hourly": box.get("hourly"),
      "daily": box.get("daily"),
    };
  }
}
