import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}
late CameraPosition initialCameraPosition ;



class _GoogleMapViewState extends State<GoogleMapView> {

  @override
  void initState() {
  
    super.initState();
    initialCameraPosition = const CameraPosition(
      target: LatLng(0,0),
      
    );
  }
  @override
  Widget build(BuildContext context) {

    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initialCameraPosition,

    );
  }
}