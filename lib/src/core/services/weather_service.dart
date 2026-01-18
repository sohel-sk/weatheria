import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatheria/src/core/model/weather_model.dart';
import 'package:weatheria/src/core/constants/app_constants.dart';
final String _apiKey = ApiConstants.apiKey;
final String _baseUrlWeather = ApiConstants.baseUrlWeather;
class WeatherService {

  Future<WeatherModel> fetchCurrentConditions({
    required double lat,
    required double lng,
  }) async {
    try {
      final url =
          "$_baseUrlWeather/currentConditions:lookup?key=$_apiKey&location.latitude=$lat&location.longitude=$lng";
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch current conditions");
      }
      
      final data = json.decode(response.body);
      
      return WeatherModel(
        description: data['weatherCondition']['description']['text'],
        iconUrl: data['weatherCondition']['iconBaseUri'],
        temperature: data['temperature']['degrees'].toDouble(),
        feelsLike:
            data['feelsLikeTemperature']['degrees'].toDouble(),
        humidity: data['relativeHumidity'],
        uvIndex: data['uvIndex'],
        pressure:
            data['airPressure']['meanSeaLevelMillibars'].toDouble(),
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
