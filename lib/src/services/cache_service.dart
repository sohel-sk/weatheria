import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/model/place_model.dart';
import 'package:weatheria/src/model/weather_model.dart';

class CacheService {
  static const String boxName = "weatherBox";

  Future<Box> _box() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }
  

  

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


  Future<void> saveLocationState({
    required String locationMode,
    required double lat,
    required double lon,
    required String label,
    required List<PlaceModel> savedLocations,
  }) async {
    final box = await _box();
    await box.put('location_mode', locationMode);
    await box.put('last_lat', lat);
    await box.put('last_lon', lon);
    await box.put('location_label', label);
    await box.put('saved_locations', savedLocations);
  }

  Future<Map<String, dynamic>> loadLocationState() async {
    final box = await _box();

    return {
      "location_mode": box.get('location_mode'),
      "lat": box.get('last_lat'),
      "lon": box.get('last_lon'),
      "label": box.get('location_label'),
      "saved_locations": box.get('saved_locations'),
    };
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
