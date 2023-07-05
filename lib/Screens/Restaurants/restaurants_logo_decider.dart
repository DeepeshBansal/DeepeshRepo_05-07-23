import 'package:flutter/material.dart';
import 'package:food/Screens/Restaurants/NightCanteen/night_canteen_menu.dart';
import 'package:food/Screens/Restaurants/TapriIITiansKi/tapri_iitians_ki.dart';
import 'package:food/Screens/Restaurants/non_veg_logo.dart';
import 'package:food/Screens/Restaurants/veg_logo.dart';

class NCLogoDecider extends StatelessWidget {
  final int logoindex;
  const NCLogoDecider({
    super.key,
    required this.logoindex,
  });

  @override
  Widget build(BuildContext context) {
    
        if (productsNC[logoindex].category == 'Veg') {
          return VegLogo();
        } else {
          return NonVegLogo();
        }
     
  }
}

class TIKLogoDecider extends StatelessWidget {
  final int logoindex;
  const TIKLogoDecider({
    super.key,
    required this.logoindex,
  });

  @override
  Widget build(BuildContext context) {
    
        if (productsTIK[logoindex].category == 'Veg') {
          return VegLogo();
        } else {
          return NonVegLogo();
        }
     
  }
}
