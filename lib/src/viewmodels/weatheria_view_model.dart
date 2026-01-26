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

  // determine if manual or automatically fetch
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

  // to load location with gps

  Future<void> loadByGPS() async {
    try {
      locationMode = LocationMode.gps;
      appStatus = AppStatus.loading;
      notifyListeners();

      final pos = await _repo.getCurrentPosition();

      latitude = pos.latitude;
      longitude = pos.longitude;

      locationLabel = await _repo.getCityName(latitude!, longitude!);

      await _repo.saveLocationState(
        locationMode: 'gps',
        lat: latitude!,
        lon: longitude!,
        label: locationLabel,
        savedLocations: savedLocations,
      );

      await _loadAll(latitude!, longitude!);

      appStatus = AppStatus.success;
      notifyListeners();
    } catch (e) {
      appStatus = AppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // seelcting the location manually by searching

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

      await _repo.saveLocationState(
        locationMode: 'manual',
        lat: latitude!,
        lon: longitude!,
        label: locationLabel,
        savedLocations: savedLocations,
      );

      await _loadAll(latitude!, longitude!);

      appStatus = AppStatus.success;
      notifyListeners();
    } catch (e) {
      appStatus = AppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // to load allthe data for the home page

  Future<void> _loadAll(double lat, double lon) async {
    weatherData = await _repo.fetchCurrentWeather(lat, lon);
    daily = await _repo.fetchDailyForecast(lat, lon);
    hourly = await _repo.fetchHourlyForecast(lat, lon);

    if (weatherData == null) {
      throw Exception("Weather data missing");
    }

    await _repo.saveCache(
      weatherData: weatherData!,
      hourly: hourly,
      daily: daily,
    );
  }

  // here is where the user will search forthe location

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

  Future<void> bootstrap() async {
    appStatus = AppStatus.loading;
    notifyListeners();

    final state = await _repo.loadLocationState();

    final saved = state['saved_locations'];
    if (saved != null) {
      savedLocations
        ..clear()
        ..addAll(List<PlaceModel>.from(saved));
    }

    final mode = state['location_mode'];

    if (mode == 'manual' && state['lat'] != null && state['lon'] != null) {
      locationMode = LocationMode.manual;
      latitude = state['lat'];
      longitude = state['lon'];
      locationLabel = state['label'] ?? "Selected Location";

      await _loadAll(latitude!, longitude!);
    }
    else {
      await loadByGPS();
      return; 
    }

    appStatus = AppStatus.success;
    notifyListeners();
  }

  // refresh the home page

  Future<void> refresh() async {
    if (latitude == null || longitude == null) return;

    appStatus = AppStatus.loading;
    notifyListeners();

    await _loadAll(latitude!, longitude!);

    appStatus = AppStatus.success;
    notifyListeners();
  }
}
