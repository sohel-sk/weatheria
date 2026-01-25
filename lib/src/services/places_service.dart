import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/place_model.dart';
import 'package:weatheria/src/core/constants/app_constants.dart';

final String _apiKey = ApiConstants.apiKey;
final String _baseUrl ='${ApiConstants.baseUrlPlacesSearch}/findplacefromtext/json';

class PlacesService {

  Future<List<PlaceModel>> searchPlaces(String query) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        "input": query,
        "inputtype": "textquery",
        "fields": "name,formatted_address,geometry",
        "key": _apiKey,
      },
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Places API failed");
    }

    final data = json.decode(response.body);
    if (data['status'] != "OK") return [];

    return (data['candidates'] as List).map((e) {
      return PlaceModel(
        name: e['name'],
        address: e['formatted_address'],
        lat: e['geometry']['location']['lat'],
        lng: e['geometry']['location']['lng'],
      );
    }).toList();
  }
}
