import 'package:ap_front/apis/album_api.dart';
import 'package:ap_front/apis/thumbnail_api.dart';
import 'package:ap_front/models/album.dart';
import 'package:ap_front/pages/details.dart';
import 'package:ap_front/pages/shared/bottomnav.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageUrl = '';
  bool _isLoading = true;
  Album? album;

  Future<void> _getAlbum() async {
    await AlbumApi.fetchAlbum(1).then((result) {
      setState(() {
        album = result;
      });
    });

    await ThumbnailApi.fetchThumbnail(album!.band.name, album!.title)
        .then((result) {
      setState(() {
        _imageUrl = result;
      });
    });
    _isLoading = false;
  }

  void _goToDetailPage(BuildContext context, String id) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailPage(id: id)));
  }

  @override
  void initState() {
    super.initState();
    _getAlbum();
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
                style: TextStyle(fontSize: 30),
              ),
              Text(
                album!.title,
                style: const TextStyle(fontSize: 24),
              ),
              Text("by: ${album!.band.name}",
                  style: const TextStyle(fontSize: 24)),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Image.network(_imageUrl),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary),
                  onPressed: () {
                    _goToDetailPage(context, album!.albumId);
                  },
                  child: const Text('Details'))
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigation());
  }
}
