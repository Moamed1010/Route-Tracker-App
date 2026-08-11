import '../entities/place_suggestion.dart';
import '../repos/maps_repository.dart';

class GetPlaceSuggestionsUseCase {
  final MapsRepository repository;
  GetPlaceSuggestionsUseCase(this.repository);
  
  Future<List<PlaceSuggestion>> call(String input) async {
    return await repository.getPlaceSuggestions(input);
  }
}