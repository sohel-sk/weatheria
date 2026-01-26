import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/model/weather_bundle.dart';
import 'package:weatheria/src/model/weather_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/core/constants/app_constants.dart';

final String _apiKey = ApiConstants.apiKey;
final String _baseUrlWeather = ApiConstants.baseUrlWeather;
final String _dailyForecast = ApiConstants.endpointDailyForecast;
final String _hourlyForecast = ApiConstants.endpointHourlyForecast;

class WeatherService {
  Future<List<DailyForecast>> fetchDailyForecast({
    required double lat,
    required double lon,
    int days = 6,
  }) async {
    List<DailyForecast> result = [];
    final url = Uri.parse('$_baseUrlWeather$_dailyForecast').replace(
      queryParameters: {
        "key": _apiKey,
        "location.latitude": lat.toString(),
        "location.longitude": lon.toString(),
        "days": days.toString(),
        "pageSize": "6",
      },
    );
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch daily forecast");
      }

      final data = json.decode(response.body);

      final List forecastDays = data['forecastDays'];

      result.addAll(
        forecastDays.map((e) {
          final day = e['daytimeForecast'];

          return DailyForecast(
            date: DateTime(
              e['displayDate']['year'],
              e['displayDate']['month'],
              e['displayDate']['day'],
            ),
            description: day['weatherCondition']['description']['text'],
            iconUrl: day['weatherCondition']['iconBaseUri'],
            maxTemp: e['maxTemperature']['degrees'].toDouble(),
            minTemp: e['minTemperature']['degrees'].toDouble(),
            humidity: day['relativeHumidity'],
            uvIndex: day['uvIndex'],
            rainProbability: day['precipitation']['probability']['percent'],
          );
        }),
      );

      return result.take(days).toList();
    } catch (e) {
      throw Exception("Error fetching daily forecast     conditions: $e");
    }
  }

  Future<WeatherBundle> fetchAll({
    required double lat,
    required double lon,
  }) async {
    try {
      // 🔄 Run APIs in parallel (FASTER)
      final results = await Future.wait([
        fetchCurrentConditions(lat: lat, lon: lon),
        fetchDailyForecast(lat: lat, lon: lon),
        fetchHourlyForecast(lat: lat, lng: lon),
      ]);

      return WeatherBundle(
        current: results[0] as WeatherModel,
        daily: results[1] as List<DailyForecast>,
        hourly: results[2] as List<HourlyForecast>, // can be added later
      );
    } catch (e) {
      throw Exception("Error fetching all weather data: $e");
    }
  }

  Future<List<HourlyForecast>> fetchHourlyForecast({
    required double lat,
    required double lng,
    int hours = 24,
    int pageSize = 6,
  }) async {
    List<HourlyForecast> result = [];
    String? pageToken;

    do {
      final url = Uri.parse('$_baseUrlWeather$_hourlyForecast').replace(
        queryParameters: {
          "key": _apiKey,
          "location.latitude": lat.toString(),
          "location.longitude": lng.toString(),
          "hours": hours.toString(),
          "pageSize": pageSize.toString(),
          if (pageToken != null) "pageToken": pageToken,
        },
      );

      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch hourly forecast");
      }

      final data = json.decode(response.body);

      final List forecastHours = data['forecastHours'];

      result.addAll(
        forecastHours.map((e) {
          final dateTime = e['displayDateTime'];

          return HourlyForecast(
            time: DateTime(
              dateTime['year'],
              dateTime['month'],
              dateTime['day'],
              dateTime['hours'],
            ),
            temperature: e['temperature']['degrees'].toDouble(),
            description: e['weatherCondition']['description']['text'],
            iconUrl: e['weatherCondition']['iconBaseUri'],
            isDaytime: e['isDaytime'],
            rainProbability: e['precipitation']['probability']['percent'],
          );
        }),
      );

      pageToken = data['nextPageToken'];
    } while (pageToken != null && result.length < hours);

    return result.take(hours).toList();
  }

  Future<WeatherModel> fetchCurrentConditions({
    required double lat,
    required double lon,
  }) async {
    try {
      final url =
          "$_baseUrlWeather/currentConditions:lookup?key=$_apiKey&location.latitude=$lat&location.longitude=$lon";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch current conditions");
      }

      final data = json.decode(response.body);

      return WeatherModel(
        description: data['weatherCondition']['description']['text'],
        iconUrl: data['weatherCondition']['iconBaseUri'],
        temperature: data['temperature']['degrees'].toDouble(),
        feelsLike: data['feelsLikeTemperature']['degrees'].toDouble(),
        humidity: data['relativeHumidity'],
        uvIndex: data['uvIndex'],
        pressure: data['airPressure']['meanSeaLevelMillibars'].toDouble(),
        windSpeed: data['wind']['speed']['value'].toDouble(),
        windDirection: data['wind']['direction']['cardinal'],
        visibility: data['visibility']['distance'],
        isDaytime: data['isDaytime'],
      );
    } on Exception catch (e) {
      // TODO
      throw Exception("Error fetching current conditions: $e");
    }
  }
}
