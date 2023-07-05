import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food/Screens/Search/menu_item.dart';
import 'package:food/Screens/Search/SearchUsingNetworks/menu_items_api.dart';
import 'package:food/Screens/Search/search_widget.dart';

class SearchUsingNetworks extends StatefulWidget {
  static const String routeName = '/Type Your Desired Route Name Here';

  const SearchUsingNetworks({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SearchUsingNetworks(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<SearchUsingNetworks> createState() => _SearchUsingNetworks();
}

class _SearchUsingNetworks extends State<SearchUsingNetworks> {
  List<MenuItem> menuItems=[];
  String query = '';

  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final menuItems = await MenuItemsApi.getMenuItems(query);

    setState(() => this.menuItems = menuItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        SearchWidget(
          text: query,
          hintText: 'Search Restaurants, Dishes And More...',
          onChanged: searchMenuItem,
        ),
        SizedBox(
          height: 500,
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
                        child: Image.asset(
                          'assets/images/burger.jpg',
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
                      title: Text(menuItem.restaurant),
                      tileColor: Colors.white70,
                      subtitle: Text(menuItem.dish),
                      onTap: null,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 3.25,
                color: Color.fromARGB(255, 211, 211, 211),
              );
            },
          ),
        ),
      ]),
    ));
  }

  Future searchMenuItem(String query) async => debounce(() async {
        final menuItems = await MenuItemsApi.getMenuItems(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.menuItems = menuItems;
        });
      });
}
