import 'package:location/location.dart';
import '../repos/maps_repository.dart';

class GetCurrentLocationUseCase {
  final MapsRepository repository;
  GetCurrentLocationUseCase(this.repository);
  
  Future<LocationData> call() async {
    return await repository.getCurrentLocation();
  }
}