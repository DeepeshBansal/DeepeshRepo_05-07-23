import 'package:flutter/material.dart';
import 'package:food/Screens/Add_Location/add_location_screen.dart';
import 'package:food/Screens/Cart/cart_screen.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tapri_iitians_ki_screen.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_screen.dart';
import 'package:food/Screens/Main/main_screen.dart';
import 'package:food/Screens/Location/location_screen.dart';
import 'package:food/Screens/Search/SearchUsingStoredData/search_bar_screen.dart';
import 'package:food/Screens/Search/search_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('The Route Is : ${settings.name}');

    switch (settings.name) {
      case '/':
        return MainScreen.route();
      case MainScreen.routeName:
        return MainScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case AddLocationScreen.routeName:
        return AddLocationScreen.route();
      case SearchScreen.routeName:
        return SearchScreen.route();
      case SearchBarScreen.routeName:
        return SearchBarScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case NightCanteenScreen.routeName:
        return NightCanteenScreen.route();
      case TapriIITiansKiScreen.routeName:
        return TapriIITiansKiScreen.route();

        break;

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
