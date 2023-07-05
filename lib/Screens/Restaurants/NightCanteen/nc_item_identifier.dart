import 'package:flutter/material.dart';
import 'package:food/Screens/Cart/cart_model.dart';
import 'package:food/Screens/Cart/cart_provider.dart';
import 'package:food/Screens/Cart/data_base.dart';
import 'package:food/Screens/Restaurants/restaurants_logo_decider.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_menu.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_screen.dart';
import 'package:food/Screens/Restaurants/non_veg_logo.dart';
import 'package:food/Screens/Restaurants/veg_logo.dart';
import 'package:provider/provider.dart';

class NCMainCourse extends StatefulWidget {
  final int menuindex;
  const NCMainCourse({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
  State<NCMainCourse> createState() => _NCMainCourseState();
}

class _NCMainCourseState extends State<NCMainCourse> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsNC[index].identity}00000$index',
          productName: productsNC[index].name,
          restaurantName: productsNC[index].restaurant,
          initialPrice: productsNC[index].price,
          productPrice: productsNC[index].price,
          identity: productsNC[index].identity,
          menutype: productsNC[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsNC[index].category,
          image: productsNC[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsNC[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsNC[widget.menuindex].menutype == 'Main Course') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    NCLogoDecider(logoindex: widget.menuindex),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 179,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        productsNC[widget.menuindex].name,
                        style: const TextStyle(
                          fontFamily: 'Dropdown',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '\u{20B9}'
                        '${productsNC[widget.menuindex].price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        height: 49,
                        child: Text(
                          productsNC[widget.menuindex].itemdescription,
                          style: const TextStyle(
                              fontFamily: 'Dropdown',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 101, 101, 101)),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 132,
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              productsNC[widget.menuindex].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      right: 0,
                      child: Consumer<CartProvider>(
                          builder: (BuildContext context, provider, widget) {
                        if (provider.cart.isEmpty) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else if (!((provider.cart[0].productId!).contains(
                            (productsNC[this.widget.menuindex].identity)))) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title:
                                              const Text('Replace Cart Item?'),
                                          titleTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                          content: Text(
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsNC[this.widget.menuindex].restaurant}"),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AlertDialogCancelButtons(),
                                                Consumer<CartProvider>(builder:
                                                    (BuildContext context,
                                                        provider, widget) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.5),
                                                    child: Container(
                                                      height: 50,
                                                      width: 125,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              36, 194, 128)),
                                                      child: Center(
                                                        child: TextButton(
                                                          child: const Text(
                                                            'Replace',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Dropdown',
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onPressed: () {
                                                            while (provider.cart
                                                                .isNotEmpty) {
                                                              dbHelper
                                                                  .deleteCartItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeCounter();
                                                            }
                                                            saveData(this.widget.menuindex);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Item Added Successfully!'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class NCFastFood extends StatefulWidget {
  final int menuindex;
  const NCFastFood({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
State<NCFastFood> createState() => _NCFastFoodState();
}

class _NCFastFoodState extends State<NCFastFood> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsNC[index].identity}00000$index',
          productName: productsNC[index].name,
          restaurantName: productsNC[index].restaurant,
          initialPrice: productsNC[index].price,
          productPrice: productsNC[index].price,
          identity: productsNC[index].identity,
          menutype: productsNC[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsNC[index].category,
          image: productsNC[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsNC[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsNC[widget.menuindex].menutype == 'Fast Food') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    NCLogoDecider(logoindex: widget.menuindex),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 179,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        productsNC[widget.menuindex].name,
                        style: const TextStyle(
                          fontFamily: 'Dropdown',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '\u{20B9}'
                        '${productsNC[widget.menuindex].price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        height: 49,
                        child: Text(
                          productsNC[widget.menuindex].itemdescription,
                          style: const TextStyle(
                              fontFamily: 'Dropdown',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 101, 101, 101)),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 132,
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              productsNC[widget.menuindex].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      right: 0,
                      child: Consumer<CartProvider>(
                          builder: (BuildContext context, provider, widget) {
                        if (provider.cart.isEmpty) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else if (!((provider.cart[0].productId!).contains(
                            (productsNC[this.widget.menuindex].identity)))) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title:
                                              const Text('Replace Cart Item?'),
                                          titleTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                          content: Text(
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsNC[this.widget.menuindex].restaurant}"),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AlertDialogCancelButtons(),
                                                Consumer<CartProvider>(builder:
                                                    (BuildContext context,
                                                        provider, widget) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.5),
                                                    child: Container(
                                                      height: 50,
                                                      width: 125,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              36, 194, 128)),
                                                      child: Center(
                                                        child: TextButton(
                                                          child: const Text(
                                                            'Replace',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Dropdown',
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onPressed: () {
                                                            while (provider.cart
                                                                .isNotEmpty) {
                                                              dbHelper
                                                                  .deleteCartItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeCounter();
                                                            }
                                                            saveData(this.widget.menuindex);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Item Added Successfully!'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class NCBeverages extends StatefulWidget {
  final int menuindex;
  const NCBeverages({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
State<NCBeverages> createState() => _NCBeveragesState();
}

class _NCBeveragesState extends State<NCBeverages> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsNC[index].identity}00000$index',
          productName: productsNC[index].name,
          restaurantName: productsNC[index].restaurant,
          initialPrice: productsNC[index].price,
          productPrice: productsNC[index].price,
          identity: productsNC[index].identity,
          menutype: productsNC[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsNC[index].category,
          image: productsNC[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsNC[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsNC[widget.menuindex].menutype == 'Beverages') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          
          color: Colors.white,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    NCLogoDecider(logoindex: widget.menuindex),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 179,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        productsNC[widget.menuindex].name,
                        style: const TextStyle(
                          fontFamily: 'Dropdown',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        '\u{20B9}'
                        '${productsNC[widget.menuindex].price.toString()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        height: 49,
                        child: Text(
                          productsNC[widget.menuindex].itemdescription,
                          style: const TextStyle(
                              fontFamily: 'Dropdown',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 101, 101, 101)),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 132,
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              productsNC[widget.menuindex].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      right: 0,
                      child: Consumer<CartProvider>(
                          builder: (BuildContext context, provider, widget) {
                        if (provider.cart.isEmpty) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else if (!((provider.cart[0].productId!).contains(
                            (productsNC[this.widget.menuindex].identity)))) {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title:
                                              const Text('Replace Cart Item?'),
                                          titleTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                          content: Text(
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsNC[this.widget.menuindex].restaurant}"),
                                          actionsOverflowButtonSpacing: 20,
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AlertDialogCancelButtons(),
                                                Consumer<CartProvider>(builder:
                                                    (BuildContext context,
                                                        provider, widget) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.5),
                                                    child: Container(
                                                      height: 50,
                                                      width: 125,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              36, 194, 128)),
                                                      child: Center(
                                                        child: TextButton(
                                                          child: const Text(
                                                            'Replace',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Dropdown',
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          onPressed: () {
                                                            while (provider.cart
                                                                .isNotEmpty) {
                                                              dbHelper
                                                                  .deleteCartItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeItem(
                                                                      provider
                                                                          .cart[
                                                                              0]
                                                                          .id!);
                                                              provider
                                                                  .removeCounter();
                                                            }
                                                            saveData(this.widget.menuindex);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Item Added Successfully!'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Material(
                              color: const Color.fromARGB(
                                  255, 36, 194, 128), // Button color
                              child: InkWell(
                                splashColor: Colors.green, // Splash color
                                onTap: () {
                                  saveData(this.widget.menuindex);
                                },
                                child: const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Center(
                                      child: Icon(
                                        Icons.add_rounded,
                                        color:
                                            Color.fromARGB(255, 221, 255, 249),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}