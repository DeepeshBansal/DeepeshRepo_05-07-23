import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food/Screens/Cart/cart_model.dart';
import 'package:food/Screens/Cart/cart_provider.dart';
import 'package:food/Screens/Cart/cart_screen.dart';
import 'package:food/Screens/Cart/data_base.dart';
import 'package:food/Screens/Restaurants/NightCanteen/nc_introduction_box.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tapri_iitians_ki.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tik_introduction_box.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tik_item_identifier.dart';
import 'package:food/Screens/Restaurants/restaurants_logo_decider.dart';
import 'package:food/Screens/Restaurants/NightCanteen/nc_item_identifier.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_menu.dart';
import 'package:food/main.dart';
import 'package:provider/provider.dart';

class TapriIITiansKiScreen extends StatefulWidget {
  const TapriIITiansKiScreen({Key? key}) : super(key: key);

  static const String routeName = '/tapriiitianski';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TapriIITiansKiScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<TapriIITiansKiScreen> createState() => _TapriIITiansKiScreenState();
}

class _TapriIITiansKiScreenState extends State<TapriIITiansKiScreen> {
  DBHelper dbHelper = DBHelper();

  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
   /* final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          identity: productsTIK[index].identity,
          menutype: productsTIK[index].menutype,
          productId: '${productsTIK[index].identity}00000$index',
          productName: productsTIK[index].name,
          restaurantName: productsTIK[index].restaurant,
          initialPrice: productsTIK[index].price,
          productPrice: productsTIK[index].price,
          quantity: ValueNotifier(1),
          categoryTag: productsTIK[index].category,
          image: productsTIK[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(productsTIK[index].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }*/

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const TIKIntroduction(),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                      ])
                ],
              ),
            ),
            ExpansionTile(
              title: const Text(
                'Main Course',
              ),
              children: <Widget>[
                InkWell(
                  onTap: (){
                  Navigator.pushNamed(context, '/cart');

                  },
                  child: ListView.builder(
                      itemCount: productsTIK.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TIKMainCourse(menuindex: index);
                      }),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Fast Food',
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: ListView.builder(
                      itemCount: productsTIK.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TIKFastFood(menuindex: index);
                      }),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Beverages',
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: ListView.builder(
                      itemCount: productsTIK.length,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TIKBeverages(menuindex: index);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogCancelButtons extends StatelessWidget {
  const AlertDialogCancelButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: Container(
        height: 50,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 185, 255, 212)),
        child: Center(
          child: TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontFamily: 'Dropdown',
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 126, 51),
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

class AlertDialogReplaceButtons extends StatelessWidget {
  const AlertDialogReplaceButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: Container(
        height: 50,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 36, 194, 128)),
        child: Center(
          child: TextButton(
            child: const Text(
              'Replace',
              style: TextStyle(
                  fontFamily: 'Dropdown',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
