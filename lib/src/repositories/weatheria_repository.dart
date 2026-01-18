import 'package:weatheria/src/model/weather_model.dart';
import 'package:weatheria/src/services/cache_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatheria/src/services/location_service.dart';

import '../services/weather_service.dart';

class WeatheriaRepository {
  final WeatherService _weatherService = WeatherService();
  final CacheService _cache = CacheService();
  final LocationService _locationService = LocationService();

  Future<Position> getCurrentPosition() async {
    return await _locationService.getCurrentLocation();
  }

  Future fetchCurrentWeather(double lat, double lon) =>
      _weatherService.fetchCurrentConditions(lat: lat, lon: lon);
  

  Future saveCache({required WeatherModel weatherData}) => _cache.saveAll(
    weather: weatherData,
    daily: List.empty(),
    hourly: List.empty(),
  );
}
