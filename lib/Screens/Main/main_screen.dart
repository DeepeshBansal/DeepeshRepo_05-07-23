import "package:flutter/material.dart";

class MainScreen extends StatelessWidget {
  static const String routeName = '/';

  const MainScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MainScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ElevatedButton(
        child: const Text('Location Screen'),
        onPressed: () {
          Navigator.pushNamed(context, '/addlocation');
        },
      ),
    );
  }
}
