import 'package:location/location.dart';

class LocationServices {
  Location location = Location();
  Future<bool> checkAndRequestLocationService() async {
    bool isLocationServiceEnabled = await location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      await location.requestService();
      if (!isLocationServiceEnabled) {
        return false;
      }
    }
    return true;
  }
  
  Future<bool> checkAndRequestLocationPermission() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      return false;
    }
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.granted ||
          permission == PermissionStatus.grantedLimited) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
 Future<LocationData> getLocation()async {
    return await location.getLocation();
  }
}
