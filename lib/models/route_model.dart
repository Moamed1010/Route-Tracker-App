import 'package:route_tracker_app/models/point_coordinates.dart';

class RouteModel {
  final double distance;
  final double time;
  final List<PointCoordinates> coordinates;

  RouteModel({
    required this.distance,
    required this.time,
    required this.coordinates,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    // الوصول لبيانات المسافة والوقت
    final properties = json['features'][0]['properties'];

    // الوصول لمصفوفة الإحداثيات
    final List<dynamic> coordsJson =
        json['features'][0]['geometry']['coordinates'][0];

    List<PointCoordinates> points = [];
    for (var point in coordsJson) {
      points.add(
        PointCoordinates(lat: point[1].toDouble(), lng: point[0].toDouble()),
      );
    }

    return RouteModel(
      distance: (properties['distance'] ?? 0).toDouble(),
      time: (properties['time'] ?? 0).toDouble(),
      coordinates: points,
    );
  }
}
