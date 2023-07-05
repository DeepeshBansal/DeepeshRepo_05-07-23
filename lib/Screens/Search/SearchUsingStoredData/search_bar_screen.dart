import "package:flutter/material.dart";
import 'package:food/Screens/Search/SearchUsingStoredData/menu_item_data.dart';
import 'package:food/Screens/Search/menu_item.dart';
import "package:food/Screens/Search/search_widget.dart";

class SearchBarScreen extends StatefulWidget {
  static const String routeName = '/searchbar';

  const SearchBarScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SearchBarScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<SearchBarScreen> createState() => _SearchBarScreen();
}

class _SearchBarScreen extends State<SearchBarScreen> {
  late List<MenuItem> menuItems;
  String query = '';

  @override
  void initState() {
    super.initState();

    menuItems = wholeMenu;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        SearchWidget(
          text: query,
          hintText: 'Search Restaurants, Dishes and More...',
          onChanged: searchMenuItem,
        ),
        SizedBox(
          height: 650,
          width: double.maxFinite,
          child: ListView.separated(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems[index];

              return InkWell(
                onTap: () {
                  print(10000);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Container(
                    /*decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3,color: const Color.fromARGB(255, 156, 156, 156)),
                    ),*/
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(menuItem.assetLocation,
                          fit: BoxFit.cover,
                          width: 56,
                          height: 56,
                        ),
                      ),
                      /* leading: CircleAvatar(
                              radius: 35,
                          backgroundImage: AssetImage('assets/images/pizza.png'),
                        ),*/
                      //      splashColor: Colors.grey,
                      title: Text(menuItem.restaurant,
                      style: const TextStyle(
                        fontFamily: 'Dropdown',
                        fontSize: 20,
                        fontWeight: FontWeight.bold

                      ),
                      ),
                      tileColor: Colors.white70,
                      subtitle: Text(menuItem.dish,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 80, 80, 80),
                        fontFamily: 'Dropdown',
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      onTap: null,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 3.25,
                color: const Color.fromARGB(255, 211, 211, 211),
              );
            },
          ),
        ),
      ]),
    ));
  }

  void searchMenuItem(String query) {
    final menuItems = wholeMenu.where((menuItem) {
      final restaurantLower = menuItem.restaurant.toLowerCase();
      final dishLower = menuItem.dish.toLowerCase();
      final searchLower = query.toLowerCase();

      return restaurantLower.contains(searchLower) ||
          dishLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.menuItems = menuItems;
    });
  }
}
