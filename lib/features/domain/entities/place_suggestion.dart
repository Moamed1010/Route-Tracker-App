class PlaceSuggestion {
  final String placeId;
  final String name;
  final String formattedAddress;
  final double lat;
  final double lng;

  PlaceSuggestion({
    required this.placeId,
    required this.name,
    required this.formattedAddress,
    required this.lat,
    required this.lng,
  });
}