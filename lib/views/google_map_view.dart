import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracker_app/utils/location_services.dart';
import 'package:route_tracker_app/widgets/cutom_text_form_field.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

late CameraPosition initialCameraPosition;
late LocationServices locationServices;
late GoogleMapController googleMapController;
late TextEditingController textEditingController;
Set<Marker> markers = {};

class _GoogleMapViewState extends State<GoogleMapView> {
  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationServices = LocationServices();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
     
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            updateCurrentLocation();
          },
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition,
        ),

        Positioned(
          top: 25,
          left: 22,
          right: 22,
          child: CustomTextFormField(controller: textEditingController),
        ),
      ],
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationServices.getLocation();
      LatLng currentLatLng = LatLng(
        locationData.latitude,
        locationData.longitude,
      );

      CameraPosition cameraPosition = CameraPosition(
        target: currentLatLng,
        zoom: 15,
      );
      Marker currentLocationMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: currentLatLng,
        infoWindow: const InfoWindow(title: 'Current Location'),
      );

      setState(() {
        markers.add(currentLocationMarker);
      });
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    } on LocationServicesException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }
}
