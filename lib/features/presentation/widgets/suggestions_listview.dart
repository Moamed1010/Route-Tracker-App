// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import '../../domain/entities/place_suggestion.dart'; 

class SuggestionsListView extends StatelessWidget {
  final List<PlaceSuggestion> placeSuggestions;
  final void Function(PlaceSuggestion) onPlaceSelected;

  const SuggestionsListView({
    super.key,
    required this.placeSuggestions,
    required this.onPlaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (placeSuggestions.isEmpty) return const SizedBox();

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final place = placeSuggestions[index];
          
          return ListTile(
            leading: Icon(
              FontAwesomeIcons.locationDot,
              color: Colors.blue[700],
            ),
            title: Text(place.name),
            subtitle: Text(
              place.formattedAddress,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              onPlaceSelected(place);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 0);
        },
        itemCount: placeSuggestions.length,
      ),
    );
  }
}