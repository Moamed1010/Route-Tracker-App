import 'package:dio/dio.dart';
import 'package:route_tracker_app/models/place_suggestion_model.dart';

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
      print('Error getting suggestions: $e');
      return [];
    }
  }
}
