import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracker_app/features/presentation/widgets/cutom_text_form_field.dart';
import 'package:route_tracker_app/features/presentation/widgets/suggestions_listview.dart';
import '../cubit/maps_cubit.dart';
import '../cubit/maps_state.dart';


class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late GoogleMapController mapController;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      context.read<MapsCubit>().fetchSuggestions(textController.text);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        final cubit = context.read<MapsCubit>();

        return Stack(
          children: [
            GoogleMap(
              markers: cubit.markers,
              polylines: cubit.polylines,
              zoomControlsEnabled: false,
              initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
              onMapCreated: (controller) {
                mapController = controller;
                cubit.initLocation(controller);
              },
            ),
            
            Positioned(
              top: 50,
              left: 22,
              right: 22,
              child: Column(
                children: [
                  CustomTextFormField(controller: textController),
                  const SizedBox(height: 10),
                  
                  if (state is SuggestionsLoaded && state.suggestions.isNotEmpty)
                    SuggestionsListView(
                      placeSuggestions: state.suggestions,
                      onPlaceSelected: (place) {
                        textController.clear();
                        FocusScope.of(context).unfocus();
                        cubit.drawRouteToPlace(place, mapController);
                      },
                    ),
                ],
              ),
            ),
            
            if (cubit.routeInfo != null)
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time_filled, color: Colors.blueAccent, size: 28),
                            const SizedBox(height: 8),
                            Text(
                              '${(cubit.routeInfo!.time / 60).round()} min',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text('Estimated Time', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                        Container(height: 50, width: 1, color: Colors.grey[300]),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.route, color: Colors.green, size: 28),
                            const SizedBox(height: 8),
                            Text(
                              '${(cubit.routeInfo!.distance / 1000).toStringAsFixed(1)} km',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text('Distance', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}