import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});
  final String title;
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('History Page'),
      ),
      bottomNavigationBar: MyBottomNavigation(),
      // Add your widgets here
    );
  }
}
