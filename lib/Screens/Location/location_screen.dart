import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food/blocs/geolocation/geolocation_bloc.dart';
import 'package:food/blocs/place/place_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  const LocationScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LocationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, State) {
          if (State is PlaceLoading) {
            return Stack(
              children: [
                BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                    if (state is GeolocationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GeolocationLoaded) {
                      return Stack(
                        children: [
                          GoogleMap(
                              myLocationButtonEnabled: true,
                              zoomGesturesEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(state.position.latitude,
                                    state.position.longitude),
                              )),
                        ],
                      );
                    } else {
                      return const Text('Something Went Wrong.');
                    }
                  },
                ),
                const SaveAddress(),
                const Location(),
              ],
            );
          } else if (State is PlaceLoaded) {
            return const Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(22.526942, 75.925007),
                    zoom: 14.4746,
                  ),
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                ),
                SaveAddress(),
                Location(),
              ],
            );
          } else {
            return const Text('Something Went Wrong!');
          }
        },
      ),
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 10,
        top: 30,
        right: 10,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const LocationSearchBox(),
                    BlocBuilder<AutocompleteBloc, AutocompleteState>(
                      builder: (context, state) {
                        if (state is AutocompleteLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AutocompleteLoaded) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            height: 300,
                            color: state.autocomplete.isNotEmpty
                                ? Colors.black.withOpacity(0.6)
                                : Colors.transparent,
                            child: ListView.builder(
                                itemCount: state.autocomplete.length,
                                itemBuilder: (contex, index) {
                                  return ListTile(
                                    title: Text(
                                      state.autocomplete[index].description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.grey),
                                    ),
                                    onTap: () {
                                      contex.read<PlaceBloc>().add(LoadPlace(
                                          placeId: state
                                              .autocomplete[index].placeId));
                                    },
                                  );
                                }),
                          );
                        } else {
                          return const Text('Something Went Wrong!');
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SaveAddress extends StatelessWidget {
  const SaveAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 10,
        bottom: 50,
        right: 10,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 39, 118, 255)),
                child: const Text('Save Address'),
                onPressed: () {},
              ),
            )));
  }
}

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
        builder: (context, state) {
      if (state is AutocompleteLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is AutocompleteLoaded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 230, 230, 230),
              hintText: 'Enter Your Location',
              suffixIcon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 132, 132, 132),
              ),
              contentPadding:
                  const EdgeInsets.only(left: 20, bottom: 1, right: 5),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              context
                  .read<AutocompleteBloc>()
                  .add(LoadAutocomplete(searchInput: value));
            },
          ),
        );
      } else {
        return const Text('Something Went Wrong!');
      }
    });
  }
}
