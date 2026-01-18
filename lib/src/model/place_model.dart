import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 1)
class PlaceModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double lng;

  PlaceModel({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });
}
