import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracker_app/features/data/models/place_suggestion_model.dart';
import 'package:route_tracker_app/features/data/models/route_model.dart';


class MapsPlacesServices {
  final String _apiKey = 'bf04278fffa4452d970d0227575a2099';
  final String _baseUrl = 'https://api.geoapify.com/v1/geocode/autocomplete';

  final Dio _dio = Dio();

  Future<List<PlaceSuggestionModel>> getSuggestions(String input) async {
    try {
      // إرسال الطلب للسيرفر باستخدام GET
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'text': input, 'apiKey': _apiKey, 'limit': 7},
      );

      if (response.statusCode == 200) {
        final List<dynamic> features = response.data['features'];

        return features
            .map((feature) => PlaceSuggestionModel.fromJson(feature))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // ضيف الدالة دي في كلاس MapsPlacesServices
  Future<RouteModel?> getRoute(LatLng start, LatLng end) async {
    try {
      final response = await _dio.get(
        'https://api.geoapify.com/v1/routing',
        queryParameters: {
          'waypoints':
              '${start.latitude},${start.longitude}|${end.latitude},${end.longitude}',
          'mode': 'drive',
          'apiKey': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return RouteModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
   
      return null;
    }
  }
}
