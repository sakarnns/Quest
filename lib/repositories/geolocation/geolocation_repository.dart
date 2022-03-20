import 'package:geolocator/geolocator.dart';
import 'package:quest_2/repositories/geolocation/base_geolocation_repositiry.dart';

class GeolocationRepository extends BaseGeolocationRepository {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
