import 'package:flutter/material.dart';

class VegLogo extends StatelessWidget {
  const VegLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: ClipRRect(
        child: Image.asset('assets/icons/veglogo.jpg',
        fit: BoxFit.cover,),
        
      ),
    );
    /*Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 2.5, color: const Color.fromARGB(255, 0, 143, 57))),
      child: Center(
        child: Icon(
          Icons.circle,
          color: Color.fromARGB(255, 0, 143, 57),
          size: 9,
        ),
      ),
    );*/
  }
}
