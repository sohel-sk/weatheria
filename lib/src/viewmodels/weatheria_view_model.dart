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

  LocationMode locationMode = LocationMode.manual;
  String locationLabel = "Current Location";
  double? latitude;
  double? longitude;

  WeatherModel? weatherData;
  List<HourlyForecast> hourly = [];
  List<DailyForecast> daily = [];

  bool isSeearching = false;
  List<PlaceModel> places = [];

  Future<void> _loadAll(double lat, double lon) async {
    try {
      appStatus = AppStatus.loading;
      notifyListeners();
      weatherData = await _repo.fetchCurrentWeather(lat, lon);

      await _repo.saveCache(
        weatherData: weatherData!,
      );
      appStatus = AppStatus.success;


    }catch(e){
      appStatus = AppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
