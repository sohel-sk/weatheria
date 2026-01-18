import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatheria/src/core/model/weather_model.dart';
import 'package:weatheria/src/core/constants/app_constants.dart';
final String _apiKey = ApiConstants.apiKey;
final String _baseUrlWeather = ApiConstants.baseUrlWeather;
class WeatherService {

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse("$_baseUrlWeather/currentConditions:lookup?key=$_apiKey&location.latitude=LATITUDE&location.longitude=LONGITUDE"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load weather");
    }

    final data = json.decode(response.body);

    return WeatherModel(
      city: data['name'],
      temperature: data['main']['temp'].round(),
      condition: data['weather'][0]['description'],
      aqi: 120, // placeholder (AQI needs separate API)
    );
  }
}
