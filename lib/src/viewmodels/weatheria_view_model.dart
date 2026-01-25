import 'package:flutter/material.dart';
import 'package:weatheria/src/core/app_state.dart';
import 'package:weatheria/src/model/weather_model.dart';
import 'package:weatheria/src/model/place_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/repositories/weatheria_repository.dart';

class WeatheriaViewModel extends ChangeNotifier {
  final WeatheriaRepository _repo = WeatheriaRepository();

  AppStatus appStatus = AppStatus.idle;
  String? errorMessage;

  /// 🔑 SOURCE OF TRUTH
  LocationMode locationMode = LocationMode.gps;

  String locationLabel = "Current Location";
  double? latitude;
  double? longitude;

  WeatherModel? weatherData;
  List<HourlyForecast> hourly = [];
  List<DailyForecast> daily = [];

  bool isSearching = false;
  List<PlaceModel> places = [];

  final List<PlaceModel> savedLocations = [];

  bool _alreadySaved(PlaceModel place) {
    return savedLocations.any((p) => p.lat == place.lat && p.lng == place.lng);
  }

  // ================= GPS FLOW =================

  Future<void> loadByGPS() async {
    try {
      locationMode = LocationMode.gps;
      appStatus = AppStatus.loading;
      notifyListeners();

      final pos = await _repo.getCurrentPosition();

      latitude = pos.latitude;
      longitude = pos.longitude;

      locationLabel = await _repo.getCityName(latitude!, longitude!);

      await _loadAll(latitude!, longitude!);

      appStatus = AppStatus.success;
      notifyListeners();
    } catch (e) {
      appStatus = AppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ================= MANUAL LOCATION FLOW =================

  Future<void> selectPlace(PlaceModel place) async {
    try {
      locationMode = LocationMode.manual;
      appStatus = AppStatus.loading;
      notifyListeners();

      if (!_alreadySaved(place)) {
        savedLocations.add(place);
      }

      latitude = place.lat;
      longitude = place.lng;
      locationLabel = place.name;

      await _loadAll(latitude!, longitude!);

      appStatus = AppStatus.success;
      notifyListeners();
    } catch (e) {
      appStatus = AppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ================= CORE DATA LOADER =================

  Future<void> _loadAll(double lat, double lon) async {
    weatherData = await _repo.fetchCurrentWeather(lat, lon);
    daily = await _repo.fetchDailyForecast(lat, lon);

    await _repo.saveCache(weatherData: weatherData!);
  }

  // ================= SEARCH =================

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      places = [];
      notifyListeners();
      return;
    }

    try {
      isSearching = true;
      notifyListeners();

      places = await _repo.searchPlaces(query);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  // ================= REFRESH (IMPORTANT) =================

  Future<void> refresh() async {
    if (latitude == null || longitude == null) return;

    appStatus = AppStatus.loading;
    notifyListeners();

    await _loadAll(latitude!, longitude!);

    appStatus = AppStatus.success;
    notifyListeners();
  }
}
