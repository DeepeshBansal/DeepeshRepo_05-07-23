import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food/Screens/Cart/cart_model.dart';
import 'package:food/Screens/Cart/cart_provider.dart';
import 'package:food/Screens/Cart/data_base.dart';
import 'package:food/Screens/Restaurants/non_veg_logo.dart';
import 'package:food/Screens/Restaurants/veg_logo.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CartScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),

      /* actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                    child: Text(
                      'Something Delicious is Waiting For you!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //color: Colors.black12,
                              borderRadius: BorderRadius.circular(15)),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: provider.cart.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    width: double.maxFinite,
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 90,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  provider.cart[index].image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      /* Text(
                                                                '${provider.cart[index].productName!}',
                                                                style: const TextStyle(
                                                                    fontFamily: 'Dropdown',
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Text(
                                                                '${provider.cart[index].restaurantName!}',
                                                                style: const TextStyle(
                                                                    fontFamily: 'Dropdown',
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Text(
                                                                '${provider.cart[index].productPrice!}',
                                                                style: const TextStyle(
                                                                    fontFamily: 'Dropdown',
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.bold),
                                                              ),*/
                                                      Stack(
                                                        children: [
                                                          SizedBox(
                                                            width: 215,
                                                            height: 22,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                RichText(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  text: TextSpan(
                                                                      text: provider
                                                                          .cart[
                                                                              index]
                                                                          .productName!,
                                                                      style: const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              126,
                                                                              51),
                                                                          fontSize:
                                                                              17,
                                                                          fontFamily:
                                                                              'Dropdown',
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                CartLogoDecider(
                                                                    logoindex:
                                                                        index),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            text: provider
                                                                .cart[index]
                                                                .restaurantName!,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        120,
                                                                        120,
                                                                        120),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Dropdown',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            text:
                                                                '\u{20B9} ${provider.cart[index].productPrice!}',
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        126,
                                                                        51),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            /* Align(
                                              alignment: const Alignment(0.25, 0.75),
                                              child: ValueListenableBuilder<int>(
                                                  valueListenable:
                                                      provider.cart[index].quantity!,
                                                  builder: (context, val, child) {
                                                    return PlusMinusButtons(
                                                      addQuantity: () {
                                                        cart.addQuantity(
                                                            provider.cart[index].id!);
                                                        dbHelper!
                                                            .updateQuantity(Cart(
                                                                id: index,
                                                                productId:
                                                                    index.toString(),
                                                                productName: provider
                                                                    .cart[index]
                                                                    .productName,
                                                                restaurantName: provider
                                                                    .cart[index]
                                                                    .restaurantName,
                                                                initialPrice: provider
                                                                    .cart[index]
                                                                    .initialPrice,
                                                                productPrice: provider
                                                                    .cart[index]
                                                                    .productPrice,
                                                                quantity: ValueNotifier(
                                                                    provider.cart[index]
                                                                        .quantity!.value),
                                                                categoryTag: provider
                                                                    .cart[index]
                                                                    .categoryTag,
                                                                image: provider
                                                                    .cart[index].image))
                                                            .then((value) {
                                                          setState(() {
                                                            cart.addTotalPrice(
                                                                double.parse(provider
                                                                    .cart[index]
                                                                    .productPrice
                                                                    .toString()));
                                                          });
                                                        });
                                                      },
                                                      deleteQuantity: () {
                                                        cart.deleteQuantity(
                                                            provider.cart[index].id!);
                                                        cart.removeTotalPrice(
                                                            double.parse(provider
                                                                .cart[index].productPrice
                                                                .toString()));
                                                      },
                                                      removeItem: () {
                                                        dbHelper!.deleteCartItem(
                                                            provider.cart[index].id!);
                                                        provider.removeItem(
                                                            provider.cart[index].id!);
                                                        provider.removeCounter();
                                                      },
                                                      text: val.toString(),
                                                    );
                                                  }),
                                            ),*/
                                          ],
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: ValueListenableBuilder<int>(
                                              valueListenable: provider
                                                  .cart[index].quantity!,
                                              builder: (context, val, child) {
                                                return PlusMinusButtons(
                                                  addQuantity: () {
                                                    cart.addQuantity(provider
                                                        .cart[index].id!);
                                                    dbHelper!
                                                        .updateQuantity(Cart(
                                                            id: index,
                                                            productId: index
                                                                .toString(),
                                                            productName: provider
                                                                .cart[index]
                                                                .productName,
                                                            restaurantName: provider
                                                                .cart[index]
                                                                .restaurantName,
                                                            identity: provider
                                                                .cart[index]
                                                                .identity,
                                                            menutype: provider
                                                                .cart[index]
                                                                .menutype,
                                                            initialPrice: provider
                                                                .cart[index]
                                                                .initialPrice,
                                                            productPrice: provider
                                                                .cart[index]
                                                                .productPrice,
                                                            quantity: ValueNotifier(
                                                                provider
                                                                    .cart[index]
                                                                    .quantity!
                                                                    .value),
                                                            categoryTag: provider
                                                                .cart[index]
                                                                .categoryTag,
                                                            image: provider
                                                                .cart[index]
                                                                .image))
                                                        .then((value) {
                                                      setState(() {
                                                        cart.addTotalPrice(
                                                            double.parse(provider
                                                                .cart[index]
                                                                .productPrice
                                                                .toString()));
                                                      });
                                                    });
                                                  },
                                                  deleteQuantity: () {
                                                    cart.deleteQuantity(provider
                                                        .cart[index].id!);
                                                    cart.removeTotalPrice(
                                                        double.parse(provider
                                                            .cart[index]
                                                            .productPrice
                                                            .toString()));
                                                  },
                                                  removeItem: () {
                                                    dbHelper!.deleteCartItem(
                                                        provider
                                                            .cart[index].id!);
                                                    provider.removeItem(provider
                                                        .cart[index].id!);
                                                    provider.removeCounter();
                                                  },
                                                  text: val.toString(),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1.75,
                                  color: Color.fromARGB(255, 211, 211, 211),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.cart.isEmpty) {
                  return const Center(
                      child: Text(
                    'Please add some items',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ));
                } else {
                  final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                  for (var element in value.cart) {
                    totalPrice.value =
                        (element.productPrice! * element.quantity!.value) +
                            (totalPrice.value ?? 0);
                  }
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CuttlerySection(),
                      const SizedBox(
                        height: 30,
                      ),
                      ValueListenableBuilder<int?>(
                          valueListenable: totalPrice,
                          builder: (context, val, child) {
                            return Column(
                              children: [
                                const SizedBox(
                                  width: double.maxFinite,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      'Bill Details',
                                      style: TextStyle(
                                          fontFamily: 'Dropdown',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        BillingParameters(
                                            title: 'Item Total',
                                            value:
                                                val?.toStringAsFixed(2) ?? '0'),
                                        const BillingParameters(
                                            title: 'Restaurant Charges',
                                            value: '10.00'),
                                        const BillingParameters(
                                            title: 'Delivery Partner Fees',
                                            value: '10.00'),
                                        BillingAmount(
                                            title: 'To Pay',
                                            value:
                                                (val! + 20).toStringAsFixed(2)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: const Color.fromARGB(255, 69, 255, 159),
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final VoidCallback removeItem;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.removeItem,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinusButton(
            deleteQuantity: deleteQuantity, removeItem: removeItem, text: text),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: const TextStyle(
              fontFamily: 'Dropdown',
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          width: 6,
        ),
        PlusButton(addQuantity: addQuantity),
      ],
    );
  }
}

class MinusButton extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback removeItem;

  final String text;

  const MinusButton(
      {Key? key,
      required this.deleteQuantity,
      required this.removeItem,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == '1') {
      return Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 2.5, color: const Color.fromARGB(255, 36, 194, 128)),
        ),
        child: Center(
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: removeItem,
              icon: const Icon(
                Icons.remove_rounded,
                size: 20,
                color: Color.fromARGB(255, 36, 194, 128),
              )),
        ),
      );
    } else {
      return Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 2.5, color: const Color.fromARGB(255, 36, 194, 128)),
        ),
        child: Center(
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: deleteQuantity,
              icon: const Icon(
                Icons.remove_rounded,
                color: Color.fromARGB(255, 36, 194, 128),
              )),
        ),
      );
    }
  }
}

