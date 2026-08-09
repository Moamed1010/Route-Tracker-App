import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracker_app/models/place_suggestion_model.dart';
import 'package:route_tracker_app/utils/location_services.dart';
import 'package:route_tracker_app/utils/maps_places_services.dart';
import 'package:route_tracker_app/widgets/cutom_text_form_field.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  // تم نقل المتغيرات هنا لتكون خاصة بالشاشة فقط (Best Practice)
  late CameraPosition initialCameraPosition;
  late MapsPlacesServices mapsPlacesServices;
  late LocationServices locationServices;
  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;
  
  List<PlaceSuggestionModel> placeSuggestions = [];
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationServices = LocationServices();
    mapsPlacesServices = MapsPlacesServices();
    textEditingController = TextEditingController();
    
    // تفعيل دالة الاستماع لحقل البحث
    fetchPlaceSuggestions();
  }

  @override
  void dispose() {
    textEditingController.dispose();
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
          top: 50, // كبرناها لتفادي شريط الإشعارات (Status bar)
          left: 22,
          right: 22,
          child: Column(
            children: [
              CustomTextFormField(controller: textEditingController),
              const SizedBox(height: 10),
              
              // استدعاء الـ ListView مع تمرير الدالة والمتغيرات
              SuggestionsListView(
                placeSuggestions: placeSuggestions,
                onPlaceSelected: (selectedPlace) {
                  // 1. استخراج الإحداثيات
                  LatLng selectedLatLng = LatLng(
                    selectedPlace.lat,
                    selectedPlace.lng,
                  );

                  // 2. تجهيز الكاميرا للمكان الجديد
                  CameraPosition cameraPosition = CameraPosition(
                    target: selectedLatLng,
                    zoom: 15,
                  );

                  // 3. إنشاء الـ Marker للمكان الجديد
                  Marker selectedLocationMarker = Marker(
                    markerId: MarkerId(selectedPlace.placeId),
                    position: selectedLatLng,
                    infoWindow: InfoWindow(title: selectedPlace.name),
                  );

                  // 4. تحديث الشاشة (إضافة العلامة وإخفاء الليست)
                  setState(() {
                    markers.clear();
                    markers.add(selectedLocationMarker);
                    
                    // مسح القائمة لإخفاء الـ ListView
                    placeSuggestions.clear();
                    
                    // مسح مربع البحث
                 //   textEditingController.clear();
                  });

                  // 5. تحريك الكاميرا على الخريطة
                  googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition),
                  );
                  
                  // 6. إخفاء لوحة المفاتيح
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
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
      // TODO: Handle location service exception
    } on LocationPermissionException catch (e) {
      // TODO: Handle permission exception
    } catch (e) {
      // TODO: Handle generic exceptions
    }
  }

  void fetchPlaceSuggestions() {
    textEditingController.addListener(() async {
      final text = textEditingController.text;

      if (text.isNotEmpty) {
        var result = await mapsPlacesServices.getSuggestions(text);
        
        setState(() {
          placeSuggestions.clear();
          placeSuggestions.addAll(result);
        });
      } else {
        // في حالة إن المستخدم مسح الكلام اللي كتبه
        setState(() {
          placeSuggestions.clear();
        });
      }
    });
  }
}

// -------------------------------------------------------------------
// ويدجت الـ ListView مفصولة في كلاس لتنظيم الكود
// -------------------------------------------------------------------

class SuggestionsListView extends StatelessWidget {
  final List<PlaceSuggestionModel> placeSuggestions;
  final void Function(PlaceSuggestionModel) onPlaceSelected;

  const SuggestionsListView({
    super.key,
    required this.placeSuggestions,
    required this.onPlaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    // لو مفيش بيانات، متظهرش الـ Card خالص
    if (placeSuggestions.isEmpty) return const SizedBox();

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.zero, // لإزالة الفراغ العلوي والسفلي الافتراضي
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
              maxLines: 2, // عشان لو العنوان طويل ميبوظش شكل الشاشة
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // تنفيذ الدالة الممررة عند الضغط على العنصر
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