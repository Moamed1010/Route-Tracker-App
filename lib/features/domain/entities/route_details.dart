class RouteDetails {
  final double distance;
  final double time;
  final List<PointCoord> coordinates;

  RouteDetails({
    required this.distance,
    required this.time,
    required this.coordinates,
  });
}

class PointCoord {
  final double lat;
  final double lng;

  PointCoord({required this.lat, required this.lng});
}