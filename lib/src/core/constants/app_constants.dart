import 'package:flutter_dotenv/flutter_dotenv.dart';

// API Configuration
class ApiConstants {
  static const String baseUrlWeather = 'https://weather.googleapis.com/v1';
  // example url https://weather.googleapis.com/v1/currentConditions:lookup?key=YOUR_API_KEY&location.latitude=LATITUDE&location.longitude=LONGITUDE
  static const String baseUrlPlacesSearch = 'https://maps.googleapis.com/maps/api/place';

  // Get API key from environment variables or fallback to embedded key for demo
  static String get apiKey {
    return dotenv.env['KEY'] ?? 'YOUR_FALLBACK_API_KEY';
  }
}
