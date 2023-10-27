import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _albumTitle = 'Loading...';
  String _bandName = '';

  Future<void> _fetchAlbumData() async {
    //random but not random because we only have 1 album
    final randomInt = Random().nextInt(1) + 1;

    final response = await http.get(Uri.parse(
        'https://album-service-maartenwilloque.cloud.okteto.net/api/album/$randomInt'));

    if (response.statusCode == 200) {
      // The request was successful, parse the JSON data
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final albumTitle = jsonData['title'];
      final bandName = jsonData['band']['name'];

      // Update the UI with the fetched data
      setState(() {
        _albumTitle = albumTitle;
        _bandName = bandName;
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Album of the day:',
              ),
              Text(
                _albumTitle,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "by: $_bandName",
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigation());
  }
}
