import 'package:location/location.dart';

class LocationServices {
  Location location = Location();
  Future<void> checkAndRequestLocationService() async {
    bool isLocationServiceEnabled = await location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      await location.requestService();
      if (!isLocationServiceEnabled) {
        throw LocationServicesException();
      }
    }
    
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited) {
        
      } else {
        throw LocationPermissionException();
      }
    }
  
  }

  void getRealTimeLocationData(
    void Function(LocationData) onLocationUpdate,
  ) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onLocationUpdate);
  }

  Future<LocationData> getLocation() async {
      await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServicesException implements Exception {
}
class LocationPermissionException implements Exception {
}