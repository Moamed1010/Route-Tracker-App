class PlaceSuggestionModel {
  final String placeId;
  final String name;
  final String formattedAddress;
  final double lat;
  final double lng; 

  PlaceSuggestionModel({
    required this.placeId,
    required this.name,
    required this.formattedAddress,
    required this.lat,
    required this.lng,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    // كل البيانات اللي تهمنا موجودة جوه كائن اسمه properties
    final properties = json['properties'] ?? {};

    return PlaceSuggestionModel(
      placeId: properties['place_id'] ?? '',
      name: properties['name'] ?? 'Unknown',
      formattedAddress: properties['formatted'] ?? '',
      // استخدمنا (as num?).toDouble() عشان لو الرقم رجع صحيح (int) مايعملش ايرور
      lat: (properties['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (properties['lon'] as num?)?.toDouble() ?? 0.0,
    );
  }
}