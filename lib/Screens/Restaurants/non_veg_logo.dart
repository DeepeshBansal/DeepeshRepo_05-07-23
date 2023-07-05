import 'package:flutter/material.dart';

class NonVegLogo extends StatelessWidget {
  const NonVegLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: ClipRRect(
        child: Image.asset('assets/icons/nonveglogo.jpg',
        fit: BoxFit.cover,),
        
      ),
    );
  }
}
