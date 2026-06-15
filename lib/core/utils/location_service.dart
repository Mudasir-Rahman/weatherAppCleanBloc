import 'package:geolocator/geolocator.dart';

import '../error/location_service_exception.dart';

class LocationService {

  // Get current position with permissions
  Future<Position> getCurrentPosition() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException('Location services are disabled');
    }

    // Check and request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationServiceException('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationServiceException('Location permission permanently denied');
    }

    // Get the position
    return await Geolocator.getCurrentPosition();
  }

  // Get just lat/long as a simple map
  Future<Map<String, double>> getCurrentLocation() async {
    final position = await getCurrentPosition();
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}