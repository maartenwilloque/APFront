import 'package:flutter/material.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _albumTitle = '';
  String _bandName = '';
  String _bandId = '';
  String _imageUrl = '';
  List<String> songs = [];

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("test"),
      ),
      bottomNavigationBar: MyBottomNavigation(),
      // Add your widgets here
    );
  }
}
