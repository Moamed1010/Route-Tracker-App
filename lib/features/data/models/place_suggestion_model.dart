import '../../domain/entities/place_suggestion.dart';

class PlaceSuggestionModel extends PlaceSuggestion {
  PlaceSuggestionModel({
    required super.placeId,
    required super.name,
    required super.formattedAddress,
    required super.lat,
    required super.lng,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] ?? {};
    return PlaceSuggestionModel(
      placeId: properties['place_id'] ?? '',
      name: properties['name'] ?? 'Unknown',
      formattedAddress: properties['formatted'] ?? '',
      lat: (properties['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (properties['lon'] as num?)?.toDouble() ?? 0.0,
    );
  }
}