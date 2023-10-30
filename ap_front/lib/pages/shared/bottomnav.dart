import 'package:flutter/material.dart';

//this is the bottom navigation bar, consisting of 4 icons each leading to a different page

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return BottomAppBar(
        color: scheme.primary,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              String? currentRoute = ModalRoute.of(context)?.settings.name;
              if (currentRoute != '/home' && currentRoute != '/') {
                Navigator.of(context).pushNamed('/home');
              }
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/camera') {
                Navigator.of(context).pushNamed('/camera');
              }
            },
            icon: const Icon(
              Icons.camera,
              color: Colors.white,
            ),
          ),
          //open camera button
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/history') {
                Navigator.of(context).pushNamed('/history');
              }
            },
            icon: const Icon(
              Icons.book_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/review') {
                Navigator.of(context).pushNamed('/review');
              }
            },
            icon: const Icon(
              Icons.stars_outlined,
              color: Colors.white,
            ),
          ),
        ]));

    //just a comment
  }
}
