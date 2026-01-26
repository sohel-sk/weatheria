import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/model/place_model.dart';
import 'package:weatheria/src/model/weather_model.dart';
import 'package:weatheria/src/services/cache_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatheria/src/services/location_service.dart';
import 'package:weatheria/src/services/places_service.dart';

import '../services/weather_service.dart';

class WeatheriaRepository {
  final WeatherService _weatherService = WeatherService();
  final CacheService _cache = CacheService();
  final LocationService _locationService = LocationService();
  final PlacesService _places = PlacesService();

  Future<List<PlaceModel>> searchPlaces(String query) {
    return _places.searchPlaces(query);
  }

  Future fetchWeather(double lat, double lng) {
    return _weatherService.fetchAll(lat: lat, lon: lng);
  }

  Future<Position> getCurrentPosition() async {
    return await _locationService.getCurrentLocation();
  }

  Future fetchDailyForecast(double lat, double lon) =>
      _weatherService.fetchDailyForecast(lat: lat, lon: lon);

  Future fetchCurrentWeather(double lat, double lon) =>
      _weatherService.fetchCurrentConditions(lat: lat, lon: lon);

  Future getCityName(double lat, double lon) =>
      _locationService.getCityFromCoordinates(lat, lon);

  Future fetchHourlyForecast(double lat, double lon) =>
      _weatherService.fetchHourlyForecast(lat: lat, lng: lon);

  Future saveCache({required WeatherModel weatherData,required List<DailyForecast> daily,required List<HourlyForecast> hourly}) => _cache.saveAll(
    weather: weatherData,
    daily: daily,
    hourly: hourly,
  );
}
