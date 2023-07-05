import 'package:flutter/material.dart';
import 'package:food/Screens/Cart/cart_model.dart';
import 'package:food/Screens/Cart/cart_provider.dart';
import 'package:food/Screens/Cart/data_base.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tapri_iitians_ki.dart';
import 'package:food/Screens/Restaurants/restaurants_logo_decider.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_menu.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_screen.dart';
import 'package:food/Screens/Restaurants/non_veg_logo.dart';
import 'package:food/Screens/Restaurants/veg_logo.dart';
import 'package:provider/provider.dart';

class TIKMainCourse extends StatefulWidget {
  final int menuindex;
  const TIKMainCourse({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
  State<TIKMainCourse> createState() => _TIKMainCourseState();
}

class _TIKMainCourseState extends State<TIKMainCourse> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsTIK[index].identity}00000$index',
          productName: productsTIK[index].name,
          restaurantName: productsTIK[index].restaurant,
          initialPrice: productsTIK[index].price,
          productPrice: productsTIK[index].price,
          identity: productsTIK[index].identity,
          menutype: productsTIK[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsTIK[index].category,
          image: productsTIK[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsTIK[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsTIK[widget.menuindex].menutype == 'Main Course') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.blueGrey.shade200,
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
                    TIKLogoDecider(logoindex: widget.menuindex),
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
                        productsTIK[widget.menuindex].name,
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
                        '${productsTIK[widget.menuindex].price.toString()}',
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
                          productsTIK[widget.menuindex].itemdescription,
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
                              productsTIK[widget.menuindex].image,
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
                            (productsTIK[this.widget.menuindex].identity)))) {
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
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsTIK[this.widget.menuindex].restaurant}"),
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

class TIKFastFood extends StatefulWidget {
  final int menuindex;
  const TIKFastFood({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
State<TIKFastFood> createState() => _TIKFastFoodState();
}

class _TIKFastFoodState extends State<TIKFastFood> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsTIK[index].identity}00000$index',
          productName: productsTIK[index].name,
          restaurantName: productsTIK[index].restaurant,
          initialPrice: productsTIK[index].price,
          productPrice: productsTIK[index].price,
          identity: productsTIK[index].identity,
          menutype: productsTIK[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsTIK[index].category,
          image: productsTIK[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsTIK[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsTIK[widget.menuindex].menutype == 'Fast Food') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.blueGrey.shade200,
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
                    TIKLogoDecider(logoindex: widget.menuindex),
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
                        productsTIK[widget.menuindex].name,
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
                        '${productsTIK[widget.menuindex].price.toString()}',
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
                          productsTIK[widget.menuindex].itemdescription,
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
                              productsTIK[widget.menuindex].image,
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
                            (productsTIK[this.widget.menuindex].identity)))) {
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
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsTIK[this.widget.menuindex].restaurant}"),
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

class TIKBeverages extends StatefulWidget {
  final int menuindex;
  const TIKBeverages({
    Key? key,
    required this.menuindex,
  }) : super(key: key);

  @override
State<TIKBeverages> createState() => _TIKBeveragesState();
}

class _TIKBeveragesState extends State<TIKBeverages> {
  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: '${productsTIK[index].identity}00000$index',
          productName: productsTIK[index].name,
          restaurantName: productsTIK[index].restaurant,
          initialPrice: productsTIK[index].price,
          productPrice: productsTIK[index].price,
          identity: productsTIK[index].identity,
          menutype: productsTIK[index].menutype,
          quantity: ValueNotifier(1),
          categoryTag: productsTIK[index].category,
          image: productsTIK[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsTIK[widget.menuindex].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    if (productsTIK[widget.menuindex].menutype == 'Beverages') {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.blueGrey.shade200,
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
                    TIKLogoDecider(logoindex: widget.menuindex),
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
                        productsTIK[widget.menuindex].name,
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
                        '${productsTIK[widget.menuindex].price.toString()}',
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
                          productsTIK[widget.menuindex].itemdescription,
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
                              productsTIK[widget.menuindex].image,
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
                            (productsTIK[this.widget.menuindex].identity)))) {
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
                                              "Your cart contains dishes from ${provider.cart[0].restaurantName}. Do you wish to discard those and add dishes from ${productsTIK[this.widget.menuindex].restaurant}"),
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