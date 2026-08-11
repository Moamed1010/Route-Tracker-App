import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/data/datasources/remote_data_source.dart';
import 'features/data/repos/maps_repository_impl.dart';
import 'features/domain/usecases/get_current_location_usecase.dart';
import 'features/domain/usecases/get_place_suggestions_usecase.dart';
import 'features/domain/usecases/get_route_usecase.dart';
import 'features/presentation/cubit/maps_cubit.dart';
import 'features/presentation/views/google_map_view.dart';
import 'utils/location_services.dart';

void main() {
  runApp(const RouteTrackerApp());
}

class RouteTrackerApp extends StatelessWidget {
  const RouteTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // إعداد الـ Repositories هنا قبل تمريرها للـ Cubit
    final locationServices = LocationServices();
    final remoteDataSource = MapsRemoteDataSource();
    final mapsRepository = MapsRepositoryImpl(remoteDataSource, locationServices);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocProvider(
            create: (context) => MapsCubit(
              getCurrentLocationUseCase: GetCurrentLocationUseCase(mapsRepository),
              getPlaceSuggestionsUseCase: GetPlaceSuggestionsUseCase(mapsRepository),
              getRouteUseCase: GetRouteUseCase(mapsRepository),
            ),
            child: const GoogleMapView(),
          ),
        ),
      ),
    );
  }
}