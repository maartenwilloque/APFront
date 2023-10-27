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
            onPressed: () => Navigator.of(context).pushNamed('/home'),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/camera'),

        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.stars_outlined),
            onPressed: //navigate to reviewPage
                () => Navigator.of(context).pushNamed('/review'),
          ),
          IconButton(
            onPressed: //navigate to camera Page
                () => Navigator.of(context).pushNamed('/camera'),

            icon: const Icon(Icons.camera),
          ),
          //open camera button
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/history'),
            icon: const Icon(Icons.book_rounded),
          ),
          IconButton(
            icon: const Icon(Icons.stars_outlined),
            onPressed: () => Navigator.of(context).pushNamed('/review'),
          ),
        ]));

    //just a comment
  }
}
