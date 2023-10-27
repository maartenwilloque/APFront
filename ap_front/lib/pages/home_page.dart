import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _fetchAlbumData() async {
    String _albumTitle = '';
    String _albumArtist = '';
    final response = await http.get(Uri.parse(
        'https://album-service-maartenwilloque.cloud.okteto.net/api/album/1'));

    if (response.statusCode == 200) {
      // The request was successful, parse the JSON data
      final jsonData = jsonDecode(response.body);
      final albumTitle = jsonData['title'];
      final albumArtist = jsonData['artist'];

      // Update the UI with the fetched data
      setState(() {
        _albumTitle = albumTitle;
        _albumArtist = albumArtist;
      });
    } else {
      // The request failed, handle the error
      throw Exception('Failed to fetch album data');
    }
  }

  @override
  void initState() {
    _fetchAlbumData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'popular albums',
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigation());
  }
}
