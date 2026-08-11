import '../../domain/entities/route_details.dart';

class RouteModel extends RouteDetails {
  RouteModel({
    required super.distance,
    required super.time,
    required super.coordinates,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final properties = json['features'][0]['properties'];
    final List<dynamic> coordsJson = json['features'][0]['geometry']['coordinates'][0];

    List<PointCoord> points = [];
    for (var point in coordsJson) {
      points.add(PointCoord(lat: point[1].toDouble(), lng: point[0].toDouble()));
    }

    return RouteModel(
      distance: (properties['distance'] ?? 0).toDouble(),
      time: (properties['time'] ?? 0).toDouble(),
      coordinates: points,
    );
  }
}