import 'package:flutter/material.dart';

//this is the bottom navigation bar, consisting of 4 icons each leading to a different page

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              String? currentRoute = ModalRoute.of(context)?.settings.name;
              if (currentRoute != '/home' && currentRoute != '/') {
                Navigator.of(context).pushNamed('/home');
              }
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/camera') {
                Navigator.of(context).pushNamed('/camera');
              }
            },
            icon: const Icon(Icons.camera),
          ),
          //open camera button
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/history') {
                Navigator.of(context).pushNamed('/history');
              }
            },
            icon: const Icon(Icons.book_rounded),
          ),
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/review') {
                Navigator.of(context).pushNamed('/review');
              }
            },
            icon: const Icon(Icons.stars_outlined),
          ),
        ]));

    //just a comment
  }
}
