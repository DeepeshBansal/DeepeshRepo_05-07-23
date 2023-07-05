import 'dart:convert';

import 'package:food/Screens/Search/menu_item.dart';
import 'package:http/http.dart' as http;

class MenuItemsApi {
  static Future<List<MenuItem>> getMenuItems(String query) async {
    final url = Uri.parse(
        'Paste Your Url Here Without Removing Inverted Commas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List menuItems = json.decode(response.body);

      return menuItems.map((json) => MenuItem.fromJson(json)).where((menuItem) {
        final restaurantLower = menuItem.restaurant.toLowerCase();
        final dishLower = menuItem.dish.toLowerCase();
        final searchLower = query.toLowerCase();

        return restaurantLower.contains(searchLower) ||
            dishLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}