import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_suggestion_model.dart';
import '../models/route_model.dart';

class MapsRemoteDataSource {
  final String _apiKey = 'bf04278fffa4452d970d0227575a2099';
  final String _baseUrl = 'https://api.geoapify.com/v1/geocode/autocomplete';
  final Dio _dio = Dio();

  Future<List<PlaceSuggestionModel>> getSuggestions(String input) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'text': input, 'apiKey': _apiKey, 'limit': 7},
      );
      if (response.statusCode == 200) {
        final List<dynamic> features = response.data['features'];
        return features.map((f) => PlaceSuggestionModel.fromJson(f)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<RouteModel?> getRoute(LatLng start, LatLng end) async {
    try {
      final response = await _dio.get(
        'https://api.geoapify.com/v1/routing',
        queryParameters: {
          'waypoints': '${start.latitude},${start.longitude}|${end.latitude},${end.longitude}',
          'mode': 'drive',
          'apiKey': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        return RouteModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}