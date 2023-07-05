import "package:flutter/material.dart";
import 'package:food/Screens/Cart/cart_provider.dart';
import 'package:food/Screens/Main/main_screen.dart';
import 'package:food/app%20router/app_router.dart';
import 'package:food/blocs/geolocation/geolocation_bloc.dart';
import 'package:food/repositories/geolocation/geolocation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/repositories/places/places__repository.dart';
import 'package:food/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food/blocs/place/place_bloc.dart';
import 'package:provider/provider.dart';

String locationdropdownvalue = 'Choose Your Location';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation())),
          BlocProvider(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutocomplete())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
      create: (_) => CartProvider(),)

          ],
          child: MaterialApp(
            title: 'FLutterDemo',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: MainScreen.routeName,
          ),
        ),
      ),
    );
  }
}