class PlusButton extends StatelessWidget {
  final VoidCallback addQuantity;
  const PlusButton({Key? key, required this.addQuantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 36, 194, 128),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onPressed: addQuantity,
            icon: const Icon(Icons.add_rounded)),
      ),
    );
  }
}

class BillingParameters extends StatelessWidget {
  final String title, value;
  const BillingParameters(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 18,
                color: Color.fromARGB(255, 113, 113, 113),
                fontWeight: FontWeight.bold),
          ),
          Text(
            '\u{20B9}$value',
            style: const TextStyle(
              fontSize: 16.5,
              color: Color.fromARGB(255, 67, 67, 67),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class BillingAmount extends StatelessWidget {
  final String title, value;
  const BillingAmount({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800),
          ),
          Text(
            '\u{20B9}' + value.toString(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class CuttlerySection extends StatelessWidget {
  const CuttlerySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.maxFinite,
        height: 115,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Add Cooking Requests',
                  style: TextStyle(
                      fontFamily: 'Dropdown',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 10,
                right: 10,
              ),
              child: Center(
                child: TextField(
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintText: 'Cuttlery,Napkins,No Onions or Any Other...',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Dropdown',
                        color: Color.fromARGB(255, 162, 58, 0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 162, 58, 0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 162, 58, 0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartLogoDecider extends StatelessWidget {
  final int logoindex;
  const CartLogoDecider({
    super.key,
    required this.logoindex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, provider, widget) {
        if (provider.cart[logoindex].categoryTag == 'Veg') {
          return VegLogo();
        } else {
          return NonVegLogo();
        }
      },
    );
  }
}
