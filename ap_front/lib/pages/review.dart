import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is the review page.',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigation());
  }
}
