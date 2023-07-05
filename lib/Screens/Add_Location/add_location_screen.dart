import 'package:flutter/material.dart';

import '../../main.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  static const String routeName = '/addlocation';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const AddLocationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  List<String> options = <String>[
    'Choose Your Location',
    'VSB Hostel',
    'APJ Hostel',
    'CVR Hostel',
    'Devi Ahilya Hostel',
    'JC Bose Hostel',
    'HJ Bhabha Hostel',
    'Central Dining Facility',
    'POD Building',
    'Vidhyanchal Guest House',
    'Health Centre',
    'LRC-Swadyaya',
    'Abhinandan Bhavan',
    'Sports Complex',
    'Bal Hanuman Mandir',
    'La Fresco',
    'Lecture Hall Complex',
    'Narmada Housing',
    'Kshipra Housing',
    'Director Bunglow',
    'CITC Hub Building',
    'Central Workshop',
    'Central HVAC Plant',
    'Gate No. 1',
    'Gate No. 2',
    'Badminton Court',
    'Basketball Court',
    'Tennis Court',
    'Kendriya Vidhyalaya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: false,
        title: const Text(
          'ADD YOUR LOCATION',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const MapsButton(),
            const SizedBox(
              height: 75,
            ),
            const Center(
              child: CircleAvatar(
                radius: 32.5,
                backgroundColor: Color.fromARGB(255, 85, 85, 85),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 74, 74),
                      fontFamily: 'Dropdown',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(shrinkWrap: true, children: [
                InputDecorator(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 116, 116, 116),
                          width: 2.75),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(221, 152, 152, 152),
                            width: 15),
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: const EdgeInsets.all(17.0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconEnabledColor: const Color.fromARGB(254, 0, 0, 0),
                      iconSize: 30.0,
                      isDense: true,
                      isExpanded: true,
                      menuMaxHeight: 320,
                      value: locationdropdownvalue,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          locationdropdownvalue = value!;
                        });
                      },
                      style: const TextStyle(
                          fontFamily: 'Dropdown', color: Colors.black),
                      selectedItemBuilder: (BuildContext context) {
                        return options.map((String value) {
                          return Text(
                            locationdropdownvalue,
                            style: const TextStyle(
                                fontFamily: 'Dropdown',
                                fontSize: 19.5,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 34, 34, 34)),
                          );
                        }).toList();
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                              style: const TextStyle(
                                  fontFamily: 'Dropdown',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                              value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 150,
            ),
            SubmitButton(locationdropdownvalue: locationdropdownvalue),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.locationdropdownvalue, String});

  final String locationdropdownvalue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            side: const BorderSide(
                color: Color.fromARGB(255, 255, 129, 45), width: 5),
            backgroundColor: const Color.fromARGB(255, 255, 102, 1),
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            if (locationdropdownvalue == "Choose Your Location") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please Select A Location'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              print("user selected location :  $locationdropdownvalue");
              Navigator.pushNamed(context, '/search');
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

class MapsButton extends StatelessWidget {
  const MapsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 70,
      width: 400,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            side: const BorderSide(
                color: Color.fromARGB(179, 206, 204, 204), width: 3),
            backgroundColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/addlocation');
          },
          child: const Text(
            'Use Google Maps To Add Location',
            style: TextStyle(
                fontFamily: 'Dropdown',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 22, 22, 22)),
          )),
    );
  }
}
