import 'package:flutter/material.dart';

class NCIntroduction extends StatefulWidget {
  const NCIntroduction({
    Key? key,
  }) : super(key: key);

  @override
  _NCIntroductionState createState() => _NCIntroductionState();
}

class _NCIntroductionState extends State<NCIntroduction> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 0,
                color: Color.fromARGB(64, 0, 0, 0))
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 250,
      width: 350,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Night Canteen',
                style: TextStyle(
                    fontFamily: 'Dropdown',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/Search.jpg',
                    height: 23,
                    width: 23,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/favourites.jpg',
                    height: 22,
                    width: 22,
                  )),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                'assets/icons/Star.jpg',
                height: 18,
                width: 18,
              ),
              const Text(
                '3.2',
                style: TextStyle(
                    fontFamily: "Dropdown",
                    fontSize: 15,
                    color: Color.fromARGB(255, 200, 151, 3)),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                '(200+ Ratings)',
                style: TextStyle(
                    fontFamily: 'Dropdown',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 106, 106, 106)),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/restaurantlocation.jpg',
                  height: 50,
                  width: 15,
                ),
              ),
              const Positioned(
                top: 0,
                right: 90,
                child: Text(
                  'Night Canteen',
                  style: TextStyle(
                      fontFamily: 'Dropdown',
                      fontSize: 11,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 105,
                child: Text(
                  'VSB',
                  style: TextStyle(
                      fontFamily: 'Dropdown',
                      fontSize: 11,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              const Positioned(
                top: 17.5,
                left: 110,
                child: Text(
                  'ETA: 10min',
                  style: TextStyle(
                      fontFamily: 'Dropdown',
                      fontSize: 11,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              )
            ],
          ),
          const Text(
            'Step into a lively atmosphere filled with the aroma',
            style: TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 12,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const Text(
            'of mouthwatering dishes and the sounds of',
            style: TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 12,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const Text(
            'laughter and conversations.',
            style: TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 12,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}
